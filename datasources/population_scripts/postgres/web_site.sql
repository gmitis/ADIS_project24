create table web_site
(
    web_site_sk               integer               not null,
    web_site_id               char(16)              not null,
    web_rec_start_date        date                          ,
    web_rec_end_date          date                          ,
    web_name                  varchar(50)                   ,
    web_open_date_sk          integer                       ,
    web_close_date_sk         integer                       ,
    web_class                 varchar(50)                   ,
    web_manager               varchar(40)                   ,
    web_mkt_id                integer                       ,
    web_mkt_class             varchar(50)                   ,
    web_mkt_desc              varchar(100)                  ,
    web_market_manager        varchar(40)                   ,
    web_company_id            integer                       ,
    web_company_name          char(50)                      ,
    web_street_number         char(10)                      ,
    web_street_name           varchar(60)                   ,
    web_street_type           char(15)                      ,
    web_suite_number          char(10)                      ,
    web_city                  varchar(60)                   ,
    web_county                varchar(30)                   ,
    web_state                 char(2)                       ,
    web_zip                   char(10)                      ,
    web_country               varchar(20)                   ,
    web_gmt_offset            decimal(5,2)                  ,
    web_tax_percentage        decimal(5,2)                  ,
    primary key (web_site_sk)
);

copy web_site from '/home/ubuntu/ADIS_project24/data/csv_data/web_site.csv' with (format csv, delimiter ',');
