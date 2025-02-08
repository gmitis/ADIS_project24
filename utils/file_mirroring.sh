#!/bin/bash

# Directory to watch
SOURCE_DIR="$HOME/ADIS_project24"

# Remote VMs
VMs=("ubuntu@snf-77898:~/ADIS_project24" "ubuntu@snf-77016:~/ADIS_project24" "ubuntu@snf-77020:~/ADIS_project24")

# Watch for changes and sync
inotifywait -m -r -e modify,create,delete,move "$SOURCE_DIR" | while read path action file; do
    echo "Detected change: $action in $file"
    for vm in "${VMs[@]}"; do
        rsync -avz --delete "$SOURCE_DIR/" "$vm/"
    done
done
