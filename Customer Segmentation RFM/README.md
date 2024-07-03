# Customer Segmentation Using RFM Analysis

## Business requirements

Businesses need to segment their customers into different customer groups in order to understand their customers better and implement distinct campaigns targeting each different customer segment. 

## Process
### Business requirements analysis

For better customer segmentation, we will base it on 3 factors: **R (recency)** - recency of purchase, **F (frequency)** - purchase frequency, and **M (monetary**) - total order value.

Based on the combination of Recency, Frequency, and Monetary (R-F-M) values, I will segment all customers into 11 distinct groups, each with its own unique characteristics. The details are outlined in the table below
RFM stands for Recency, Frequency, and Monetary value, each corresponding to some key customer trait. These RFM metrics are important indicators of a customer’s behavior because frequency and monetary value affects a customer’s lifetime value, and recency affects retention, a measure of engagement.

Understanding the traits of each group and engaging them with relevant campaigns is more effective than segmentation based on customer age or geography.
![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/7b9af0f7-5f45-46fe-8eb5-504fc136e6c0)

Recent purchases: customers who make recent purchases are more likely to respond to promotions.
Frequency of purchases: customers who frequently buy products are more engaged and satisfied.
Monetary value: the monetary value of purchases can differentiate between heavy spenders and low-value purchasers.

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

Source code: 
