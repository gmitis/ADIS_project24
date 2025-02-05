#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <file.dat>"
    exit 1
fi

# Input file
input_file="$1"
cd ~/ADIS_project24/data/original_data

# Check if the file exists
if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found."
    exit 1
fi

# Create a temporary file for the modified content
temp_file="${input_file}.tmp"

# Remove the last character of every line using sed and replace , with .
sed -n 's/|$//' "$input_file" 
sed -i 's/,/-/g' "$input_file"


echo "Last character removed from every line of '$input_file'."
