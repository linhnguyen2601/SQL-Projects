# Transaction of debit card customers

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/70e2bf1c-2727-446d-9100-e747349cbffc)

## 1. Introduction

### 1.1. Context:
For any bank, analyzing customer transaction data is extremely crucial. Transaction data not only provides detailed information about customers' financial behaviors but also helps banks better understand their needs and desires. Through data analysis, banks can identify consumer trends, early detect potential risks, and make informed business decisions. This not only enhances customer experience but also optimizes bank operations, thereby increasing competitiveness and sustainable development in the volatile financial market.

Bank X is currently facing intense competition and rapid changes in customer spending habits. To maintain its leading position, the bank needs a deeper understanding of how customers use their debit cards. Analyzing debit card transaction data helps the bank not only identify spending and saving patterns but also provides profound insights into preferred services and products among customers. Consequently, Bank X can optimize promotional programs, personalize services, and develop new products tailored to customers' actual needs. Moreover, this effort helps the bank detect fraudulent behaviors early, enhancing security and customer trust.

The dataset data_bank.customer_transactions includes debit card transactions of customers from January to April 2020, with the following information:

| # | Columns |  Description |
| --- | --- | --- |   
| 1 | customer_id | customer ID |
| 2 | txn_date | transaction date |
| 3 | txn_type | transaction type (deposit, withdrawal, purchase) |
| 4 | txn_amount | transaction amount |

### 1.2. Business Requirements:

Answer the following questions:

- How many transactions and what is the total amount for each transaction type? What is the average number and amount of deposit transactions for all customers?

- What is the monthly trend in the number of transactions for each transaction type?
Which customers have the highest transaction amounts on average per month?

- In each month, how many customers of the bank make more than one deposit and one purchase or one withdrawal in a month?

- What is the end-of-period balance for each customer at the end of the month?

- What percentage of customers increase their end-of-period balance by more than 5%?

## 2. Data cleaning

### 2.1. Data Quality Checks: Data Type Validation, Null Values, and Duplicates
```
select * from data_bank.customer_transactions
where customer_id is null
or txn_date is null 
or txn_type = ' '
or  txn_type is null
```

```
select * from (
select customer_id,txn_date,txn_type, txn_amount,
row_number() over(partition by customer_id, txn_date, txn_type, txn_amount) as stt from data_bank.customer_transactions) as a
where stt > 1
```
There is no null value and duplicate value.

## 3. Analysis

### 3.1. How many transactions and what is the total amount for each transaction type? What is the average number and amount of deposit transactions for all customers?
```
select txn_type, sum(txn_amount), count(txn_amount)
  from data_bank.customer_transactions
  group by txn_type
UNION
select '', sum(txn_amount), count(txn_amount)
  from data_bank.customer_transactions
```

| # | Transaction type |  Total amount | Number of transaction|
| --- | --- | --- |   --- |
| 1 | deposit	 | 1,359,168.0  | 2,671|
| 2 | purchase | 806,537.0   | 1,617|
| 3 | withdrawal	 | 793,003.0   | 1,580|
||Grand Total|2,958,708.0 |5,868|

### 3.2. What is the monthly trend in the amount, the number of transactions for each transaction type?

```
select extract(month from txn_date) as month, 
sum(case when txn_type = 'deposit' then txn_amount else 0 end) as deposit_amount,
sum(Case when txn_type = 'withdrawal' then txn_amount else 0 end) as withdrawal_amount,
sum(case when txn_type = 'purchase' then txn_amount else 0 end) as purchase_amount
from data_bank.customer_transactions
group by month
order by month
```
![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/87439a2b-1031-4b5d-a36a-73ab57b0df83)

```
select extract(month from txn_date) as month, 
sum(case when txn_type = 'deposit' then 1 else 0 end) as count_deposit,
sum(Case when txn_type = 'withdrawal' then 1 else 0 end) as count_withdrawal,
sum(case when txn_type = 'purchase' then 1 else 0 end) as count_purchase
from data_bank.customer_transactions
group by month
order by month
```
![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/b1350071-b426-4caa-ac15-09bed871b14f)

```
with cte as(
select extract(month from txn_date) as month, txn_type, count(distinct(customer_id)) as total_customer
from data_bank.customer_transactions
group by month, txn_type)
select month, 
sum(case when txn_type = 'deposit' then total_customer else 0 end) as deposit_customer,
sum(case when txn_type = 'withdrawal' then total_customer else 0 end) as withdrawal_customer,
sum(case when txn_type = 'purchase' then total_customer else 0 end) as purchase_customer
from cte
group by month
order by month
```
![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/4792a586-4491-4dcd-b97b-b3691cb3bd46)


### 3.3. In each month, how many customers of the bank make more than one deposit or one purchase or one withdrawal in a month?

```
with cte as(
select Customer_id, extract(month from txn_date) as month, txn_type, count(txn_amount) as number_of_turn from data_bank.customer_transactions
group by Customer_id, month, txn_type
having count(txn_amount) > 1)
select month, count(Customer_id) as number_of_customers from cte
group by month
order by month
```

| Month | Number_of_customers |
| --- | --- | 
| 1 | 375 |
| 2 | 467 |
| 3 | 519 |
| 4 | 185 |

### 3.4. What is the end-of-period balance for each customer at the end of the month?

Tính balance cho tháng cuối cùng:
```
with cte as(
select Customer_id, 
sum(case when txn_type = 'withdrawal' then txn_amount else 0 end) as withdrawal_amount,
sum(case when txn_type = 'deposit' then txn_amount else 0 end) as deposit_amount,
sum(case when txn_type = 'purchase' then txn_amount else 0 end) as purchase_amount
from data_bank.customer_transactions
group by customer_id 
order by Customer_id)

select customer_id, deposit_amount - purchase_amount - withdrawal_amount as balance
from cte
```

### 3.5. What percentage of customers increase their end-of-period balance by more than 5%?

Tính balance cho mỗi kì:
```
with cte as(
select extract(month from txn_date) as month, Customer_id, 
sum(case when txn_type = 'withdrawal' then txn_amount else 0 end) as withdrawal_amount,
sum(case when txn_type = 'deposit' then txn_amount else 0 end) as deposit_amount,
sum(case when txn_type = 'purchase' then txn_amount else 0 end) as purchase_amount
from data_bank.customer_transactions
group by month, customer_id 
order by Customer_id, month)

select month, customer_id, deposit_amount - purchase_amount - withdrawal_amount as balance
from cte
```

```
with cte as(
  select extract(month from txn_date) as month, Customer_id, 
    sum(case when txn_type = 'withdrawal' then txn_amount else 0 end) as withdrawal_amount,
    sum(case when txn_type = 'deposit' then txn_amount else 0 end) as deposit_amount,
    sum(case when txn_type = 'purchase' then txn_amount else 0 end) as purchase_amount
    from data_bank.customer_transactions
    group by month, customer_id 
    order by Customer_id, month),
cte2 as (
  select month, customer_id, deposit_amount - purchase_amount - withdrawal_amount as balance
    from cte),
cte3 as(
  select month, customer_id, balance,
  lead(balance) over(partition by customer_id order by month) as next_balance from cte2),
cte4 as(
  select month, customer_id, (next_balance - balance)*100.0/balance as balance_change from cte3
    where (next_balance - balance)*100.0/balance > 5)
select count(distinct(Customer_id))*100.0/(select count(Distinct(customer_id)) from data_bank.customer_transactions) from cte4
```

Result: 53.8% of customers increase their end-of-period balance by more than 5%

```
with cte as (
select *, 
min(txn_date) over(partition by customer_id) as first_transaction from data_bank.customer_transactions
), 
cte2 as (
select *, extract(month from txn_date) - extract(month from first_transaction) + 1 as cohort_index from cte
),
cte3 as (
select to_char(first_transaction, 'YYYY-mm') as month_year, cohort_index, count(Distinct(customer_id)) as count_customer, sum(txn_amount) from cte2
group by to_char(first_transaction, 'YYYY-mm'), cohort_index
)
select month_year,
sum(case when cohort_index = 1 then count_customer else 0 end) as m1,
sum(case when cohort_index = 2 then count_customer else 0 end) as m2,
sum(case when cohort_index = 3 then count_customer else 0 end) as m3,
sum(case when cohort_index = 4 then count_customer else 0 end) as m4
from cte3
group by month_year
```

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/8ffe78fd-4d55-4ba4-b7ef-55ae0938fe8b)

The data indicates that there were no new customers in the three months following the initial month
