#!/bin/bash

input_file="$HOME/ADIS_project24/datasources/tpcds.sql"
output_dir="$HOME/ADIS_project24/datasources/table_population_scripts/cassandra"
tables_catalog="$HOME/ADIS_project24/data/tables_catalog.txt"
data_dir="/data"

rm -rf "$output_dir" && mkdir -p "$output_dir"


# make the files
create_files() {
    local table="$1"

    if grep -iq "^$table$" "$tables_catalog"; then     
        # create output directory file
        cql_file="$output_dir/${table}.cql"

        # copy fields of table to file
        sed -n "/^create table $table\\b/,/);/p" "$input_file" > "$cql_file"

        # change sql types to types supported by cassandra
        sed -i "s/\bdate\b/timestamp/g" "$cql_file" 
        sed -i "s/\binteger\b/int/g" "$cql_file" 
        sed -i "s/\bnot null\b//g" "$cql_file"  
        sed -i -E "s/\b(char|varchar)\([0-9]+\)/text/g" "$cql_file"
        sed -i -E "s/\bdecimal\([0-9]+,[0-9]+\)/decimal/g" "$cql_file" 

        # create a string with the names of the fields separated by comma
        fields=$($HOME/ADIS_project24/utils/generate_fields.sh "$table")

        # copy population command to file 
        printf "COPY $table("$fields")\nFROM '${data_dir}/${table}.csv'\nWITH NULL='';\n" >> "$cql_file"
        printf "\n" >> "$cql_file"

        echo "Created $table.cql"
    else
        echo "Table Name: $table doesn't match with any dataset from tables_catalog.txt"
    fi
}

# get all table names and iterate over to create init_script for each table
grep -oP '(?<=create table\s)[a-zA-Z0-9_]+' "$input_file" | \
while read table_name; do
    create_files "$table_name"
done
