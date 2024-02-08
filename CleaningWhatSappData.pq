let
    Source = Csv.Document(File.Contents("C:\Users\dAgDaN\Downloads\WhatsApp Chat with AFFLUENCE GLOBAL ProsPects.txt"),[Delimiter=",", Columns=9, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type text}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}}),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Changed Type", "Column3", Splitter.SplitTextByDelimiter(":", QuoteStyle.Csv), {"Column3.1", "Column3.2"}),
    #"Merged Columns" = Table.CombineColumns(#"Split Column by Delimiter",{"Column3.2", "Column4", "Column5", "Column6", "Column7", "Column8", "Column9"},Combiner.CombineTextByDelimiter(" ", QuoteStyle.None),"Message"),
    TransformColumns = Table.TransformColumns(#"Merged Columns",{{"Column1", each try Date.From(_) otherwise null , Date.Type},
                                                                {"Column2", each try DateTime.ToText(DateTime.From(_),"h:mm tt") otherwise null, type time}}),
    #"Filtered Rows" = Table.SelectRows(TransformColumns, each ([Column1] <> null) and ([Message] <> "      " and [Message] <> "       " and not Text.Contains([Column3.1],"added"))),
    #"Removed Top Rows" = Table.Skip(#"Filtered Rows",1),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Top Rows",{{"Column1", "Date"}, {"Column2", "Time"}, {"Column3.1", "User"}}),
    Message = Table.TransformColumns(
    #"Renamed Columns",{{"Message", each Replacer.ReplaceText(Replacer.ReplaceText(_, ">", ""), "<", ""), type text}}),
    #"Replaced Value" = Table.ReplaceValue(Message,"omitted","",Replacer.ReplaceText,{"Message"}),
    SelectColumns = #"Replaced Value"[[User]],
    #"Removed Duplicates" = Table.Distinct(SelectColumns),
    #"Added Index" = Table.AddIndexColumn(#"Removed Duplicates", "Index", 1, 1, Int64.Type),
    #"Added Prefix" = Table.TransformColumns(#"Added Index", {{"Index", each "User" & Text.From(_, "en-GB"), type text}}),
    #"Renamed Columns1" = Table.RenameColumns(#"Added Prefix",{{"User", "Members"}, {"Index", "UserID"}}),
    Join = Table.Join(#"Replaced Value","User",#"Renamed Columns1","Members",JoinKind.LeftOuter),
    #"Removed Columns" = Table.RemoveColumns(Join,{"Members"}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Removed Columns",{{"Time", type time}}),
    #"Removed Columns1" = Table.RemoveColumns(#"Changed Type1",{"User"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Removed Columns1",{"UserID", "Date", "Time", "Message"})
in
    #"Reordered Columns"
