create unlogged table dbgen_version
(
    dv_version                varchar(16)                   ,
    dv_create_date            date                          ,
    dv_create_time            time                          ,
    dv_cmdline_args           varchar(200)                  
);
copy dbgen_version from '/data/dbgen_version.csv' with (format csv, delimiter ',');

