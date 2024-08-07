# Customer Segmentation Using RFM Analysis

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/b62d5999-63b7-40aa-ba5f-e0fe6b22eb26)

## Business requirements

Businesses need to segment their customers into distinct groups based on demographic, geographic, psychographic, and behavioral data to better understand their needs and preferences. This segmentation will enable the development and implementation of tailored marketing campaigns for each group, enhancing customer engagement and satisfaction. The performance of these campaigns will be monitored and evaluated regularly to ensure effectiveness and identify areas for improvement.

## Process
### Business requirement analysis

For customer segmentation, we will base it on 3 factors: **R (Recency)** - Recent purchases, **F (Frequency)** - Frequency of purchases, and **M (Monetary**) - Monetary value, each corresponding to some key customer traits. 

Using RFM analysis is more effective for understanding customer behavior and tailoring marketing campaigns compared to segmentation based purely on age or geography. Here are some reasons why:

1. Behavioral Insights:

- Recency: Customers who have purchased recently are more likely to respond to promotions than those who haven't bought in a while.
- Frequency: Frequent buyers are usually more loyal and valuable, indicating a higher likelihood of repeat purchases.
- Monetary: High-spending customers can be targeted with premium offers or exclusive deals.

2. Personalization:

RFM analysis allows for more personalized marketing by targeting messages based on specific purchasing behaviors rather than broad demographic characteristics.

3. Customer Value:

RFM analysis helps identify high-value customers who contribute most to the revenue, enabling businesses to focus their efforts on retaining and nurturing these customers.

4. Lifecycle Marketing:

By understanding the buying patterns, businesses can implement lifecycle marketing strategies, engaging customers at different stages (e.g., new customers, loyal customers, lapsed customers).
Actionable Segmentation:

RFM provides actionable segments such as "champions" (high R, F, and M) and "at-risk" customers (high M, but low R), allowing for targeted and effective marketing strategies.

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/7b9af0f7-5f45-46fe-8eb5-504fc136e6c0)

Based on the combination of Recency, Frequency, and Monetary (R-F-M) values, I will segment all customers into 11 distinct groups, each with its own unique characteristics. 

| Segment | Score |  Description |
| --- | --- | --- |
| Champions | 555, 554, 544, 545, 454, 455, 445 | Users who have visited most recently, visited most frequently and spent the most. |
| Loyal Customers | 543, 444, 435, 355, 354, 345, 344, 335 | Users who visited recently visited often and spent a great amount |
| Potential Loyalist | 553, 551, 552, 541, 542, 533, 532, 531, 452, 451, 442, 441, 431, 453, 433, 432, 423, 353, 352, 351, 342, 341, 333, 323 | A recent user, who spent a good amount |
| New Customers | 512, 511, 422, 421 412, 411, 311 | Users visited most recently, but not often, and have not spent much |
| Promising | 525, 524, 523, 522, 521, 515, 514, 513, 425,424, 413,414,415, 315, 314, 313 | Average recency, frequency, and monetary scores |
| Need Attention | 535, 534, 443, 434, 343, 334, 325, 324 | Users have spent a good amount but long ago (not visited recently) |
| About To Sleep | 331, 321, 312, 221, 213, 231, 241, 251 | Below-average recency, frequency, and monetary values |
| At Risk | 255, 254, 245, 244, 253, 252, 243, 242, 235, 234, 225, 224, 153, 152, 145, 143, 142, 135, 134, 133, 125, 124 | Users visited most recently, and also often, but have not spent much |
| Cannot Lose Them | 155, 154, 144, 214,215,115, 114, 113 | The user has spent a great amount and visited often but long ago (not visited recently) |
| Hibernating customers | 332, 322, 233, 232, 223, 222, 132, 123, 122, 212, 211 | The user's last visit was long back, visits are not often, and has not spent much |
| Lost customers | 111, 112, 121, 131,141,151 | Lowest recency, frequency, and monetary scores which show low spending, low frequency, and haven't purchased in a long time. |


### Data process
**I. Create table and import data**
1. Create database in PostgresSQL
2. Create table SALES_DATASET_RFM_PRJ and import data
3. Change the data type of table SALES_DATASET_RFM_PRJ 
4. Create table SEGMMENT_SCORE that contains 11 distinct groups of customer segments and respective RPM scores

**II. Data cleaning**

**1. Check null/blank/duplicates**

For table SALES_DATASET_RFM_PRJ, by using the ISNULL() and ROW_NUMBER() function, I did not detect any NULL values or duplicate data.

However, with table SEGMMENT_SCORE I discovered 3 value 231, 241 and 251 were duplicated as were recorded in two segments: "About to Sleep" and "Hibernating customers" while they should only be categorized as "Hibernating customers". 

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/5158ccae-02e3-4ed9-af15-4f1c1ade5713)

Therfore I deleted three rows from table SEGMMENT_SCORE as below:

| Segment | Scores | 
| --- | --- | 
| About To Sleep | 231 |
| About To Sleep | 241 |
| About To Sleep | 251 |
  
**2. Cleaning Outliers**
For table SALES_DATASET_RFM_PRJ, I determined outliers using the z-score method.

First, I calculated the z-score for each data point, which measures the number of standard deviations a data point is from the mean. Identify outliers as those data points with a z-score greater than 3 or less than -3, indicating they are significantly different from the majority of the data. 

I discovered 14 extreme values and excluded them from the dataset, creating a new table SALES_DATASET_RFM_CLEAN with z-score of quantityorder between -3 and 3.

**III. Analyzing**

**1. Data Exploration:**

a. Revenue by ProductLine, Year  và DealSize. 

- Revenue by Productline

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/1504f4f3-d96a-49d8-b98a-cbd2b0d94d31)

- Revenue by YEAR
  
![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/1454c6f7-b7d7-4ece-93ef-c90822a29398)

- Revenue by Dealsize
  
![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/43a5f3b9-f0d9-4e98-a076-c7a899e3a940)
  
b. Which month has the best sales each year?

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/53a76ab4-2497-4694-b9cc-435cc987ffac)

c. Which product has the best revenue in the UK each year?

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/bf54a22a-9041-4be6-a7ff-3ca77e03a598)


**d. Who is the best customer based on RFM analysis? (we will jump in RFM analysis right now!!!)**

**2. Data processing using RFM method**

### R - F - M Analysis

I start my analyzing process by assigning Recency, Frequency & Monetary Values 

- **R - Recency** = I calculate the amount of time since the customer’s most recent transaction (days) by taking the current analysis date, obtained using the CURRENT_DATE function, and subtracting the last time each customer made a purchase by using the MAX() function.
- **F - Frequency** = To calculate the total number of transactions made by the customer, I use the COUNT() function to count the number of orders of each customer 
- **M - Monetary** = To calculate the total amount that the customer has spent across all transactions, I use the SUM() function to calculate the total sales.

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/12b6f021-6086-466a-87e8-a1d419e1169a)

Next, I divide the customer list into tiered groups for each of the three dimensions (R, F and M), specifically into 5 different levels by using the NTILE() Function

- For the F and M metrics, I assign levels from 1 to 5, ordered from smallest to largest.
- However, for the F metric, I will assign the levels in reverse order (5 is the smallest and 1 is the largest) because for the F metric, a smaller value indicates the customer has made a recent purchase, which should be assigned a better level, which is level 5

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/44e16ff8-11fa-43a4-875b-1b2843691815)

This could result in as many as 125 distinct customer segments (5x5x5), into which customers will be segmented into segmentation groups according to above table. However, as we have only 92 customers so we have the following rfm segmentation result:

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/50e89b05-274d-40bd-99dc-06d93f2f243d)

In terms of customer segmentation we have a table of the number of customer for each segment as follow:

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/48255f26-b6b4-4376-a7ed-aea710ceace4)

**And then I visualized the result with Treemap:** 

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/0369e6cd-3d64-4d5c-afe2-8a5187fd1386)

Based on RFM analysis, I can identify the best customers and categorize others into respective groups:

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/b68bd644-ae82-4a9e-b03c-d07378d3867b)


Source code: https://github.com/linhnguyen2601/SQL-Projects/blob/main/Customer%20Segmentation%20RFM/Customer%20Segmentation.sql

**Reference for table of customer segments**

"_What Are RFM Scores and How To Calculate Them_" https://connectif.ai/en/blog/what-are-rfm-scores-and-how-to-calculate-them/
