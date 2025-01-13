create table date_dim
(
    d_date_sk                 int               ,
    d_date_id                 text              ,
    d_date                    timestamp                          ,
    d_month_seq               int                       ,
    d_week_seq                int                       ,
    d_quarter_seq             int                       ,
    d_year                    int                       ,
    d_dow                     int                       ,
    d_moy                     int                       ,
    d_dom                     int                       ,
    d_qoy                     int                       ,
    d_fy_year                 int                       ,
    d_fy_quarter_seq          int                       ,
    d_fy_week_seq             int                       ,
    d_day_name                text                       ,
    d_quarter_name            text                       ,
    d_holiday                 text                       ,
    d_weekend                 text                       ,
    d_following_holiday       text                       ,
    d_first_dom               int                       ,
    d_last_dom                int                       ,
    d_same_day_ly             int                       ,
    d_same_day_lq             int                       ,
    d_current_day             text                       ,
    d_current_week            text                       ,
    d_current_month           text                       ,
    d_current_quarter         text                       ,
    d_current_year            text                       ,
    primary key (d_date_sk)
);
COPY date_dim(d_date_sk,d_date_id,d_date,d_month_seq,d_week_seq,d_quarter_seq,d_year,d_dow,d_moy,d_dom,d_qoy,d_fy_year,d_fy_quarter_seq,d_fy_week_seq,d_day_name,d_quarter_name,d_holiday,d_weekend,d_following_holiday,d_first_dom,d_last_dom,d_same_day_ly,d_same_day_lq,d_current_day,d_current_week,d_current_month,d_current_quarter,d_current_year)
FROM '/data/date_dim.csv'
WITH HEADER=TRUE AND NULL='';

