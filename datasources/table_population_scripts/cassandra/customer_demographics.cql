create table customer_demographics
(
    cd_demo_sk                int               ,
    cd_gender                 text                       ,
    cd_marital_status         text                       ,
    cd_education_status       text                      ,
    cd_purchase_estimate      int                       ,
    cd_credit_rating          text                      ,
    cd_dep_count              int                       ,
    cd_dep_employed_count     int                       ,
    cd_dep_college_count      int                       ,
    primary key (cd_demo_sk)
);
COPY customer_demographics(cd_demo_sk,cd_gender,cd_marital_status,cd_education_status,cd_purchase_estimate,cd_credit_rating,cd_dep_count,cd_dep_employed_count,cd_dep_college_count)
FROM '/data/customer_demographics.csv'
WITH HEADER=TRUE AND NULL='';

