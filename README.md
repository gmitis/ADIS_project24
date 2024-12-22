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

Added this lines of code inside mongo_init.sh after db launch to create a user inside the adis database of mongo before importing data

```bash
mongosh "mongodb://root:root@localhost:27017/?authSource=admin" <<EOF
use adis;
db.createUser({
 user: "adis_user",
 pwd: "adis_password",
 roles: [{ role: "readWrite", db: "adis" }]
});
EOF
```

Updated the mongo credentials in the file mongodb.properties to correspond to the user created inside the database "adis"

```bash
mongodb.credentials=adis_user:adis_password@adis
```
