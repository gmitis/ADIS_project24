create table call_center
(
    cc_call_center_sk         int               ,
    cc_call_center_id         text              ,
    cc_rec_start_date         timestamp                          ,
    cc_rec_end_date           timestamp                          ,
    cc_closed_date_sk         int                       ,
    cc_open_date_sk           int                       ,
    cc_name                   text                   ,
    cc_class                  text                   ,
    cc_employees              int                       ,
    cc_sq_ft                  int                       ,
    cc_hours                  text                      ,
    cc_manager                text                   ,
    cc_mkt_id                 int                       ,
    cc_mkt_class              text                      ,
    cc_mkt_desc               text                  ,
    cc_market_manager         text                   ,
    cc_division               int                       ,
    cc_division_name          text                   ,
    cc_company                int                       ,
    cc_company_name           text                      ,
    cc_street_number          text                      ,
    cc_street_name            text                   ,
    cc_street_type            text                      ,
    cc_suite_number           text                      ,
    cc_city                   text                   ,
    cc_county                 text                   ,
    cc_state                  text                       ,
    cc_zip                    text                      ,
    cc_country                text                   ,
    cc_gmt_offset             decimal                  ,
    cc_tax_percentage         decimal                  ,
    primary key (cc_call_center_sk)
);
COPY call_center(cc_call_center_sk,cc_call_center_id,cc_rec_start_date,cc_rec_end_date,cc_closed_date_sk,cc_open_date_sk,cc_name,cc_class,cc_employees,cc_sq_ft,cc_hours,cc_manager,cc_mkt_id,cc_mkt_class,cc_mkt_desc,cc_market_manager,cc_division,cc_division_name,cc_company,cc_company_name,cc_street_number,cc_street_name,cc_street_type,cc_suite_number,cc_city,cc_county,cc_state,cc_zip,cc_country,cc_gmt_offset,cc_tax_percentage)
FROM '/data/call_center.csv'
WITH NULL='';

