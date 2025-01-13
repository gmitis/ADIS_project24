create table household_demographics
(
    hd_demo_sk                int               ,
    hd_income_band_sk         int                       ,
    hd_buy_potential          text                      ,
    hd_dep_count              int                       ,
    hd_vehicle_count          int                       ,
    primary key (hd_demo_sk)
);
COPY household_demographics(hd_demo_sk,hd_income_band_sk,hd_buy_potential,hd_dep_count,hd_vehicle_count)
FROM '/data/household_demographics.csv'
WITH HEADER=TRUE AND NULL='';

