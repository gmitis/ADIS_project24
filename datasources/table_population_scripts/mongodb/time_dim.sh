mongoimport --uri=mongodb://root:root@localhost:27017/?authSource=admin             --db='adis'             --collection='time_dim'             --type=csv             --file=/mongo_data/time_dim.csv             --fields='t_time_sk,t_time_id,t_time,t_hour,t_minute,t_second,t_am_pm,t_shift,t_sub_shift,t_meal_time' 

