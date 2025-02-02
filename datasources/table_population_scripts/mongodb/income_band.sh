mongoimport --uri=mongodb://root:root@localhost:27017/?authSource=admin             --db='adis'             --collection='income_band'             --type=csv             --file=/mongo_data/income_band.csv             --fields=' ib_income_band_sk,ib_lower_bound,ib_upper_bound' 

