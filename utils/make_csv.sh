#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file.dat>"
    exit 1
fi

# Input file
input_file="$1"

# Check if the file exists
if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found."
    exit 1
fi

# Generate the output CSV file name
output_file="${input_file%.dat}.csv"  # Replace .dat with .csv

# Replace every '|' with ',' and save to the output CSV file
sed 's/|/,/g' "$input_file" > "$output_file"

echo "Replaced '|' with ',' in '$input_file' and saved as '$output_file'."
