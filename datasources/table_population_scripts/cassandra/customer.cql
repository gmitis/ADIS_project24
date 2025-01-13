create table customer
(
    c_customer_sk             int               ,
    c_customer_id             text              ,
    c_current_cdemo_sk        int                       ,
    c_current_hdemo_sk        int                       ,
    c_current_addr_sk         int                       ,
    c_first_shipto_date_sk    int                       ,
    c_first_sales_date_sk     int                       ,
    c_salutation              text                      ,
    c_first_name              text                      ,
    c_last_name               text                      ,
    c_preferred_cust_flag     text                       ,
    c_birth_day               int                       ,
    c_birth_month             int                       ,
    c_birth_year              int                       ,
    c_birth_country           text                   ,
    c_login                   text                      ,
    c_email_address           text                      ,
    c_last_review_date        text                      ,
    primary key (c_customer_sk)
);
COPY customer(c_customer_sk,c_customer_id,c_current_cdemo_sk,c_current_hdemo_sk,c_current_addr_sk,c_first_shipto_date_sk,c_first_sales_date_sk,c_salutation,c_first_name,c_last_name,c_preferred_cust_flag,c_birth_day,c_birth_month,c_birth_year,c_birth_country,c_login,c_email_address,c_last_review_date)
FROM '/data/customer.csv'
WITH HEADER=TRUE AND NULL='';

