create table catalog_returns
(
    cr_returned_date_sk       int                       ,
    cr_returned_time_sk       int                       ,
    cr_item_sk                int               ,
    cr_refunded_customer_sk   int                       ,
    cr_refunded_cdemo_sk      int                       ,
    cr_refunded_hdemo_sk      int                       ,
    cr_refunded_addr_sk       int                       ,
    cr_returning_customer_sk  int                       ,
    cr_returning_cdemo_sk     int                       ,
    cr_returning_hdemo_sk     int                       ,
    cr_returning_addr_sk      int                       ,
    cr_call_center_sk         int                       ,
    cr_catalog_page_sk        int                       ,
    cr_ship_mode_sk           int                       ,
    cr_warehouse_sk           int                       ,
    cr_reason_sk              int                       ,
    cr_order_number           int               ,
    cr_return_quantity        int                       ,
    cr_return_amount          decimal                  ,
    cr_return_tax             decimal                  ,
    cr_return_amt_inc_tax     decimal                  ,
    cr_fee                    decimal                  ,
    cr_return_ship_cost       decimal                  ,
    cr_refunded_cash          decimal                  ,
    cr_reversed_charge        decimal                  ,
    cr_store_credit           decimal                  ,
    cr_net_loss               decimal                  ,
    primary key (cr_item_sk, cr_order_number)
);
COPY catalog_returns(cr_returned_date_sk,cr_returned_time_sk,cr_item_sk,cr_refunded_customer_sk,cr_refunded_cdemo_sk,cr_refunded_hdemo_sk,cr_refunded_addr_sk,cr_returning_customer_sk,cr_returning_cdemo_sk,cr_returning_hdemo_sk,cr_returning_addr_sk,cr_call_center_sk,cr_catalog_page_sk,cr_ship_mode_sk,cr_warehouse_sk,cr_reason_sk,cr_order_number,cr_return_quantity,cr_return_amount,cr_return_tax,cr_return_amt_inc_tax,cr_fee,cr_return_ship_cost,cr_refunded_cash,cr_reversed_charge,cr_store_credit,cr_net_loss)
FROM '/data/catalog_returns.csv'
WITH NULL='';

