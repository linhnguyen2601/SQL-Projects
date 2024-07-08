Transaction of debit card customers

![image](https://github.com/linhnguyen2601/SQL-Projects/assets/166676829/70e2bf1c-2727-446d-9100-e747349cbffc)

# 1. Introduction

## 1.1 Context:
For any bank, analyzing customer transaction data is extremely crucial. Transaction data not only provides detailed information about customers' financial behaviors but also helps banks better understand their needs and desires. Through data analysis, banks can identify consumer trends, early detect potential risks, and make informed business decisions. This not only enhances customer experience but also optimizes bank operations, thereby increasing competitiveness and sustainable development in the volatile financial market.

Bank X is currently facing intense competition and rapid changes in customer spending habits. To maintain its leading position, the bank needs a deeper understanding of how customers use their debit cards. Analyzing debit card transaction data helps the bank not only identify spending and saving patterns but also provides profound insights into preferred services and products among customers. Consequently, Bank X can optimize promotional programs, personalize services, and develop new products tailored to customers' actual needs. Moreover, this effort helps the bank detect fraudulent behaviors early, enhancing security and customer trust.

The dataset data_bank.customer_transactions includes debit card transactions of customers, with the following information:

customer_id: customer ID
txn_date: transaction date
txn_type: transaction type (deposit, withdrawal, purchase)
txn_amount: transaction amount

## 1.2. Business Requirements:

Answer the following questions:

How many transactions and what is the total amount for each transaction type?
What is the average number and amount of deposit transactions for all customers?
In each month, how many customers of the bank make more than one deposit and one purchase or one withdrawal in a month?
What is the end-of-period balance for each customer at the end of the month?
What percentage of customers increase their end-of-period balance by more than 5%?
