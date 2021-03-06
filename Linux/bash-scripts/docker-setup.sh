#!/usr/bin/env bash

# Script is designed to deploy docker containers and connect. This script must be run with sudo

# Update the system & install docker
apt update
apt install docker.io

# Make sure docker is started
systemctl start docker

# download desired container. Default is 
docker pull cyberxsecurity/ansible

