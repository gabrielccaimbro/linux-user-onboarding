#!/bin/bash

# ==========================================================
# Script: user_onboarding.sh
# Description: Automated User Onboarding & Group Permission Manager
# Note: Must be executed with root privileges (sudo)
# ==========================================================

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "[ERROR] Please run this script with sudo or as root."
  exit 1
fi

LOG_FILE="/var/log/user_onboarding.log"
DATETIME=$(date "+%Y-%m-%d %H:%M:%S")

# Function to onboard a user
onboard_user() {
    USERNAME=$1
    GROUP=$2
    SHARED_DIR="/company/$GROUP"

    # 1. Create Group if it doesn't exist
    if ! getent group "$GROUP" > /dev/null; then
        groupadd "$GROUP"
        echo "[$DATETIME] [SUCCESS] Group '$GROUP' created." >> "$LOG_FILE"
    fi

    # 2. Create User if it doesn't exist
    if id "$USERNAME" &>/dev/null; then
        echo "[$DATETIME] [WARNING] User '$USERNAME' already exists." >> "$LOG_FILE"
    else
        useradd -m -g "$GROUP" -s /bin/bash "$USERNAME"
        echo "[$DATETIME] [SUCCESS] User '$USERNAME' created and added to group '$GROUP'." >> "$LOG_FILE"
    fi

    # 3. Create Shared Directory with proper permissions
    if [ ! -d "$SHARED_DIR" ]; then
        mkdir -p "$SHARED_DIR"
        chown root:"$GROUP" "$SHARED_DIR"
        chmod 770 "$SHARED_DIR" # Only root and group members have full access
        echo "[$DATETIME] [SUCCESS] Shared directory '$SHARED_DIR' created with secured permissions (770)." >> "$LOG_FILE"
    fi
}

# --- EXECUTION DEMO ---
echo "Starting user onboarding process..."

# Example Users
onboard_user "alice_dev" "developers"
onboard_user "bob_sys" "sysadmins"

echo "Onboarding completed! Check log file at $LOG_FILE"
