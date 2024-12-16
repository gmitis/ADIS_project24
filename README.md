## Project Description
tba

## Running Services:

### Cassandra Population:

For the time being we need to populate it manually (mongo, postgres are automatically populated):
```bash
./utils/make_csv.sh ./data/cassandra_data/web_page.dat      # creates csv out of .dat file
docker-compose up --build --force-recreate cassandra
docker exec -it cassandra bash
cqlsh -e "create keyspace adis with replication={'class':'SimpleStrategy', 'replication_factor': 1};"
cqlsh -k adis -f "/cassandra_tables.cql" --debug
```
