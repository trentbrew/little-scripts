#!/bin/bash

# Prompt for a name if not provided
if [ -z "$1" ]; then
  read -p "Enter the repository name: " REPO_NAME
else
  REPO_NAME=$1
fi

# Create the directory
mkdir -p "$REPO_NAME" || {
  echo "Failed to create directory $REPO_NAME"
  exit 1
}

# Navigate into the directory
cd "$REPO_NAME" || {
  echo "Failed to navigate to $REPO_NAME"
  exit 1
}

# Initialize Git repository
git init || {
  echo "Failed to initialize Git repository"
  exit 1
}

# Create a README.md file
echo "# $REPO_NAME" >README.md

# Stage and commit the README.md file
git add README.md
git commit -m "Initial commit" || {
  echo "Failed to commit"
  exit 1
}

echo "Repository '$REPO_NAME' created successfully!"
