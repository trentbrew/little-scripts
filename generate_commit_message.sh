#!/bin/bash

# Temporary file to store the diff
TEMP_DIFF_FILE=$(mktemp)

# Function to clean up the temporary file on exit
cleanup() {
  rm -f "$TEMP_DIFF_FILE"
}
trap cleanup EXIT

# Generate the git diff and save it to the temporary file
git diff >"$TEMP_DIFF_FILE"

# Check if the diff file is empty
if [ ! -s "$TEMP_DIFF_FILE" ]; then
  echo "No changes detected in the working directory."
  exit 0
fi

# Use the LLM CLI to process the diff and generate a commit message
COMMIT_MESSAGE=$(llm "Please write a commit message based on this diff: $(cat "$TEMP_DIFF_FILE")")

# Print the generated commit message
echo "Generated commit message:"
echo "$COMMIT_MESSAGE"

# Optionally stage all changes and commit using the generated message
read -p "Do you want to commit with this message? (y/N): " CONFIRM
if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
  git add .
  git commit -m "$COMMIT_MESSAGE"
  echo "Changes committed."
else
  echo "Commit aborted."
fi
