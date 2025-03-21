#!/bin/bash

# wrangle-dotfiles: Copy essential dotfiles into a timestamped directory on external drive
# Excludes unnecessary, sensitive, and cache-related files with verbosity and spinner.

# Exit on errors
set -e

# Define target directory with timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
TARGET_DIR="/volumes/passport/trent/dotfiles/$TIMESTAMP"

# Define size limit (100 MB in bytes)
SIZE_LIMIT=$((100 * 1024 * 1024)) # 100 MB

# Exclude list: Add unnecessary or sensitive files here
EXCLUDE_LIST=(
  ".env"
  ".ssh"
  ".aws"
  ".netrc"
  ".vault"
  ".bash_history"
  ".zsh_history"
  ".python_history"
  ".npm/_logs"
  ".node_repl_history"
  ".Trash"
  ".DS_Store"
  "Library"      # Exclude macOS Library directory
  "__dotfiles__" # Prevent recursive inclusion
  "cache"        # General pattern to exclude cache directories
)

# Spinner function for visual feedback
spin() {
  local pid=$1
  local delay=0.1
  local spinner=('|' '/' '-' '\')

  while kill -0 "$pid" 2>/dev/null; do
    for i in "${spinner[@]}"; do
      echo -ne "\r$i"
      sleep "$delay"
    done
  done
  echo -ne "\r" # Clean up spinner
}

# Function to check if a file or directory is excluded
is_excluded() {
  local name="$1"
  for excluded in "${EXCLUDE_LIST[@]}"; do
    if [[ "$name" == *"$excluded"* ]]; then
      return 0
    fi
  done
  return 1
}

# Function to check if a file exceeds the size limit
is_too_large() {
  local file_size
  file_size=$(stat -f%z "$1" 2>/dev/null || echo 0) # macOS stat
  # For Linux: file_size=$(stat --format="%s" "$1" 2>/dev/null || echo 0)
  if ((file_size > SIZE_LIMIT)); then
    return 0
  fi
  return 1
}

# Start copying process
echo "Starting wrangle-dotfiles..."
echo "Target directory: $TARGET_DIR"

# Create the target directory structure if it doesn't exist
mkdir -p "$TARGET_DIR"
echo "✔ Created target directory: $TARGET_DIR"

# Process files and directories
echo "Processing dotfiles..."
{
  for file in .[^.]*; do
    if is_excluded "$file"; then
      echo "⏩ Skipping excluded file/directory: $file"
    elif [[ -d "$file" && "$file" == *"cache"* ]]; then
      echo "⏩ Skipping cache directory: $file"
    elif is_too_large "$file"; then
      echo "⏩ Skipping large file: $file (exceeds $SIZE_LIMIT bytes)"
    else
      echo "📂 Copying $file to $TARGET_DIR/"
      cp -R "$file" "$TARGET_DIR/"
    fi
  done
} &
spin $! # Attach spinner to the background process

echo "✔ Dotfiles have been copied to $TARGET_DIR!"
echo "Excluding unnecessary files, caches, and oversized files."
