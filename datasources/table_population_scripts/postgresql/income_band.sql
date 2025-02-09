create unlogged table income_band
(
    ib_income_band_sk         integer               not null,
    ib_lower_bound            integer                       ,
    ib_upper_bound            integer                       ,
    primary key (ib_income_band_sk)
);
copy income_band from '/data/income_band.csv' with (format csv, delimiter ',');

