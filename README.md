# Linux Automated User Onboarding & Access Control

Identity and Access Management (IAM) automation tool built in **Bash Shell** for managing Linux users, system groups, and secure directory permissions.

## 🚀 Features

- **Automated Privilege Check:** Validates execution root privileges (`EUID`) before running system-modifying operations.
- **Group & User Creation:** Dynamically verifies and creates non-existing user groups and user accounts with default Bash shells.
- **Shared Directory Hardening:** Provisions dedicated shared group directories (`/company/<group>`) with restricted POSIX permissions (`770`).
- **Audit Logging:** Logs every execution status (`[SUCCESS]`, `[WARNING]`, `[ERROR]`) with timestamp details under `/var/log/user_onboarding.log`.

## 🛠️ Technologies Used

- **Linux (Ubuntu)**
- **Bash Shell Scripting**
- **Linux Security & User Management (`useradd`, `groupadd`, `chmod`, `chown`)**
- **POSIX File System Permissions**

## 💻 How to Run

1. Make the script executable:
   ```bash
   chmod +x user_onboarding.sh
