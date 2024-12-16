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

# Create a temporary file for the modified content
temp_file="${input_file}.tmp"

# Remove the last character of every line using sed
sed 's/|$//' "$input_file" > "$temp_file"

# Replace the original file with the modified content
mv "$temp_file" "$input_file"

echo "Last character removed from every line of '$input_file'."
