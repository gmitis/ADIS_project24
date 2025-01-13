create table dbgen_version
(
    dv_version                text                   ,
    dv_create_date            timestamp                          ,
    dv_create_time            time                          ,
    dv_cmdline_args           text                  
);
COPY dbgen_version(dv_version,dv_create_date,dv_create_time,dv_cmdline_args)
FROM '/data/dbgen_version.csv'
WITH HEADER=TRUE AND NULL='';

