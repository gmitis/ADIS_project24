mongoimport --uri=mongodb://root:root@localhost:27017/?authSource=admin             --db='adis'             --collection='reason'             --type=csv             --file=/mongo_data/reason.csv             --fields='r_reason_sk,r_reason_id,r_reason_desc' 

