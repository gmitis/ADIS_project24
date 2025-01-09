## Project Description
tba

## Test Presto with databases:

Added this lines of code inside mongo_init.sh after db launch to create a user inside the adis database of mongo before importing data

```bash
docker system prune -f && sudo docker-compose up cassandra cassandra-load-keyspace mongo postgres presto-coordinator presto-worker1 presto-worker2
docker exec -it presto-coordinator bash

# for testing postgres
./opt/presto-cli --server localhost:8080 --catalog postgresql --schema public --execute 'select count(*) from web_page;' 

# for testing cassandra
./opt/presto-cli --server localhost:8080 --catalog cassandra --schema adis --execute 'select * from  web_page limit 10;'

# for testing mongodb
./opt/presto-cli --server localhost:8080 --catalog mongodb --schema adis --execute 'select * from  income_band limit 10;'
```

## Produce scripts to populate DBs:

Step 1: Copy created tpc-ds dataset into ~/ADIS_project24/data/original_data directory
```bash
mv tpcds_data_directory/* ~/ADIS_project24/data/original_data
```

Step 2: Clean data and convert to csv by running
```bash
cd ~/ADIS_project24
chmod +x ~/ADIS_project24/utils/*

# also creates a catalog.txt into ~/ADIS_project24 that contains the names of all the tables
./utils/make_csv.sh ~/ADIS_project24/data/original_data     # create the csv data from scratch with original .dat files
scp -r ubuntu@snf-77013.ok-kno.grnetcloud.net:~/ADIS_project24/data ~/ADIS_project24/data   # or copy it from the already generated csv dataset

# generates sql interpretation into single file of a single talbes of tpcds.sql
./utils/generate_table_scripts/postgresql_population_scripts.sh

# create actual population file that docker is going to initialize the database with 
# see name of tables in ~/ADIS_project24/data/tables_catalog.txt 
# with "*" you include all of the tables
./utils/population_script_generate/postgresql_generate.sh table_name1 table_name2 ... | all
```

Step 3: Now run the postgres container and it will be populated automatically
```bash
# docker-compose down -v is necessarry to remove any volumes or containers that has outdated configuration/format
cd ~/ADIS_project24 && \
docker-compose down -v && \
docker-compose up -d --build --force-recreate postgres
```