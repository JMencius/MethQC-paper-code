#!/bin/bash

LINKS_FILE="../data/rawdata_link.txt"
BASE_DIR="../data/"


if [ ! -f "$LINKS_FILE" ]; then
    echo "Error: $LINKS_FILE not found."
    exit 1
fi


while IFS=$' \t' read -r url sample_name || [ -n "$url" ]; do
    [ -z "$url" ] && continue
    
    FOLDER_PATH="${BASE_DIR}/${sample_name}"
    
    # check folders
    if [ -d "$FOLDER_PATH" ]; then
        echo "Folder $FOLDER_PATH exists. Proceeding with download..."
    else
        echo "Folder $FOLDER_PATH does not exist. Creating it..."
        mkdir -p "$FOLDER_PATH"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to create directory $FOLDER_PATH."
            continue
        fi
    fi
    
    # download to the specified folder
    aria2c -c -s 20 -x 16 -j 20 --file-allocation=none -d "$FOLDER_PATH" "$url"
    
    # check if the download is successful
    if [ $? -eq 0 ]; then
        echo "Successfully downloaded: $url to $FOLDER_PATH/"
    else
        echo "Failed to download: $url to $FOLDER_PATH/"
    fi
done < "$LINKS_FILE"

echo "Download process completed."

