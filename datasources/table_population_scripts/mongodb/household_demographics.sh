mongoimport --uri=mongodb://root:root@localhost:27017/?authSource=admin             --db='adis'             --collection='household_demographics'             --type=csv             --file=/mongo_data/household_demographics.csv             --fields=' hd_demo_sk,hd_income_band_sk,hd_buy_potential,hd_dep_count,hd_vehicle_count' 

