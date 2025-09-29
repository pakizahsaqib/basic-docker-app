#!/bin/bash
# A simple deployment script to update the running application

echo "--- Deployment Started ---"

# Stop and remove running containers (defined in docker compose.yml)
# We must stop the old version before pulling the new code and rebuilding.
echo "Stopping and removing existing containers..."
docker compose down

# Fetch the latest code from GitHub
# This ensures we have the latest Dockerfile and application code.
echo "Fetching latest code from Git..."
git pull origin main

# Rebuild the Docker image
# This step takes the new code and creates a fresh image blueprint.
echo "Rebuilding Docker image..."
docker compose build

# Start the new container(s) in detached mode
# Starts the new container using the newly built image.
echo "Starting containers..."
docker compose up -d

echo "--- Deployment Complete ---"
