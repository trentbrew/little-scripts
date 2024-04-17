#!/bin/bash

# Check for the project name argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

# Capture the project name
PROJECT_NAME=$1

# Create a new directory for the project
mkdir "$PROJECT_NAME"

# Navigate into the project directory
cd "$PROJECT_NAME" || exit

# Create a Conda environment with the project name
conda create --name "$PROJECT_NAME" python=3

# Activate the Conda environment
# For Conda versions prior to 4.6, use `source activate`
# For Conda 4.6 and later, use `conda activate`
conda activate "$PROJECT_NAME"

# Create an empty requirements.txt file
touch requirements.txt

# Note: We typically don't deactivate the environment immediately in Conda
# because there's no need to return to a base environment when using the script.
# However, if you want to deactivate, you can use `conda deactivate`

# Display a success message
echo "Python project '$PROJECT_NAME' set up successfully with a Conda environment."
echo "Requirements.txt initialized."
echo "Activate the Conda environment by running 'conda activate $PROJECT_NAME' within the project directory."

# `mkdir new-python-project && cd new-python-project && conda --name new-python-project python=3 && conda activate && touch requirements.txt && echo "Created new python project"`