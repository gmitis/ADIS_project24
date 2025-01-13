create table reason
(
    r_reason_sk               int               ,
    r_reason_id               text              ,
    r_reason_desc             text                     ,
    primary key (r_reason_sk)
);
COPY reason(r_reason_sk,r_reason_id,r_reason_desc)
FROM '/data/reason.csv'
WITH HEADER=TRUE AND NULL='';

