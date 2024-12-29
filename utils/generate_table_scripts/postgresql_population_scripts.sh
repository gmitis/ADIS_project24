#! /bin/bash

input_file="$HOME/ADIS_project24/datasources/tpcds.sql"
output_dir="$HOME/ADIS_project24/datasources/population_scripts/postgres"
tables_catalog="$HOME/ADIS_project24/data/csv_data/tables_catalog.txt"
data_dir="$HOME/ADIS_project24/data/csv_data"

# create directory where table scripts are going to reside if it doesn't exist
if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi

# make the files
create_files() {
    local table="$1"

    if grep -iq "$table" "$tables_catalog"; then     
        # create output directory file
        sql_file="$output_dir/${table}.sql"

        # copy fields of table to file
        sed -n "/create table $table/,/);/p" "$input_file" > "$sql_file"

        # copy population command to file 
        printf "\ncopy $table from '${data_dir}/${table}.csv' with (format csv, delimiter ',');\n" >> "$sql_file"

        echo "Created $table.sql"
    else
        echo "Table Name: $table doesn't match with any dataset from tables_catalog.txt"
    fi
}

# get all table names and iterate over to create init_script for each table
grep -oP '(?<=create table\s)[a-zA-Z0-9_]+' "$input_file" | \
while read table_name; do
    create_files "$table_name"
done
