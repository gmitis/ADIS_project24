#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <absolute path of directory with all of the files to be converted>"
    exit 1
fi

# Input directory
input_directory="$1"

# Check if the directory exists
if [ ! -d "$input_directory" ]; then
    echo "Error: Directory '$input_directory' not found OR Wrong path provided."
    exit 1
fi

# create catalog of all of the directorys that exists inside the directory
mkdir -p /home/ubuntu/ADIS_project24/data/csv_data && cd ./data/csv_data
if [ ! -f tables_catalog.txt ];  then
    touch tables_catalog.txt
    ls "$input_directory" >>  tables_catalog.txt
fi 

# create csv files iteratively
while IFS= read -r input_file; do
    # clean file (each file contains extra "," in the end)
    ~/ADIS_project24/utils/clean_data.sh $input_file    

    # convert file to csv
    output_file="${input_file%.dat}.csv"  # Replace .dat with .csv
    sed 's/|/,/g' "$input_file" > "$output_file" 
    rm $input_file

    echo "Replaced '|' with ',' in '$input_file' and saved as '$output_file'."
done < tables_catalog.txt


