#!/bin/bash
install_docker_macos() {
    echo "Installing Docker Desktop for macOS..."
    # Add additional steps if needed for macOS Docker Desktop installation
    # For example, you might want to open a webpage for the user to download Docker Desktop
    # Or use a package manager if Docker Desktop is available through one
}

install_docker_linux() {
    echo "Installing Docker for Linux..."
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker installed and started."
}

if command -v docker &> /dev/null; then
    echo "Docker is already installed."
else
    # Detect the operating system
    if [[ "$OSTYPE" == "darwin"* ]]; then
        install_docker_macos
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        install_docker_linux
    else
        echo "Unsupported operating system."
        exit 1
    fi
fi

# Check Docker status
docker_status=$(docker info &> /dev/null && echo "running" || echo "not running")
echo "Docker status: $docker_status"