#!/bin/bash

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Output file
OUTPUT_FILE="$SCRIPT_DIR/config.yaml"
PROVIDER_DIR="$SCRIPT_DIR/Provider"

# GitHub base URL
GITHUB_BASE_URL="https://raw.githubusercontent.com/radCircle114514/clash-providers/master/Provider"

# # Start writing the output file
# echo "rule-providers:" > "$OUTPUT_FILE"

# Check if Provider directory exists
if [ ! -d "$PROVIDER_DIR" ]; then
    echo "Error: Provider directory not found!"
    exit 1
fi

rm -f "$OUTPUT_FILE"

# Loop through all .yaml files in Provider directory
for file in "$PROVIDER_DIR"/*.yaml; do
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
