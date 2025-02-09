create table warehouse
(
    w_warehouse_sk            int               ,
    w_warehouse_id            text              ,
    w_warehouse_name          text                   ,
    w_warehouse_sq_ft         int                       ,
    w_street_number           text                      ,
    w_street_name             text                   ,
    w_street_type             text                      ,
    w_suite_number            text                      ,
    w_city                    text                   ,
    w_county                  text                   ,
    w_state                   text                       ,
    w_zip                     text                      ,
    w_country                 text                   ,
    w_gmt_offset              decimal                  ,
    primary key (w_warehouse_sk)
);
COPY warehouse(w_warehouse_sk,w_warehouse_id,w_warehouse_name,w_warehouse_sq_ft,w_street_number,w_street_name,w_street_type,w_suite_number,w_city,w_county,w_state,w_zip,w_country,w_gmt_offset)
FROM '/data/warehouse.csv'
WITH NULL='';

