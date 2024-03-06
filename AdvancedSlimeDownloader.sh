#!/bin/bash

mcVersion=$1
project=$2
branchName=$3

if [ -z "$mcVersion" ] || [ -z "$project" ] || [ -z "$branchName" ]; then
    echo "mcVersion, project, and branchName cannot be null."
    echo "Usage ./AdvancedSlimeDownloader.sh <mcVersion> <project> <branchName>"
    exit 0
fi

echo "Selected version $mcVersion"
echo "Selected project $project"
echo "Selected branch $branchName"

# Retrieve JSON data from the URL
#json_url="https://api.infernalsuite.com/v1/projects/$project/mcversion/$mcVersion/latest" # This api endpoint atm return the wrong build files
json_url="https://api.infernalsuite.com/v1/projects/$project/mcversion/$mcVersion"
json_data=$(curl -s "$json_url")

# Filter JSON data based on branch name and select the most recent build
filtered_data=$(echo "$json_data" | jq -r ".[] | select(.branch == \"$branchName\")")

# Check if the filtered data is empty
if [ -z "$filtered_data" ]; then
    echo "Branch '$branchName' not found. Cancelling."
    exit 0
fi

sorted_data=$(echo "$filtered_data" | jq -s "sort_by(.date)[]")
last=$(echo "$sorted_data" | jq -s "last")

# Extract necessary information from the filtered data
files=$(echo "$last" | jq -c '.files[]')
buildId=$(echo "$last" | jq -r '.id')

if [ "$buildId" == "null" ] || [ -z "$buildId" ]; then
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