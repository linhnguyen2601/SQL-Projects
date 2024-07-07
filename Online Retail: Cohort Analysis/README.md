# Online Retail: Cohort Analysis

## 1. Data cleaning

### 1.1. Check data type, check null, check duplicates, 

Change data type: quantity to integer, invoicedate to date, unitprice to float.

Tổng số bản ghi: 541909 dòng

Check null

desciption is null: 1454
customerid: 135080 

Check duplicate: 5433 bản ghi

Check validation:
select * from online_retail
where quantity <= 0 or unitprice <= 0

=> 11805 bản ghi

Như vậy cần tạo bảng mới sau khi đã loại các dòng customerid bị null, quantity <= 0 và unitprice <=0 và duplicate.
Bảng mới online_retail_clean có 392668 bản ghi

