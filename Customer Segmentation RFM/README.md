# Customer Segmentation Using RFM Analysis

## Business requirements

Businesses need to segment their customers into different customer groups in order to understand their customers better and implement distinct campaigns targeting each different customer segment. 

## Process
### Business requirements analysis

For customer segmentation, we will base it on 3 factors: **R (Recency)** - Recent purchases, **F (Frequency)** - Frequency of purchases, and **M (Monetary**) - Monetary value, each corresponding to some key customer traits. 

Using RFM nalysis can be more effective for understanding customer behavior and tailoring marketing campaigns compared to segmentation based purely on age or geography. Here are some reasons why:

1. Behavioral Insights:

Recency: Customers who have purchased recently are more likely to respond to promotions than those who haven't bought in a while.
Frequency: Frequent buyers are usually more loyal and valuable, indicating a higher likelihood of repeat purchases.
Monetary: High-spending customers can be targeted with premium offers or exclusive deals.

2. Personalization:

RFM analysis allows for more personalized marketing. You can target messages based on specific purchasing behaviors rather than broad demographic characteristics.

3. Customer Value:

It helps identify high-value customers who contribute most to the revenue, enabling businesses to focus their efforts on retaining and nurturing these customers.

4. Lifecycle Marketing:

By understanding the buying patterns, businesses can implement lifecycle marketing strategies, engaging customers at different stages (e.g., new customers, loyal customers, lapsed customers).
Actionable Segmentation:

RFM provides actionable segments such as "champions" (high R, F, and M) and "at-risk" customers (high M, but low R), allowing for targeted and effective marketing strategies.

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/7b9af0f7-5f45-46fe-8eb5-504fc136e6c0)

Based on the combination of Recency, Frequency, and Monetary (R-F-M) values, I will segment all customers into 11 distinct groups, each with its own unique characteristics. 





### Data process
I. Create table and import data
1. Create database in PostgresSQL
2. Create table SALES_DATASET_RFM_PRJ and import data
3. Change the data type of table SALES_DATASET_RFM_PRJ 
4. Create table that contains 11 distinct groups of customer segments and respective RPM scores

II. Data cleaning
1. Check null/blank/duplicates
2. Cleaning Outliers

III. Analyzing
1. Key metrics
2. RFM
### R - F - M Analysis

I start my analyzing process by calculating the 3 metrics R, F, and M: 

- **R - Recency** = I calculate this by taking the current analysis date, obtained using the CURRENT_DATE function, and subtracting the last time each customer made a purchase by using the MAX() function.
- **F - Frequency** = To calculate the frequency, which represents how many times each customer has purchased, I use the COUNT() function to count the number of orders for each customer
- **M - Monetary** = To understand how much money each customer has spent on purchases, I use the SUM() function to calculate the total sales amount for each customer.

Next, I divide the values of each recency, frequency, and monetary into 5 different levels by using the NTILE() Function

- For the F and M metrics, I assign levels from 1 to 5, ordered from smallest to largest.
- However, for the F metric, I will assign the levels in reverse order (5 is the smallest and 1 is the largest) because for the F metric, a smaller value indicates the customer has made a recent purchase, which should be assigned a better level, which is level 5

Source code: 
