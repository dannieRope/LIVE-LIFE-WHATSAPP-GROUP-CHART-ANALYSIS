# LIVE LIFE WHATSAPP GROUP CHAT ANALYSIS

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
The exported chat comes as a text file. However, with this method, one is limited to only 40,000 messages (without media).

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

Preview of the clean data
![Preview of clean chat](https://github.com/dannieRope/LIVE-LIFE-WHATSAPP-GROUP-CHART-ANALYSIS/assets/132214828/210c9be5-aeee-485d-b6ef-50bcde9d2ec7)


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

# DATA VISUALIZATION

1. Identify the types of messages sent and their respective proportions.
- Utilizing a donut chart, I visually represented the types of messages and their respective proportions by examining the message type column in the WhatsApp Data table.

![message type chart](https://github.com/dannieRope/LIVE-LIFE-WHATSAPP-GROUP-CHART-ANALYSIS/assets/132214828/665fb229-fe67-489e-9b8d-de9d50fb6116)


2. Determine the total number of participants in the group.
- Employing a card visual, I showcased the total number of group participants through the Total users measure, providing a clear overview.

![total members card](https://github.com/dannieRope/LIVE-LIFE-WHATSAPP-GROUP-CHART-ANALYSIS/assets/132214828/78409a5f-f9ba-48f0-a0de-1b5fbe602445)


3. Identify and list the top 10 most active participants.

- Using a bar chart, I identified and listed the top 10 group participants, offering a visual representation of their significance.

![top 10 members](https://github.com/dannieRope/LIVE-LIFE-WHATSAPP-GROUP-CHART-ANALYSIS/assets/132214828/d75a851f-8418-4651-9e27-c8d73904c571)


4. Pinpoint the peak day and hour of message activity.

- The application of a treemap allowed me to pinpoint peak hours and days when the group exhibited heightened activity.

![peak hour and day](https://github.com/dannieRope/LIVE-LIFE-WHATSAPP-GROUP-CHART-ANALYSIS/assets/132214828/44861791-8682-4fe7-ae83-38b9ef851587)


5. Analyse and report on the most frequently used words in the group.

- Employing a word cloud, I visually presented the most frequently used words, offering insights into communication patterns.

![Most used words](https://github.com/dannieRope/LIVE-LIFE-WHATSAPP-GROUP-CHART-ANALYSIS/assets/132214828/a4cf9da2-6b24-4f17-bef3-6f5aecf6181a)


6. Examine and understand message trends over different months.
- A line chart was utilized to comprehend the message trend over the months, as illustrated in the image below.

![Trend monthly](https://github.com/dannieRope/LIVE-LIFE-WHATSAPP-GROUP-CHART-ANALYSIS/assets/132214828/20c51862-237e-47c7-b793-be4df7996aa4)

I also used card visuals to display key metrics such as the average message per day, total number of messages, Peak hour etc. 

## DASHBOARD
Bringing all everything together, I developed an interactive dashboard that showcases essential metrics and provides valuable insights to users. This allows users to easily monitor and assess their performance in the group. Click [here](https://app.powerbi.com/view?r=eyJrIjoiNDNmNjViZWQtMzEwMC00ZWQ0LWE3NWEtODU2MzFkY2M0ZTJiIiwidCI6ImNlZjJkNzc5LWIxMWMtNDMxNy1iYWUxLWY2N2UwNDQ2ZjlhNiJ9) to interact with the dashboard. 

![Screenshot (451)](https://github.com/dannieRope/LIVE-LIFE-WHATSAPP-GROUP-CHART-ANALYSIS/assets/132214828/56f25dc9-75cb-4d30-a00f-da515d9e79a5)


![chart analysis](https://github.com/dannieRope/LIVE-LIFE-WHATSAPP-GROUP-CHART-ANALYSIS/assets/132214828/1bd3fa11-82e7-4722-8e94-abdc914b5340)



# INSIGHTS AND RECOMMENDATIONS

# **Insights:**

1. **Message Types:**
   - Most messages are either plain text or include pictures and videos. Around 79% are text, and 30% have media content.

2. **Common Words:**
   - Words like "The," "to," "you," and "and" pop up a lot in our text messages.

3. **Top Users:**
   - User14 sends the most messages (466), followed by User2 (286). These users are really active.

4. **Monthly Message Trends:**
   - Messages varied each month. We had a lot in May 2023 (804), a drop in June, but then it picked up until February 2024, where it peaked at 1702. Something interesting might be happening here.

5. **Active Days and Hours:**
   - Tuesdays (609 messages) and Wednesdays (545 messages) are the busiest days. Also, 7:00 PM is the time when most people are talking.

# **Recommendation:**
- **Dig Deeper:**
   - Conduct a detailed analysis of the content and context behind the fluctuating monthly message trends to identify influencing factors.
- **Celebrate Active Users:**
   - Acknowledge and thank User14 and User2 for being super active. Maybe others will get inspired.

- **Time It Right:**
   - Plan important messages for Tuesdays and Wednesdays, especially around 7:00 PM when most people are around.

These simple steps can make our group communication better and more enjoyable.

# CONCLUSION

I had a great time working on this project. I hope the Power Query Script and instructions are helpful for you to try it with your own data. There could be improvements in the future.

Unfortunately, I can't share the .pbix file for privacy reasons. But you can check out the interactive report to see how it works and what it looks like. [WhatSapp Chat Analysis](https://app.powerbi.com/view?r=eyJrIjoiNDNmNjViZWQtMzEwMC00ZWQ0LWE3NWEtODU2MzFkY2M0ZTJiIiwidCI6ImNlZjJkNzc5LWIxMWMtNDMxNy1iYWUxLWY2N2UwNDQ2ZjlhNiJ9)





