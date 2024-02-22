#!/bin/bash

mcVersion=$1
project=$2

if [ -z "$mcVersion" ] || [ -z "$project" ]; then
    echo "mcVersion and project cannot be null."
    echo "Usage ./AdvancedSlimeDownloader.sh <mcVersion> <project>"
    exit 0
fi

echo "Selected version $mcVersion"
echo "Selected project $project"

# Retrieve JSON data from the URL
json_url="https://api.infernalsuite.com/v1/projects/$project/mcversion/$mcVersion/latest"
json_data=$(curl -s "$json_url")

# Parse JSON and construct download links
files=$(echo "$json_data" | jq -c '.files[]')
buildId=$(echo "$json_data" | jq -r '.id')

if [ "$buildId" == "null" ]; then
    echo "Build ID cannot be found. Cancelling."
    exit 0
fi

echo "Latest build id: $buildId"

for file in $files; do
    fileName=$(echo "$file" | jq -r '.fileName')
    fileId=$(echo "$file" | jq -r '.id')
    downloadLink="https://api.infernalsuite.com/v1/projects/$project/$buildId/download/$fileId"

    echo "Downloading [$fileName] from $downloadLink"

    # Download file using curl
    curl -o "$fileName" "$downloadLink"

    echo "Downloaded $fileName"
done