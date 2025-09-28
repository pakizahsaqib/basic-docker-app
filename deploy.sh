#!/bin/bash
# A robust deployment script with better error handling and PATH resolution

set -e  # Exit on any error

echo "--- Deployment Started ---"

# Set PATH to ensure we can find docker-compose and other commands
export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"

# Function to check if docker-compose is available
check_docker_compose() {
    if command -v docker-compose >/dev/null 2>&1; then
        echo "Using docker-compose at: $(which docker-compose)"
        return 0
    elif docker compose version >/dev/null 2>&1; then
        echo "Using docker compose plugin"
        alias docker-compose='docker compose'
        return 0
    else
        echo "ERROR: Neither docker-compose nor docker compose plugin found!"
        echo "Available docker commands:"
        docker --help | grep -A 20 "Commands:"
        return 1
    fi
}

# Check docker-compose availability
if ! check_docker_compose; then
    echo "Falling back to pure Docker commands..."
    
    # Stop and remove existing container
    echo "Stopping and removing existing containers..."
    docker stop basic-docker-app 2>/dev/null || true
    docker rm basic-docker-app 2>/dev/null || true
    
    # Fetch the latest code from GitHub
    echo "Fetching latest code from Git..."
    git pull origin main
    
    # Build the Docker image
    echo "Rebuilding Docker image..."
    docker build -t basic-docker-app:latest .
    
    # Start the new container
    echo "Starting container..."
    docker run -d --name basic-docker-app -p 80:3000 --restart unless-stopped basic-docker-app:latest
    
else
    # Use docker-compose
    echo "Stopping and removing existing containers..."
    docker-compose down || true
    
    # Fetch the latest code from GitHub
    echo "Fetching latest code from Git..."
    git pull origin main
    
    # Rebuild the Docker image
    echo "Rebuilding Docker image..."
    docker-compose build
    
    # Start the new container(s) in detached mode
    echo "Starting containers..."
    docker-compose up -d
fi

echo "--- Deployment Complete ---"

# Show running containers
echo "Currently running containers:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
