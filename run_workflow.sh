#!/bin/bash

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null
then
    echo "GitHub CLI could not be found. Please install it first."
    echo "Visit https://cli.github.com/ for installation instructions."
    exit 1
fi

# Check if user is authenticated with GitHub CLI
if ! gh auth status &> /dev/null
then
    echo "You're not authenticated with GitHub CLI. Please run 'gh auth login' first."
    exit 1
fi

# Get the current repository
REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)

# Get list of available workflows
echo "Available workflows:"
gh workflow list -R "$REPO"

# Prompt user to choose a workflow
read -p "Enter the name of the workflow you want to run: " WORKFLOW_NAME

# Run the selected workflow
echo "Running workflow: $WORKFLOW_NAME"
gh workflow run "$WORKFLOW_NAME" -R "$REPO"

echo "Workflow triggered successfully. Check the Actions tab in your GitHub repository for progress."
