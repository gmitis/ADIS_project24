#! /bin/bash

input_file="$HOME/ADIS_project24/datasources/tpcds.sql"
output_dir="$HOME/ADIS_project24/datasources/table_population_scripts/mongodb"
tables_catalog="$HOME/ADIS_project24/data/tables_catalog.txt"
data_dir="/data"

# create new directory where table scripts are going to reside 
rm -rf "$output_dir" && mkdir -p "$output_dir"

# make the files
create_files() {
    local table="$1"

    if grep -iq "^$table$" "$tables_catalog"; then     
        # create output directory file
        mongo_file="$output_dir/${table}.sh"

        # generate string of fields separated by comma
        fields=$(~/ADIS_project24/utils/generate_fields.sh "$table")

        # copy population command to file 
        echo "mongoimport --uri="mongodb://root:root@localhost:27017/?authSource=admin" \
            --db='adis' \
            --collection='$table' \
            --type=csv \
            --file=/mongo_data/$table.csv \
            --fields=' "$fields"' " >> "$mongo_file"
        printf "\n" >> "$mongo_file"

        echo "Created $table.sh"
    else
        echo "Table Name: $table doesn't match with any dataset from tables_catalog.txt"
    fi
}

# get all table names and iterate over to create init_script for each table
grep -oP '(?<=create table\s)[a-zA-Z0-9_]+' "$input_file" | \
while read table_name; do
    create_files "$table_name"
done
