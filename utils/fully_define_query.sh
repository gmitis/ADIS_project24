#!/bin/bash

# ATTENTION: there are some fields inside select statements like select 'store channel' as channel in query80.sql that get replaced as well but it doesn't affect us in the slightest

# Define table lists for each database
cassandra_tables=("inventory" "store_returns" "web_returns" "catalog_returns" "reason" "ship_mode")  
mongo_tables=("customer" "customer_address" "household_demographics" "income_band" "promotion" "web_page" "call_center" "dbgen_version" "catalog_page")  
postgres_tables=("store_sales" "catalog_sales" "web_sales" "date_dim" "item" "warehouse" "time_dim" "store" "web_site" "customer_demographics")  


# Check if directory is provided
if [[ $# -eq 0 ]]; then
    echo "Error: No directory provided!"
    echo "Usage: $0 valid_path/to/queries_directory || $0 valid_path/to/queries_directory mongo_tables_array cassandra_tables_array  postgres_tables_array "
    exit 1
fi

# if there are 5 parameters then we have arrays of tables for the databases as input
if [[ $# -eq 5 ]]; then
    mongo_tables="$2"
    cassandra_tables="$3"
    postgres_tables="$4"
fi

# directory path where queries recide
SQL_DIR="$1"

# Check if directory exists
if [[ ! -d "$SQL_DIR" ]]; then
    echo "Error: Directory '$SQL_DIR' not found!"
    exit 1
fi

# Function to replace table names in an SQL file
replace_tables() {
    local SQL_FILE="$1"        # SQL file to process
    local db_prefix="$2"       # Database prefix (cassandra/mongo/postgresql)
    local schema_prefix="$3"   # Schema prefix

    shift 3                    # Remove first three arguments to access table names
    local table_list=("$@")    # Get array of tables

    # Replace table names with catalog.schema.table
    for table in "${table_list[@]}"; do
        sed -i "s/\b${table}\b/${db_prefix}.${schema_prefix}.${table}/g" "$SQL_FILE"
    done
}

# Iterate over all `.sql` files in the directory
for SQL_FILE in "$SQL_DIR"/*.sql; do
    # Check if there are matching SQL files
    if [[ ! -f "$SQL_FILE" ]]; then
        echo "No SQL files found in '$SQL_DIR'."
        exit 1
    fi

    echo "Processing file: $SQL_FILE"

    # Apply table replacements
    replace_tables "$SQL_FILE" "cassandra" "adis" "${cassandra_tables[@]}"
    replace_tables "$SQL_FILE" "mongodb" "adis" "${mongo_tables[@]}"
    replace_tables "$SQL_FILE" "postgresql" "public" "${postgres_tables[@]}"

    echo "Table names replaced successfully in '$SQL_FILE'."
done

echo "All SQL files in '$SQL_DIR' processed successfully."
echo "!!!ATTENTION: You need to remove catalog.schema from select attribute statements!!! ... catalog.schema.table needs to be only in from statements"
