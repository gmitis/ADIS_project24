mongoimport --uri=mongodb://root:root@localhost:27017/?authSource=admin             --db='adis'             --collection='dbgen_version'             --type=csv             --file=/mongo_data/dbgen_version.csv             --fields='dv_version,dv_create_date,dv_create_time,dv_cmdline_args' 

