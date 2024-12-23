#! /bin/bash

until mongosh "mongodb://root:root@localhost:27017/?authSource=admin" --eval "db.stats()" > /dev/null 2>&1; do
    echo "Waiting for MongoDB to start..."
    sleep 5
done

mongosh "mongodb://root:root@localhost:27017/?authSource=admin" <<EOF
use adis;
db.createUser({
 user: "adis_user",
 pwd: "adis_password",
 roles: [{ role: "readWrite", db: "adis" }]
});
EOF

mongoimport --uri="mongodb://root:root@localhost:27017/?authSource=admin" \
            --db='adis' \
            --collection='income_band' \
            --type=csv \
            --file=/mongo_data/income_band.csv \
            --fields="ib_income_band_sk, ib_lower_bound, ib_upper_bound" 

echo "MongoDB initialization completed."
