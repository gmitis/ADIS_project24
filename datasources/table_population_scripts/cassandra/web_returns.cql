create table web_returns
(
    wr_returned_date_sk       int                       ,
    wr_returned_time_sk       int                       ,
    wr_item_sk                int               ,
    wr_refunded_customer_sk   int                       ,
    wr_refunded_cdemo_sk      int                       ,
    wr_refunded_hdemo_sk      int                       ,
    wr_refunded_addr_sk       int                       ,
    wr_returning_customer_sk  int                       ,
    wr_returning_cdemo_sk     int                       ,
    wr_returning_hdemo_sk     int                       ,
    wr_returning_addr_sk      int                       ,
    wr_web_page_sk            int                       ,
    wr_reason_sk              int                       ,
    wr_order_number           int               ,
    wr_return_quantity        int                       ,
    wr_return_amt             decimal                  ,
    wr_return_tax             decimal                  ,
    wr_return_amt_inc_tax     decimal                  ,
    wr_fee                    decimal                  ,
    wr_return_ship_cost       decimal                  ,
    wr_refunded_cash          decimal                  ,
    wr_reversed_charge        decimal                  ,
    wr_account_credit         decimal                  ,
    wr_net_loss               decimal                  ,
    primary key (wr_item_sk, wr_order_number)
);
COPY web_returns(wr_returned_date_sk,wr_returned_time_sk,wr_item_sk,wr_refunded_customer_sk,wr_refunded_cdemo_sk,wr_refunded_hdemo_sk,wr_refunded_addr_sk,wr_returning_customer_sk,wr_returning_cdemo_sk,wr_returning_hdemo_sk,wr_returning_addr_sk,wr_web_page_sk,wr_reason_sk,wr_order_number,wr_return_quantity,wr_return_amt,wr_return_tax,wr_return_amt_inc_tax,wr_fee,wr_return_ship_cost,wr_refunded_cash,wr_reversed_charge,wr_account_credit,wr_net_loss)
FROM '/data/web_returns.csv'
WITH HEADER=TRUE AND NULL='';

