mongoimport --uri=mongodb://root:root@localhost:27017/?authSource=admin             --db='adis'             --collection='inventory'             --type=csv             --file=/mongo_data/inventory.csv             --fields=' inv_date_sk,inv_item_sk,inv_warehouse_sk,inv_quantity_on_hand' 

