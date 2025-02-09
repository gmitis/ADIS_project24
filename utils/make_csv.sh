#!/bin/bash

original_data="$HOME/ADIS_project24/data/original_data"
tables_catalog="$HOME/ADIS_project24/data/tables_catalog.txt"
csv_data="$HOME/ADIS_project24/data/csv_data"

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

# create catalog of all of the directories that exists inside the directory
mkdir -p "$csv_data"
ls "$input_directory" > "$tables_catalog"


# create csv files iteratively
cd "$csv_data"
while IFS= read -r input_file; do
    # clean file (each file contains extra "," in the end)
    ~/ADIS_project24/utils/clean_data.sh $input_file    

    # convert file to csv
    output_file="${input_file%.dat}.csv"  # Replace .dat with .csv
    sed 's/|/,/g' "$original_data"/"$input_file" > "$output_file" 

    echo "Replaced '|' with ',' in '$input_file' and saved as '$output_file'."

    # Delete the original .dat file
    rm -f "$original_data"/"$input_file"
    echo "Deleted original file: '$input_file'"
done < "$tables_catalog"

# remove .dat ending from list of tables
sed -i "s/.dat//g" "$tables_catalog"
