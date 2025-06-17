#!/bin/bash

# Define the backup directory
BACKUP_DIR="$HOME/bash-backup"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Copy the .bashrc and .bash_aliases files to the backup directory
cp "$HOME/.bashrc" "$BACKUP_DIR"
cp "$HOME/.bash_aliases" "$BACKUP_DIR"

# Navigate to the backup directory
cd "$BACKUP_DIR"

# Add and commit changes
git add .bashrc .bash_aliases
git commit -m "Backup of .bashrc and .bash_aliases"

# Push changes to the remote repository
git push origin main