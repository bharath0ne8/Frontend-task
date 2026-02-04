#!/bin/bash
set -e   # Exit immediately if a command fails

echo "Starting deployment..."

# List current files
ls

# Install dependencies (force to avoid conflicts)
npm ci

# Build React app
npm run build

# Archive build artifacts
BUILD_ARCHIVE="${JOB_NAME}_${GIT_BRANCH//\//_}.tar.gz"
tar -czvf "$BUILD_ARCHIVE" build

# Optional: print git user who triggered the build
echo "Hello, ${GIT_COMMITTER_NAME:-unknown user}!"

# List files after build
ls

echo "Deployment script completed successfully!"
