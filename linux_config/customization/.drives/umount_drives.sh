#!/bin/bash

# Function to check if a drive is already mounted
is_mounted() {
    local MOUNT_POINT="$1"
    if mountpoint -q "$MOUNT_POINT"; then
        return 0  # Mounted
    else
        return 1  # Not mounted
    fi
}

umount_drive() {
    local MOUNT_POINT="$1"

    if is_mounted "$MOUNT_POINT"; then
        sudo umount "$MOUNT_POINT"
        echo "$MOUNT_POINT was disconnected."
    else 
        echo "$MOUNT_POINT was not mounted."
    fi
}

# First drive
MOUNT_POINT1="/mnt/d"

# Second drive
MOUNT_POINT2="/mnt/z"

# Unmount the drives if they are connected
umount_drive "$MOUNT_POINT1"
umount_drive "$MOUNT_POINT2"