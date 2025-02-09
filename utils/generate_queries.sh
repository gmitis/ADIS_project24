#!/bin/bash

TOOLS_DIR="$HOME/ADIS_project24/DSGen/tools"
TEMPLATES_DIR="$HOME/ADIS_project24/DSGen/query_templates"  # Replace with the actual path to query templates
OUTPUT_DIR="$HOME/ADIS_project24/utils/initial_queries/test"             # Replace with the desired output directory
DIALECT="ansi"                           # Dialect for the queries
SCALE="$1"


if [ "$#" -ne 2 ]; then
    echo "Usage: $0 [data_scale_factor:integer]"
fi

cd "$TOOLS_DIR" || { echo "Failed to change directory to $TOOLS_DIR"; exit 1; }

# remove any queries left from before
rm -rf "$OUTPUT_DIR"/*

for i in $(seq 1 99); do
    TEMPLATE="query${i}.tpl"  # Query template file
    OUTPUT_FILE="$OUTPUT_DIR/query${i}.sql"  # Desired output file
c
    echo "Generating $OUTPUT_FILE from $TEMPLATE..."

    # Run the dsqgen command for the current query template
    ./dsqgen -directory "$TEMPLATES_DIR" \
             -template "$TEMPLATE" \
             -dialect "$DIALECT" \
             -scale "$SCALE" \
             -output "$OUTPUT_DIR"

    # Rename the generated file to the correct query name
    mv "$OUTPUT_DIR/query_0.sql" "$OUTPUT_DIR/query${i}.sql"
done

echo "All queries have been generated in $OUTPUT_DIR."