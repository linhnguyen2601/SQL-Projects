1. CREATE table and import data
CREATE TABLE online_retail
(
    invoiceno varchar,
    stockcode varchar,
    description varchar,
    quantity varchar,
    invoicedate varchar,
    unitprice varchar,
    customerid varchar,
    country varchar
)

2. CHANGE data type

ALTER TABLE online_retail
ALTER COLUMN quantity type integer USING quantity::integer,
ALTER COLUMN invoicedate type date USING invoicedate::date,
ALTER COLUMN unitprice type float USING unitprice::double precision

3. Check null

select * from online_retail
where invoiceno is null 
or stockcode is null
or description is null
or quantity is null
or invoicedate is null
or unitprice is null
or customerid is null
or country is null

=> There is no null value


