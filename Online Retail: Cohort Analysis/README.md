# Online Retail: Cohort Analysis

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/8250b800-cf06-478c-8bee-485f2cf70e0f)

## 1. Overview

### 1.1 Business Requirements

The Online Retail Cohort Analysis project aims to enhance customer retention by analyzing customer behavior over time. By grouping customers based on their initial purchase dates, we can identify trends and patterns in purchasing behavior and calculate key metrics such as retention rates, average order value (AOV), and customer lifetime value (CLV). 

This analysis will utilize customer purchase history, including transaction dates, spanning the past 12 months. The insights derived from this project will inform targeted marketing strategies and personalized customer engagement, ultimately leading to improved customer satisfaction and business performance.

### 1.2. Dataset introduction

The dataset for the Online Retail Cohort Analysis comprises 541,909 customer purchase history records for a year. Each entry includes critical details such as invoice number, product ID (stock code), invoice dates, unit price, quantity, and the corresponding customer ID. The dataset captures the sequence and frequency of purchases, enabling the calculation of retention rates, average order value (AOV), and customer lifetime value (CLV).

## 2. Data cleaning

### 2.1. Data Quality Checks: Data Type Validation, Null Values, and Duplicates

To ensure accurate analysis and data integrity, the dataset underwent data type adjustments for specific columns:

- Quantity to Integer: The quantity field, representing the number of items purchased in each transaction, has been converted to an integer type to accurately reflect whole item counts and facilitate mathematical operations.

- InvoiceDate to Date: The invoicedate field, indicating the date of each transaction, has been converted to a date type. This ensures proper handling of date-related operations such as sorting, filtering, and date arithmetic.

- UnitPrice to Float: The unitprice field, denoting the price per unit of product, has been converted to a float type. This change allows for precise representation of decimal values, enabling accurate financial calculations and analysis.

Results of Null Value Check:

| # | Columns |   Null count |
| --- | --- | --- |   
| 1 | invoiceno | 0 |
| 2 | stockcode | 0 |
| 3 | description | 1454 |
| 4 | quantity | 0|
| 5 | invoicedate | 0|
| 6 | unitprice | 0 |
| 7 | customerid | 135080 |
| 8 | country | 0 |

Results of Duplicate Value Check: 5433 entries

### 2.2. Data Validation for Columns Requiring Values Greater Than 0:

There are a total of 11,805 records where either the quantity or unit price values are less than zero.

Therefore, I create a new table after filtering out rows with null customer IDs, quantity ≤ 0, unit price ≤ 0, and duplicates.

The new table, online_retail_clean, contains 392,668 records.

## 3. Data Exploratory

```
select count(distinct(invoiceno)) as count_invoiceno,
	count(distinct(stockcode)) as count_stockcode,
	count(distinct(description)) as count_description,
	count(distinct(country)) as count_country from online_retail_clean
```

![image](https://github.com/user-attachments/assets/53b544d0-09cd-4732-a30d-48e07bd34c51)

```
select stockcode, count(Distinct(description)) from online_retail_clean
group by stockcode
order by count(Distinct(description)) desc
```

![image](https://github.com/user-attachments/assets/6d238796-684a-428d-9ce8-74c1ea878233)


```
select stockcode, description,
  round(cast(sum(quantity*unitprice) as numeric),2) as revenue, 
	round(
	cast(sum(quantity*unitprice)*100/(select Sum(quantity*unitprice) from online_retail_clean) as numeric)
	,2) as percentage
	from online_retail_clean
group by stockcode, description
order by sum(quantity*unitprice) desc
```

![image](https://github.com/user-attachments/assets/f6435896-fd73-4e72-ae6d-6c915d8d828b)

```
select country, round(cast(sum(quantity*unitprice) as numeric),2) as revenue, 
	round(
	cast(sum(quantity*unitprice)*100/(select Sum(quantity*unitprice) from online_retail_clean) as numeric)
	,2) as percentage
	from online_retail_clean
group by country
order by sum(quantity*unitprice) desc
```

![image](https://github.com/user-attachments/assets/6c10815f-bf85-4102-aa55-66705ca97425)

```
UPDATE online_retail_clean
SET country = 'Ireland'
WHERE country = 'EIRE'
```

![image](https://github.com/user-attachments/assets/b08ab9ae-ca34-43e4-a837-eb92ac7e4dce)


## 4. Data analysis with Cohort analysis: Results and Dashboard

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/f9521853-836c-4cb0-b5ee-8b8b702d8b11)

### 4.1 Customer Cohort

Customer cohorts are groups of customers identified by the month they first engaged with a product or service. Measurement involves tracking their behavior and performance over time to understand retention, purchasing patterns, and lifetime value.

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/2ef859c8-44ba-4e0a-9d76-f59060a55ff5)


### 4.2 Retention Cohort

A retention cohort measured in months for 13 months involves analyzing groups of customers based on the month they first engaged with a product or service. Each cohort represents customers who started their relationship in a specific month, and retention is tracked over the following 12 months to observe how many customers remain engaged or active over time. This approach helps businesses understand long-term customer retention trends and assess the effectiveness of retention strategies implemented over monthly intervals.

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/565571d6-d836-4ad4-bf0f-c8a548b03e94)

### 4.3 Churn Cohort

A churn cohort measured in months for 13 months involves analyzing groups of customers based on the month they first engaged with a product or service. Each cohort represents customers who started their relationship in a specific month, and churn is tracked over the following 12 months to observe how many customers discontinue their engagement or become inactive over time. 

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/dd718147-559c-469c-945a-ea353fb3f83c)

## 5. Solutions:

After conducting a cohort analysis, the insights lead to various actionable solutions to enhance customer experience, increase retention, and drive sales. Here are some potential solutions based on common findings from such an analysis:

### 5.1. Improving Customer Retention

- Personalized Retention Strategies: Develop personalized follow-up strategies based on customer purchase behavior. This could include tailored email campaigns, personalized product recommendations, and exclusive offers for returning customers.

- Loyalty Programs: Introduce or enhance loyalty programs to reward repeat customers with points, discounts, or early access to new products.

### 5.2. Enhancing Marketing Efforts

- Targeted Campaigns: Create targeted marketing campaigns for different cohorts based on their shopping behaviors. For example, new customers might receive a welcome discount, while frequent buyers get access to VIP sales.

- Segmentation: Segment customers into specific groups (e.g., high spenders, frequent buyers) and tailor marketing messages accordingly.

### 5.3. Optimizing Product Offerings

- Popular Product Focus: Identify which products are most popular among long-term customers and stock these items accordingly.

- Product Feedback: Use feedback from different cohorts to improve product offerings. For example, if a specific product has high returns, investigate and address potential issues.

### 5.4. Enhancing User Experience

- Website Optimization: Improve website navigation and user interface based on cohort behavior analysis. Ensure that the most popular products are easy to find and that the checkout process is streamlined.

- Mobile Experience: Enhance the mobile shopping experience if mobile usage is high among certain cohorts.

### 5.5. Pricing and Promotions

- Dynamic Pricing: Implement dynamic pricing strategies to offer competitive prices based on customer behavior and market trends.
- Seasonal Promotions: Develop seasonal or event-based promotions targeted at specific cohorts who are more likely to respond to such offers.

### 5.6. Customer Support Improvements

- Proactive Support: Provide proactive customer support for new customers to ensure a smooth shopping experience and address any issues promptly.
- Self-Service Options: Enhance self-service options such as FAQs, chatbots, and detailed product information to assist customers efficiently.

### 5.7. Inventory Management

- Demand Forecasting: Use cohort analysis to forecast demand for specific products and manage inventory accordingly. This helps in reducing stockouts and overstock situations.
- Supplier Collaboration: Work closely with suppliers to ensure timely restocking of popular items identified through cohort analysis.

### 5.8. Shipping and Fulfillment

- Shipping Options: Offer multiple shipping options based on customer preferences and behaviors. For example, some cohorts may prefer faster shipping even at a higher cost.

- Fulfillment Efficiency: Improve fulfillment processes to ensure timely and accurate order deliveries, which can enhance customer satisfaction and retention.

### 5.9. Cross-Selling and Upselling

- Personalized Recommendations: Use insights from cohort analysis to offer personalized product recommendations that align with customers' past purchases.

- Bundle Offers: Create product bundles that appeal to specific cohorts, encouraging customers to buy more items at once.

### 5.10. Analyzing and Adjusting Strategy

- Continuous Monitoring: Regularly monitor cohort performance and adjust strategies as needed to address changes in customer behavior.

- Feedback Loops: Implement feedback loops to continuously gather and act on customer insights, ensuring that the business remains responsive to customer needs.
  
By implementing these solutions based on the insights gained from cohort analysis, online retail businesses can better understand their customers, improve retention rates, and drive higher sales and profitability.
