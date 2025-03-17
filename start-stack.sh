#!/bin/bash

# Generate certificates first
./generate-certs.sh

# Start or restart Traefik
docker-compose down
docker-compose up -d

echo "Traefik started with fresh certificates"

