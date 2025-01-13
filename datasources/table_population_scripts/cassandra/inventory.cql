create table inventory
(
    inv_date_sk               int               ,
    inv_item_sk               int               ,
    inv_warehouse_sk          int               ,
    inv_quantity_on_hand      int                       ,
    primary key (inv_date_sk, inv_item_sk, inv_warehouse_sk)
);
COPY inventory(inv_date_sk,inv_item_sk,inv_warehouse_sk,inv_quantity_on_hand)
FROM '/data/inventory.csv'
WITH HEADER=TRUE AND NULL='';

