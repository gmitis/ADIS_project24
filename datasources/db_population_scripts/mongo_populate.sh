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

echo "MongoDB initialization completed."
