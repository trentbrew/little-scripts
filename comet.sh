#!/bin/bash

# Define paths
DIFF_FILE="/tmp/git_diff.txt"
SCRIPT_PATH="/Users/trent/turtle/operations/LLMs/gpt/src/assistant/chat.mjs"

# Ensure the script path is provided
if [[ -z "$SCRIPT_PATH" ]]; then
  echo "Error: No file path provided."
  exit 1
fi

# Get the diff and save it to a file
git diff --cached >"$DIFF_FILE"

# Check if the diff file has content
if [[ ! -s $DIFF_FILE ]]; then
  echo "No staged changes to commit."
  rm "$DIFF_FILE"
  exit 1
fi

# Run chat.mjs with the diff file and capture the output
COMMIT_MSG=$(node "$SCRIPT_PATH" "$DIFF_FILE")

# Ensure a non-empty commit message
if [[ -z "$COMMIT_MSG" ]]; then
  echo "Generated commit message is empty. Aborting commit."
  rm "$DIFF_FILE"
  exit 1
fi

# Commit with the generated message
git commit -m "$COMMIT_MSG"

# Clean up
rm "$DIFF_FILE"
