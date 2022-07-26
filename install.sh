#! /bin/bash

dc="/usr/local/bin/docker-compose"
if [ -f "$dc" ]; then
    echo "docker-compose already installed."
else
    echo "Downloading docker compose..."
    type=$(echo "docker-compose-$(uname -s)-$(uname -m)" | awk '{print tolower($0)}')
    $(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep $type | head -n 2 | cut -d: -f 2,3 | tr -d \" | wget -qi -)

    if [ -f "$type" ]; then
        echo "$type downloaded."
        sudo mv $type /usr/local/bin/docker-compose

        echo "Installing docker-compose..."
        sudo chmod +x /usr/local/bin/docker-compose
        docker-compose --version
    else
        echo "Failed."
    fi
fi