create table reason
(
    r_reason_sk               integer               not null,
    r_reason_id               char(16)              not null,
    r_reason_desc             char(100)                     ,
    primary key (r_reason_sk)
);

copy reason from '/home/ubuntu/ADIS_project24/data/csv_data/reason.csv' with (format csv, delimiter ',');
