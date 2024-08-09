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

# Function to mount a drive if it's not already mounted
mount_drive() {
    local DRIVE_LETTER="$1"
    local MOUNT_POINT="$2"
    local MOUNT_COMMAND="$3"

    if is_mounted "$MOUNT_POINT"; then
        echo "$DRIVE_LETTER is already mounted at $MOUNT_POINT."
    else
        if [ ! -d "$MOUNT_POINT" ]; then
            sudo mkdir -p "$MOUNT_POINT"
        fi

        # Execute the provided mount command
        eval "$MOUNT_COMMAND"
        echo "$DRIVE_LETTER mounted at $MOUNT_POINT."
    fi
}

# Function to unmount a drive if it's disconnected
unmount_drive() {
    local MOUNT_POINT="$1"

    if ! is_mounted "$MOUNT_POINT" && [ -d "$MOUNT_POINT" ]; then
        sudo umount "$MOUNT_POINT"
        sudo rmdir "$MOUNT_POINT"
        echo "$MOUNT_POINT is disconnected and removed."
    fi
}

# First drive
DRIVE_LETTER1="D:"
MOUNT_POINT1="/mnt/d"
MOUNT_COMMAND1="sudo mount -t drvfs $DRIVE_LETTER1 $MOUNT_POINT1 -o uid=1000,gid=1000,umask=22,fmask=11"

# Second drive (replace with the appropriate command)
DRIVE_LETTER2="Z:"
MOUNT_POINT2="/mnt/z"
MOUNT_COMMAND2="sudo mount -t cifs //pipepi.ddns.net/Data $MOUNT_POINT2 -o username=pipepi,password=Santiagoa1a++,uid=1000,gid=1000,mfsymlinks"

# Mount the drives
mount_drive "$DRIVE_LETTER1" "$MOUNT_POINT1" "$MOUNT_COMMAND1"
mount_drive "$DRIVE_LETTER2" "$MOUNT_POINT2" "$MOUNT_COMMAND2"

# Unmount the drives if they are disconnected
unmount_drive "$MOUNT_POINT1"
unmount_drive "$MOUNT_POINT2"
