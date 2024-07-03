-- 1. Tạo bảng trong PostgreSQL
create table SALES_DATASET_RFM_PRJ
(
  ordernumber VARCHAR,
  quantityordered VARCHAR,
  priceeach        VARCHAR,
  orderlinenumber  VARCHAR,
  sales            VARCHAR,
  orderdate        VARCHAR,
  status           VARCHAR,
  productline      VARCHAR,
  msrp             VARCHAR,
  productcode      VARCHAR,
  customername     VARCHAR,
  phone            VARCHAR,
  addressline1     VARCHAR,
  addressline2     VARCHAR,
  city             VARCHAR,
  state            VARCHAR,
  postalcode       VARCHAR,
  country          VARCHAR,
  territory        VARCHAR,
  contactfullname  VARCHAR,
  dealsize         VARCHAR
) 

-- 2. Đổi kiểu dữ liệu
ALTER TABLE SALES_DATASET_RFM_PRJ
ALTER COLUMN ordernumber TYPE integer USING ordernumber::integer,
ALTER COLUMN quantityordered TYPE integer USING quantityordered::integer,
ALTER COLUMN priceeach TYPE float USING priceeach::double precision,
ALTER COLUMN orderlinenumber TYPE integer USING orderlinenumber::integer,
ALTER COLUMN sales TYPE float USING sales::double precision,
ALTER COLUMN orderdate TYPE date USING orderdate::date,
ALTER COLUMN msrp TYPE integer USING msrp::integer

-- 3. Check Null/Blank
select * from public.sales_dataset_rfm_prj
where ordernumber is null

select * from public.sales_dataset_rfm_prj
where quantityordered is null

select * from public.sales_dataset_rfm_prj
where priceeach is null

select * from public.sales_dataset_rfm_prj
where orderlinenumber is null

select * from public.sales_dataset_rfm_prj
where sales is null

select * from public.sales_dataset_rfm_prj
where orderdate is null


