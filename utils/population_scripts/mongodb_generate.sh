#!/bin/bash

# Script description:
# @input: gets as arguemnts tables that belong into data/csv_data_tables_catalog.txt
# @output: nothing
# @side-effects: 
#   1. creates a postgres_populate.sql script with all the tables that was inserted as input \
#      using /datasource/table_population_scripts as templates
#   2. creates soft links with neccesary files to populate the database from data/csv_data to \
#      /data/postgres-data (then docker-compose copies it only)


tables_catalog="$HOME/ADIS_project24/data/tables_catalog.txt"
tables_definition="$HOME/ADIS_project24/datasources/table_population_scripts/mongodb"
output_file="$HOME/ADIS_project24/datasources/db_population_scripts/mongo_populate.sh"
init_script="$HOME/ADIS_project24/datasources/db_initialization_scripts/mongo_init.sh"

# validate arguement count and existence according to a file given
belongs_in_list () {
    if [ $# -gt $(wc -l < "$tables_catalog") ]; then
        printf "Given more arguements than neccessary\nSee $tables_catalog for valid input\n"
        exit 1
    fi

    for arg in "$@"; do
        if ! grep -q "$arg" "$tables_catalog"; then
            echo "Arguemnt: $arg doesn't belong in the list of arguments"
            echo "List of arguements given in $tables_catalog"
            exit 1
        fi
    done

    echo "All arguments valid"
}


# create a file that has the definitions and population scripts of the tables given as arguements
create_population_script () {

    # Handle special argument "all"
    if [[ "$1" == "all" ]]; then
        # Get all table names from the tables_definition directory
        set -- $(cat "$tables_catalog")
    fi

    # verify arguements
    belongs_in_list "$@"

    # iterate over all arguements and put the output into a single population file
    cp "$init_script" "$output_file"
    for arg in "$@"; do
        cat "$tables_definition"/"$arg".sh >> "$output_file"
        printf "\n" >> "$output_file"
    done

    echo "Population script for mongodb generated successfully"
}


create_population_script "$@"
