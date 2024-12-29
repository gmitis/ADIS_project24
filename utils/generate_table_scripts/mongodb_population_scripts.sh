#!/bin/bash

input_file="$HOME/ADIS_project24/datasources/tpcds.sql"
output_dir="$HOME/ADIS_project24/datasources/population_scripts/mongodb"
tables_catalog="$HOME/ADIS_project24/data/csv_data/tables_catalog.txt"
data_dir="$HOME/ADIS_project24/data/csv_data"

if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi


create_files() {
    local table="$1"

    if grep -iq "$table" "$tables_catalog"; then

        
        # match table with input file

        # create a list of the fields of the table

        # create file with import command

        mongoimport --uri="mongodb://root:root@localhost:27017/?authSource=admin" \
                    --db='adis' \
                    --collection='income_band' \
                    --type=csv \
                    --file=/mongo_data/income_band.csv \
                    --fields="ib_income_band_sk, ib_lower_bound, ib_upper_bound" 

    else
        echo "Table Name: $table doesn't match with any dataset from tables_catalog.txt"

    fi
}

grep -oP '(?<=create table\s)[a-zA-Z0-9_]+' "$input_file" | \
while read table; do
    create_files "$table"
done 