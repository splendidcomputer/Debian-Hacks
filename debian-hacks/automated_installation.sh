#!/bin/bash

# Function to check if a command is available and install it if not
check_and_install() {
    if ! command -v "$1" &> /dev/null
    then
        echo "$1 is not installed, installing..."
        sudo apt update
        sudo apt install -y "$1"
    fi
}

# Check and install dependencies
check_and_install ubiquity

# Function to partition disk with LVM
partition_disk() {
    sudo parted /dev/nvme1n1 mklabel gpt
    sudo parted -a optimal /dev/nvme1n1 mkpart primary ext4 1MiB 2GiB
    sudo parted -a optimal /dev/nvme1n1 mkpart ESP fat32 2GiB 4GiB
    sudo parted -a optimal /dev/nvme1n1 mkpart primary ext4 4GiB 132GiB
    sudo parted -a optimal /dev/nvme1n1 mkpart primary linux-swap 132GiB 100%
    sudo parted /dev/nvme1n1 set 2 esp on
    sudo pvcreate /dev/nvme1n1p3
    sudo vgcreate my_volume_group /dev/nvme1n1p3
    sudo lvcreate -L 512G -n lv_root my_volume_group
    sudo lvcreate -L 128G -n lv_swap my_volume_group
    sudo lvcreate -l 100%FREE -n lv_home my_volume_group
    sudo mkfs.ext4 /dev/nvme1n1p1
    sudo mkfs.fat -F32 /dev/nvme1n1p2
    sudo mkfs.ext4 /dev/my_volume_group/lv_root
    sudo mkfs.ext4 /dev/my_volume_group/lv_home
    sudo mkswap /dev/my_volume_group/lv_swap
}

# Partition disk with LVM
partition_disk

# Launch the Ubuntu installer
ubiquity --automatic
