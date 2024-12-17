## Project Description
tba

## Test Databases:

### Cassandra:

For the time being we need to populate it manually (mongo, postgres are automatically populated):
```bash
./utils/make_csv.sh ./data/cassandra_data/web_page.dat      # creates csv out of .dat file
docker-compose up --build --force-recreate cassandra
docker exec -it cassandra bash
cqlsh -e "create keyspace adis with replication={'class':'SimpleStrategy', 'replication_factor': 1};"
cqlsh -k adis -f "/cassandra_tables.cql" --debug
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