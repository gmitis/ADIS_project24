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
