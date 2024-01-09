#!/bin/bash

install_docker_macos() {
    echo "Installing Docker Desktop on macOS..."
    brew install --cask docker
    # Add additional steps if needed for macOS Docker Desktop installation
    # For example, you might want to open a webpage for the user to download Docker Desktop
    # Or use a package manager if Docker Desktop is available through one
}

install_docker_linux() {
    echo "Installing Docker on Linux..."
    sudo apt-get update
    sudo apt-get install docker.io -y
    sudo systemctl start docker
    sudo docker run hello-world
    sudo systemctl enable docker
    docker --version
    sudo usermod -a -G docker $(whoami)
    newgrp docker
    echo "Docker installed and started. ✅"
    sleep 5
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-$(uname -s)-$(uname -m)"  -o /usr/local/bin/docker-compose
    sudo mv /usr/local/bin/docker-compose /usr/bin/docker-compose
    sudo chmod +x /usr/bin/docker-compose
    echo "Docker-compose installed and ready to use 🚀"
}

configure_docker(){
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
    
}

echo 
echo "Welcome 2FA-EXP-ORCHESTRATION 🚀"
echo "This script allows you to perform various actions to orchestration."
echo "Please select an option from the menu below:"
# Menu options
echo
options=("Init" "Rollout" "Quit")
echo
PS3="> "
echo
select option in "${options[@]}"; do
    case $REPLY in
        1) configure_docker
           docker_status=$(docker info &> /dev/null && echo "running" || echo "not running")
           echo "Docker status: $docker_status"
            ;;
        2)  sudo apt-get remove docker.io -y
            sudo apt autoremove -y
            ;;
        3)
            echo "Quitting..."
            break
            ;;
        *)
            echo "Invalid option. Please select a valid option."
            ;;
    esac
done

# Check Docker status
