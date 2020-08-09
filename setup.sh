#!/bin/bash

set -euox pipefail

# --- Set up media user ---

# TODO: Rename 'plex' to 'media' at some point.
sudo useradd -G users /bin/bash plex

echo "The new user and group ID is:"
id -u plex && id -g plex

chown -R plex:plex /appdata


## --- Install Docker ---

# https://docs.docker.com/engine/install/ubuntu/
set +e
docker
if [ $? == 0]; then
    echo "docker already installed. Exiting"
    exit
fi
set -e

# Clean up old versions.
sudo apt remove docker docker-engine docker.io containerd runc || true

# Update repos and ensure required tools are installed.
sudo apt update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Grab Docker's GPG key and verify fingerprint.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# Add Docker stable repo.
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io

# Manage Docker as non-root user.
# https://docs.docker.com/engine/install/linux-postinstall/

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# If this still doesn't work, log out and log back in.
docker run hello-world
