mongoimport --uri=mongodb://root:root@localhost:27017/?authSource=admin             --db='adis'             --collection='customer_address'             --type=csv             --file=/mongo_data/customer_address.csv             --fields='ca_address_sk,ca_address_id,ca_street_number,ca_street_name,ca_street_type,ca_suite_number,ca_city,ca_county,ca_state,ca_zip,ca_country,ca_gmt_offset,ca_location_type' 

