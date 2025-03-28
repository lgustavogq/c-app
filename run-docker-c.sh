#!/bin/bash

# Check if Docker is installed and running
if ! command -v docker &> /dev/null; then
    echo "Docker could not be found. Please install Docker first."
    exit 1
fi

# Build the Docker image
echo "Building Docker image..."
docker build -t c-app .

# Run the Docker container
echo "Running the C application in Docker..."
docker run --rm c-app

echo "Done."
