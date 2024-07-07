# Online Retail: Cohort Analysis

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/8250b800-cf06-478c-8bee-485f2cf70e0f)

## 1. Overview

### 1.1 Business Requirements

The Online Retail Cohort Analysis project aims to enhance customer retention by analyzing customer behavior over time. By grouping customers based on their initial purchase dates, we can identify trends and patterns in purchasing behavior and calculate key metrics such as retention rates, average order value (AOV), and customer lifetime value (CLV). 

This analysis will utilize customer purchase history, including transaction dates, spanning the past 12 months. The insights derived from this project will inform targeted marketing strategies and personalized customer engagement, ultimately leading to improved customer satisfaction and business performance.

### 1.2. Dataset introduction

The dataset for the Online Retail Cohort Analysis comprises 541,909 customer purchase history records for a year. Each entry includes critical details such as invoice number, product ID (stock code), invoice dates, unit price, quantity, and the corresponding customer ID. The dataset captures the sequence and frequency of purchases, enabling the calculation of retention rates, average order value (AOV), and customer lifetime value (CLV).

## 2. Data cleaning

### 2.1. Check data type, check null, check duplicates, 

Change data type: quantity to integer, invoicedate to date, unitprice to float.

Tổng số bản ghi: 541909 dòng

Check null

desciption is null: 1454
customerid: 135080 

Check duplicate: 5433 bản ghi

### 2.2. Check validation:
select * from online_retail
where quantity <= 0 or unitprice <= 0

=> 11805 bản ghi

Như vậy cần tạo bảng mới sau khi đã loại các dòng customerid bị null, quantity <= 0 và unitprice <=0 và duplicate.
Bảng mới online_retail_clean có 392668 bản ghi

## 3. Data analysis with Cohort analysis

### 3.1 Customer Cohort


### 3.2 Retention Cohort


### 3.3 


