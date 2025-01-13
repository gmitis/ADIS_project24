create table store_returns
(
    sr_returned_date_sk       int                       ,
    sr_return_time_sk         int                       ,
    sr_item_sk                int               ,
    sr_customer_sk            int                       ,
    sr_cdemo_sk               int                       ,
    sr_hdemo_sk               int                       ,
    sr_addr_sk                int                       ,
    sr_store_sk               int                       ,
    sr_reason_sk              int                       ,
    sr_ticket_number          int               ,
    sr_return_quantity        int                       ,
    sr_return_amt             decimal                  ,
    sr_return_tax             decimal                  ,
    sr_return_amt_inc_tax     decimal                  ,
    sr_fee                    decimal                  ,
    sr_return_ship_cost       decimal                  ,
    sr_refunded_cash          decimal                  ,
    sr_reversed_charge        decimal                  ,
    sr_store_credit           decimal                  ,
    sr_net_loss               decimal                  ,
    primary key (sr_item_sk, sr_ticket_number)
);
COPY store_returns(sr_returned_date_sk,sr_return_time_sk,sr_item_sk,sr_customer_sk,sr_cdemo_sk,sr_hdemo_sk,sr_addr_sk,sr_store_sk,sr_reason_sk,sr_ticket_number,sr_return_quantity,sr_return_amt,sr_return_tax,sr_return_amt_inc_tax,sr_fee,sr_return_ship_cost,sr_refunded_cash,sr_reversed_charge,sr_store_credit,sr_net_loss)
FROM '/data/store_returns.csv'
WITH HEADER=TRUE AND NULL='';

