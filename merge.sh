#!/bin/bash

# Output file
OUTPUT_FILE="config.yaml"

# GitHub base URL
GITHUB_BASE_URL="https://raw.githubusercontent.com/radCircle114514/clash-providers/master/Provider"

# # Start writing the output file
# echo "rule-providers:" > "$OUTPUT_FILE"

# Check if Provider directory exists
if [ ! -d "Provider" ]; then
    echo "Error: Provider directory not found!"
    exit 1
fi

rm -f "$OUTPUT_FILE"

# Loop through all .yaml files in Provider directory
for file in Provider/*.yaml; do
    # Check if any yaml files exist
    if [ ! -e "$file" ]; then
        echo "No .yaml files found in Provider directory"
        exit 1
    fi

    # Get the filename without path and extension
    filename=$(basename "$file" .yaml)

    # Write the rule-provider entry
    echo "$filename: { type: http, behavior: classical, url: '$GITHUB_BASE_URL/$filename.yaml', path: ./Rules/$filename, interval: 86400 }" >> "$OUTPUT_FILE"
done

echo "Merged config file created: $OUTPUT_FILE"
