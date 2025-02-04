create table income_band
(
    ib_income_band_sk         int               ,
    ib_lower_bound            int                       ,
    ib_upper_bound            int                       ,
    primary key (ib_income_band_sk)
);
COPY income_band(ib_income_band_sk,ib_lower_bound,ib_upper_bound)
FROM '/data/income_band.csv'
WITH NULL='';

