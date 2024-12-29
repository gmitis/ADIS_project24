#!/bin/bash

input_file="$HOME/ADIS_project24/datasources/tpcds.sql"
output_dir="$HOME/ADIS_project24/datasources/population_scripts/mongodb"
tables_catalog="$HOME/ADIS_project24/data/csv_data/tables_catalog.txt"
data_dir="$HOME/ADIS_project24/data/csv_data"

if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi
