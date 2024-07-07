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

## 3. Data analysis with Cohort analysis: Results and Dashboard

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/f9521853-836c-4cb0-b5ee-8b8b702d8b11)

### 3.1 Customer Cohort


### 3.2 Retention Cohort


### 3.3 


