#!/bin/bash
set -e  # Exit immediately if any command fails

echo "Starting deployment..."

# 1️⃣ Install dependencies
npm ci

# 2️⃣ Build React app
npm run build

# 3️⃣ Archive build artifacts (optional)
BUILD_ARCHIVE="${JOB_NAME}_${GIT_BRANCH//\//_}.tar.gz"
tar -czvf "$BUILD_ARCHIVE" build

# 4️⃣ Deploy build files to target directory
TARGET_DIR="/var/www/html/Frontend-task"
mkdir -p "$TARGET_DIR"
cp -r build/* "$TARGET_DIR"
echo "Build files deployed to $TARGET_DIR"

# 5️⃣ Restart Nginx to serve updated files
echo "Restarting Nginx..."
sudo systemctl reload nginx
echo "Nginx restarted successfully!"

# 6️⃣ Optional: print Git committer info
echo "Hello, ${GIT_COMMITTER_NAME:-unknown user}!"

echo "Deployment script completed successfully!"
