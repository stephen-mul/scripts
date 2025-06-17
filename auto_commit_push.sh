#!/bin/bash

# Define path to repo
REPO_PATH="/home/stephen/Documents/vault/"

# Navigate to repo 
cd "$REPO_PATH" || { echo "Repository path not found"; exit 1; }

# Skip pulling, I never want to pull changes to this repo 

# Stage all changes
git add .

# Commit changes with a timestamp
COMMIT_MESSAGE="Automated commit on $(date +"%Y-%m-%d %H:%M:%S")"
git commit -m "$COMMIT_MESSAGE"

# Push changes to remote
git push || { echo "Git push failed;" exit 1; }

echo "Commit and push completed successfully!"
