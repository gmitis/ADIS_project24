## Project Description
tba

## Test Databases:

### Cassandra:

For the time being we need to populate it manually (mongo, postgres are automatically populated):
```bash
./utils/make_csv.sh ./data/cassandra_data/web_page.dat      # creates csv out of .dat file
docker-compose up --build --force-recreate cassandra cassandra-load
docker exec -it cassandra cqlsh -u root -p root
select * from adis.web_page limit 10;
```
### MongoDB:

```bash
docker-compose up --build --force-recreate mongo
docker exec -it mongo mongosh -u root -p root
use adis;
db.web_page.find().limit(10);
```

### PostgreSQL:

```bash
docker-compose up --build --force-recreate postgres
docker exec -it postgres psql -U root adis
select * from web_page limit 10;

```

## Test Presto with databases:

```bash
sudo docker-compose up cassandra cassandra-load-keyspace mongo postgres presto-coordinator presto-worker1 presto-worker2
docker exec -it presto-coordinator bash

# for testing postgres
./opt/presto-cli --server localhost:8080 --catalog postgresql --schema  public --execute 'select count(*) from web_page;' 

# for testing cassandra
./opt/presto-cli --server localhost:8080 --catalog cassandra --schema adis --execute 'select * from  web_page limit 10;'

# for testing mongodb

```