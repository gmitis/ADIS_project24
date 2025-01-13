create table ship_mode
(
    sm_ship_mode_sk           int               ,
    sm_ship_mode_id           text              ,
    sm_type                   text                      ,
    sm_code                   text                      ,
    sm_carrier                text                      ,
    sm_contract               text                      ,
    primary key (sm_ship_mode_sk)
);
COPY ship_mode(sm_ship_mode_sk,sm_ship_mode_id,sm_type,sm_code,sm_carrier,sm_contract)
FROM '/data/ship_mode.csv'
WITH HEADER=TRUE AND NULL='';

