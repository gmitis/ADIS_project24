create table web_sales
(
    ws_sold_date_sk           int                       ,
    ws_sold_time_sk           int                       ,
    ws_ship_date_sk           int                       ,
    ws_item_sk                int               ,
    ws_bill_customer_sk       int                       ,
    ws_bill_cdemo_sk          int                       ,
    ws_bill_hdemo_sk          int                       ,
    ws_bill_addr_sk           int                       ,
    ws_ship_customer_sk       int                       ,
    ws_ship_cdemo_sk          int                       ,
    ws_ship_hdemo_sk          int                       ,
    ws_ship_addr_sk           int                       ,
    ws_web_page_sk            int                       ,
    ws_web_site_sk            int                       ,
    ws_ship_mode_sk           int                       ,
    ws_warehouse_sk           int                       ,
    ws_promo_sk               int                       ,
    ws_order_number           int               ,
    ws_quantity               int                       ,
    ws_wholesale_cost         decimal                  ,
    ws_list_price             decimal                  ,
    ws_sales_price            decimal                  ,
    ws_ext_discount_amt       decimal                  ,
    ws_ext_sales_price        decimal                  ,
    ws_ext_wholesale_cost     decimal                  ,
    ws_ext_list_price         decimal                  ,
    ws_ext_tax                decimal                  ,
    ws_coupon_amt             decimal                  ,
    ws_ext_ship_cost          decimal                  ,
    ws_net_paid               decimal                  ,
    ws_net_paid_inc_tax       decimal                  ,
    ws_net_paid_inc_ship      decimal                  ,
    ws_net_paid_inc_ship_tax  decimal                  ,
    ws_net_profit             decimal                  ,
    primary key (ws_item_sk, ws_order_number)
);
COPY web_sales(ws_sold_date_sk,ws_sold_time_sk,ws_ship_date_sk,ws_item_sk,ws_bill_customer_sk,ws_bill_cdemo_sk,ws_bill_hdemo_sk,ws_bill_addr_sk,ws_ship_customer_sk,ws_ship_cdemo_sk,ws_ship_hdemo_sk,ws_ship_addr_sk,ws_web_page_sk,ws_web_site_sk,ws_ship_mode_sk,ws_warehouse_sk,ws_promo_sk,ws_order_number,ws_quantity,ws_wholesale_cost,ws_list_price,ws_sales_price,ws_ext_discount_amt,ws_ext_sales_price,ws_ext_wholesale_cost,ws_ext_list_price,ws_ext_tax,ws_coupon_amt,ws_ext_ship_cost,ws_net_paid,ws_net_paid_inc_tax,ws_net_paid_inc_ship,ws_net_paid_inc_ship_tax,ws_net_profit)
FROM '/data/web_sales.csv'
WITH NULL='';

