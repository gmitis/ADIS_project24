#!/bin/bash

# Directory to sync
SOURCE_DIR="$HOME/ADIS_project24"

# Remote VMs (you can list more than one if needed)
VMs=("ubuntu@snf-77898:~/ADIS_project24" "ubuntu@snf-77016:~/ADIS_project24" "ubuntu@snf-77020:~/ADIS_project24")

# Loop through each remote VM and perform one-time synchronization
for vm in "${VMs[@]}"; do
    rsync -avz --delete         \
          --exclude='data/'     \
          "$SOURCE_DIR/" "$vm/"
done