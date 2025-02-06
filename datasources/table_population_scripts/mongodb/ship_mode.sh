mongoimport --uri=mongodb://root:root@localhost:27017/?authSource=admin             --db='adis'             --collection='ship_mode'             --type=csv             --file=/mongo_data/ship_mode.csv             --fields='sm_ship_mode_sk,sm_ship_mode_id,sm_type,sm_code,sm_carrier,sm_contract' 

