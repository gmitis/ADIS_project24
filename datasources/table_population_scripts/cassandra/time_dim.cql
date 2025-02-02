create table time_dim
(
    t_time_sk                 int               ,
    t_time_id                 text              ,
    t_time                    int                       ,
    t_hour                    int                       ,
    t_minute                  int                       ,
    t_second                  int                       ,
    t_am_pm                   text                       ,
    t_shift                   text                      ,
    t_sub_shift               text                      ,
    t_meal_time               text                      ,
    primary key (t_time_sk)
);
COPY time_dim(t_time_sk,t_time_id,t_time,t_hour,t_minute,t_second,t_am_pm,t_shift,t_sub_shift,t_meal_time)
FROM '/data/time_dim.csv'
WITH HEADER=TRUE AND NULL='';

