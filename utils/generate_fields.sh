#! /bin/bash

input_file="$HOME/ADIS_project24/datasources/tpcds.sql"

generate_fields() {
    local table_name="$1"

    # get database fields
    table=$(sed -n "/^create table $table_name\\b/,/);/p" "$input_file")
    fields=$(echo "$table" | \
             grep -oP '^\s*\w+' | \
             awk '{print $1}' | \
             paste -sd ',' - | \
             awk -F, '{for (i=2; i<NF; i++) printf $i (i<NF-1 ? "," : "")}')

    # return string with all the fields separated by comma
    echo "$fields"
}

generate_fields "$1"
