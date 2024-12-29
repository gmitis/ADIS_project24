create table dbgen_version
(
    dv_version                varchar(16)                   ,
    dv_create_date            date                          ,
    dv_create_time            time                          ,
    dv_cmdline_args           varchar(200)                  
);

copy dbgen_version from '/home/ubuntu/ADIS_project24/data/csv_data/dbgen_version.csv' with (format csv, delimiter ',');
