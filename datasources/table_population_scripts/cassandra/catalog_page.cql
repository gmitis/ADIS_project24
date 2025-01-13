create table catalog_page
(
    cp_catalog_page_sk        int               ,
    cp_catalog_page_id        text              ,
    cp_start_date_sk          int                       ,
    cp_end_date_sk            int                       ,
    cp_department             text                   ,
    cp_catalog_number         int                       ,
    cp_catalog_page_number    int                       ,
    cp_description            text                  ,
    cp_type                   text                  ,
    primary key (cp_catalog_page_sk)
);
COPY catalog_page(cp_catalog_page_sk,cp_catalog_page_id,cp_start_date_sk,cp_end_date_sk,cp_department,cp_catalog_number,cp_catalog_page_number,cp_description,cp_type)
FROM '/data/catalog_page.csv'
WITH HEADER=TRUE AND NULL='';

