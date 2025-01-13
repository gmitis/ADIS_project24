create table web_site
(
    web_site_sk               int               ,
    web_site_id               text              ,
    web_rec_start_date        timestamp                          ,
    web_rec_end_date          timestamp                          ,
    web_name                  text                   ,
    web_open_date_sk          int                       ,
    web_close_date_sk         int                       ,
    web_class                 text                   ,
    web_manager               text                   ,
    web_mkt_id                int                       ,
    web_mkt_class             text                   ,
    web_mkt_desc              text                  ,
    web_market_manager        text                   ,
    web_company_id            int                       ,
    web_company_name          text                      ,
    web_street_number         text                      ,
    web_street_name           text                   ,
    web_street_type           text                      ,
    web_suite_number          text                      ,
    web_city                  text                   ,
    web_county                text                   ,
    web_state                 text                       ,
    web_zip                   text                      ,
    web_country               text                   ,
    web_gmt_offset            decimal                  ,
    web_tax_percentage        decimal                  ,
    primary key (web_site_sk)
);
COPY web_site(web_site_sk,web_site_id,web_rec_start_date,web_rec_end_date,web_name,web_open_date_sk,web_close_date_sk,web_class,web_manager,web_mkt_id,web_mkt_class,web_mkt_desc,web_market_manager,web_company_id,web_company_name,web_street_number,web_street_name,web_street_type,web_suite_number,web_city,web_county,web_state,web_zip,web_country,web_gmt_offset,web_tax_percentage)
FROM '/data/web_site.csv'
WITH HEADER=TRUE AND NULL='';

