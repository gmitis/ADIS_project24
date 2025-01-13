create table store
(
    s_store_sk                int               ,
    s_store_id                text              ,
    s_rec_start_date          timestamp                          ,
    s_rec_end_date            timestamp                          ,
    s_closed_date_sk          int                       ,
    s_store_name              text                   ,
    s_number_employees        int                       ,
    s_floor_space             int                       ,
    s_hours                   text                      ,
    s_manager                 text                   ,
    s_market_id               int                       ,
    s_geography_class         text                  ,
    s_market_desc             text                  ,
    s_market_manager          text                   ,
    s_division_id             int                       ,
    s_division_name           text                   ,
    s_company_id              int                       ,
    s_company_name            text                   ,
    s_street_number           text                   ,
    s_street_name             text                   ,
    s_street_type             text                      ,
    s_suite_number            text                      ,
    s_city                    text                   ,
    s_county                  text                   ,
    s_state                   text                       ,
    s_zip                     text                      ,
    s_country                 text                   ,
    s_gmt_offset              decimal                  ,
    s_tax_precentage          decimal                  ,
    primary key (s_store_sk)
);
COPY store(s_store_sk,s_store_id,s_rec_start_date,s_rec_end_date,s_closed_date_sk,s_store_name,s_number_employees,s_floor_space,s_hours,s_manager,s_market_id,s_geography_class,s_market_desc,s_market_manager,s_division_id,s_division_name,s_company_id,s_company_name,s_street_number,s_street_name,s_street_type,s_suite_number,s_city,s_county,s_state,s_zip,s_country,s_gmt_offset,s_tax_precentage)
FROM '/data/store.csv'
WITH HEADER=TRUE AND NULL='';

