#!/bin/bash

# Read all domains from the file
DOMAINS=$(cat domains.txt | grep -v "^#" | tr '\n' ' ')

echo "Generating certificate for: $DOMAINS"

# Generate certificate with all domains
mkcert $DOMAINS

# Find the latest certificate 
LATEST_CERT=$(ls -t _* | grep -v key | head -1)
LATEST_KEY=$(ls -t _*-key* | head -1)

echo "Using certificate: $LATEST_CERT and key: $LATEST_KEY"

# Copy to Traefik certs directory with standard names
mv "$LATEST_CERT" ./certs/_wildcard.test.pem
mv "$LATEST_KEY" ./certs/_wildcard.test-key.pem

# Make sure permissions are correct
chmod 644 ./certs/*.pem

echo "Certificates updated. Restart Traefik to apply changes."
