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
check_and_install parted
check_and_install pvcreate
check_and_install vgcreate
check_and_install lvcreate
check_and_install mkfs.ext4
check_and_install mkfs.fat

# Partition the disk
sudo parted /dev/nvme1n1 mklabel gpt

# Create Boot Partition (2GB)
sudo parted -a optimal /dev/nvme1n1 mkpart primary ext4 1MiB 2GiB

# Create EFI Partition (2GB)
sudo parted -a optimal /dev/nvme1n1 mkpart ESP fat32 2GiB 4GiB

# Create LVM Partition (remaining space)
sudo parted -a optimal /dev/nvme1n1 mkpart primary ext4 4GiB 100%

# Set Boot Flag on EFI Partition
sudo parted /dev/nvme1n1 set 2 esp on

# Create Physical Volume for LVM
sudo pvcreate /dev/nvme1n1p3

# Create Volume Group (Allocate 512GB for Root)
sudo vgcreate my_volume_group /dev/nvme1n1p3

# Create Logical Volume for Root
sudo lvcreate -L 512G -n lv_root my_volume_group

# Create Logical Volume for Home (remaining space)
sudo lvcreate -l 100%FREE -n lv_home my_volume_group

# Format Boot Partition
sudo mkfs.ext4 /dev/nvme1n1p1

# Format EFI Partition
sudo mkfs.fat -F32 /dev/nvme1n1p2

# Format Root Logical Volume
sudo mkfs.ext4 /dev/my_volume_group/lv_root

# Format Home Logical Volume
sudo mkfs.ext4 /dev/my_volume_group/lv_home
