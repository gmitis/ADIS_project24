create table item
(
    i_item_sk                 int               ,
    i_item_id                 text              ,
    i_rec_start_date          timestamp                          ,
    i_rec_end_date            timestamp                          ,
    i_item_desc               text                  ,
    i_current_price           decimal                  ,
    i_wholesale_cost          decimal                  ,
    i_brand_id                int                       ,
    i_brand                   text                      ,
    i_class_id                int                       ,
    i_class                   text                      ,
    i_category_id             int                       ,
    i_category                text                      ,
    i_manufact_id             int                       ,
    i_manufact                text                      ,
    i_size                    text                      ,
    i_formulation             text                      ,
    i_color                   text                      ,
    i_units                   text                      ,
    i_container               text                      ,
    i_manager_id              int                       ,
    i_product_name            text                      ,
    primary key (i_item_sk)
);
COPY item(i_item_sk,i_item_id,i_rec_start_date,i_rec_end_date,i_item_desc,i_current_price,i_wholesale_cost,i_brand_id,i_brand,i_class_id,i_class,i_category_id,i_category,i_manufact_id,i_manufact,i_size,i_formulation,i_color,i_units,i_container,i_manager_id,i_product_name)
FROM '/data/item.csv'
WITH NULL='';

