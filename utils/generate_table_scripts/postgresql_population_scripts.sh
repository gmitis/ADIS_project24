#! /bin/bash

input_file="$HOME/ADIS_project24/datasources/tpcds.sql"
output_dir="$HOME/ADIS_project24/datasources/table_population_scripts/postgresql"
tables_catalog="$HOME/ADIS_project24/data/tables_catalog.txt"
data_dir="/data"

# create directory where table scripts are going to reside if it doesn't exist
rm -rf "$output_dir" && mkdir -p "$output_dir"

# make the files
create_files() {
    local table="$1"

    if grep -iq "^$table$" "$tables_catalog"; then     
        # create output directory file
        sql_file="$output_dir/${table}.sql"

        # copy fields of table to file
        sed -n "/^create table $table\\b/,/);/p" "$input_file" > "$sql_file"
        sed -i "s/create table $table/create unlogged table $table/i" "$sql_file"

        # copy population command to file 
        echo "copy $table from '${data_dir}/${table}.csv' with (format csv, delimiter ',');" >> "$sql_file"
        printf "\n" >> "$sql_file"

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
