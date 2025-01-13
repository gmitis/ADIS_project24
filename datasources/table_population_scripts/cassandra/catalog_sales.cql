create table catalog_sales
(
    cs_sold_date_sk           int                       ,
    cs_sold_time_sk           int                       ,
    cs_ship_date_sk           int                       ,
    cs_bill_customer_sk       int                       ,
    cs_bill_cdemo_sk          int                       ,
    cs_bill_hdemo_sk          int                       ,
    cs_bill_addr_sk           int                       ,
    cs_ship_customer_sk       int                       ,
    cs_ship_cdemo_sk          int                       ,
    cs_ship_hdemo_sk          int                       ,
    cs_ship_addr_sk           int                       ,
    cs_call_center_sk         int                       ,
    cs_catalog_page_sk        int                       ,
    cs_ship_mode_sk           int                       ,
    cs_warehouse_sk           int                       ,
    cs_item_sk                int               ,
    cs_promo_sk               int                       ,
    cs_order_number           int               ,
    cs_quantity               int                       ,
    cs_wholesale_cost         decimal                  ,
    cs_list_price             decimal                  ,
    cs_sales_price            decimal                  ,
    cs_ext_discount_amt       decimal                  ,
    cs_ext_sales_price        decimal                  ,
    cs_ext_wholesale_cost     decimal                  ,
    cs_ext_list_price         decimal                  ,
    cs_ext_tax                decimal                  ,
    cs_coupon_amt             decimal                  ,
    cs_ext_ship_cost          decimal                  ,
    cs_net_paid               decimal                  ,
    cs_net_paid_inc_tax       decimal                  ,
    cs_net_paid_inc_ship      decimal                  ,
    cs_net_paid_inc_ship_tax  decimal                  ,
    cs_net_profit             decimal                  ,
    primary key (cs_item_sk, cs_order_number)
);
COPY catalog_sales(cs_sold_date_sk,cs_sold_time_sk,cs_ship_date_sk,cs_bill_customer_sk,cs_bill_cdemo_sk,cs_bill_hdemo_sk,cs_bill_addr_sk,cs_ship_customer_sk,cs_ship_cdemo_sk,cs_ship_hdemo_sk,cs_ship_addr_sk,cs_call_center_sk,cs_catalog_page_sk,cs_ship_mode_sk,cs_warehouse_sk,cs_item_sk,cs_promo_sk,cs_order_number,cs_quantity,cs_wholesale_cost,cs_list_price,cs_sales_price,cs_ext_discount_amt,cs_ext_sales_price,cs_ext_wholesale_cost,cs_ext_list_price,cs_ext_tax,cs_coupon_amt,cs_ext_ship_cost,cs_net_paid,cs_net_paid_inc_tax,cs_net_paid_inc_ship,cs_net_paid_inc_ship_tax,cs_net_profit)
FROM '/data/catalog_sales.csv'
WITH HEADER=TRUE AND NULL='';

