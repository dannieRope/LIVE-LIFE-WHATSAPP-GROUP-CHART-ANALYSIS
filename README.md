# LIVE LIFE WHATSAPP GROUP CHART ANALYSIS

Cleaning and analysing WhatsApp group chat data as well as report design in PowerBI

# INTRODUCTION 

WhatsApp plays a significant role in our lives by facilitating rapid communication between friends, family, and coworkers. 
However, have you ever considered what intriguing content those chat logs might contain? To uncover hidden insights in the LIVE LIFE WhatsApp group chat logs, I started this project.
Live Life is a group of young people got together and made the decision to use donations to support those in need and share links to job opportunities. 
The Project documentation includes:

- **Objectives**

- **Data Gathering**

- **Data Transformation**

- **Data Modeling**

- **Measures**

- **Visualization**

- **Insights and Recommendations**

- **Conclusion**

## OBJECTIVES

The goal of this project is to uncover concealed insights within the Live Life WhatsApp group chat logs. By the project's conclusion, the following questions should be addressed:

1. Identify the types of messages sent and their respective proportions.
   
2. Determine the total number of participants in the group.
  
3. Identify and list the top 10 most active participants.
 
4. Pinpoint the peak day and hour of message activity.
  
5. Analyse and report on the most frequently used words in the group.
    
6. Examine and understand message trends over different months.

# DATA GATHERING 

To get the data for cleaning, I just exported the group chat by clicking the ellipsis in the upper right corner of the group chat and choosing "Export Chat" to obtain the WhatsApp chat data.
The exported chat comes as a text file. However, with this method, one is limited to only 40,000 messages (without media). Below is an image of the text file exported. 

# DATA TRANSFORMATION
The text file had messy and unstructured data, which required transformation to make it easier for analysis. Power Query was used for this purpose. The transformation process involved the following steps:

1. **Splitting columns:**
   - Breaking down one column into multiple columns based on certain criteria.

2. **Merging columns:**
   - Combining information from different columns into a single column.

3. **Transforming columns:**
   - Adjusting the content or format of specific columns for better analysis.

4. **Filtering rows:**
   - Selecting and keeping only the rows that meet specific criteria.

5. **Renaming columns:**
   - Giving more meaningful names to columns for clarity.

6. **Replacing values:**
   - Substituting specific values with others as needed.

After applying these processes, the data became free of null values, duplicates, inconsistencies, and inappropriate data types. It's worth noting that messages automatically generated when the group admin performs actions such as adding someone to the group, changing the group name, or removing someone were excluded from the transformed data.
Here is the Power Query Script to [Clean the WhatsApp Text file](CleaningWhatSappData.pq)

# DATA MODELING

Three tables are employed in the data modeling process:

1. **WhatsApp Data Table:**
   - Contains messages, their timestamps, and sender information.
   - Columns: Date, Hour, Message, User ID, Time, Message Type.

2. **User Table:**
   - Comprises a unique list of group members along with their user IDs.
   - Columns: User, User ID.

3. **Calendar Table:**
   - Functions as a standard date table.
   - Columns: Date, Day, Month, Month Name, Month-Year, Weekday Name, Weekday, Year.

After the creation of these tables, necessary relationships are established, resulting in the following structure.


# MEASURES CREATED

The following measures were established to determine key metrics:

1. **Messages:**
   - Total count of messages sent.
   ```dax
   Messages = COUNT(WhatSappData[Message])
   ```

2. **Total Users:**
   - Total number of group members.
   ```dax
   TotalUsers = DISTINCTCOUNT(Users[UserID])
   ```

3. **Peak Hour:**
   - Hour with the highest number of messages.
   ```dax
   PeakHour =
      CALCULATE(
         SELECTEDVALUE(WhatSappData[Hour]),
         TOPN(1, SUMMARIZE(WhatSappData, WhatSappData[Hour], "MessageCount", [Messages]), [MessageCount], DESC)
      )
   ```

4. **Average Messages per day:**
   - The average number of messages sent in a day.
   ```dax
   AvgMessageperday = AVERAGEX(SUMMARIZE(WhatSappData, 'Calendar'[Date], "MessageCount", [Messages]), [MessageCount])
   ```





