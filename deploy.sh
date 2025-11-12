#!/bin/bash
# Deployment script for Raspberry Pi Camera Viewer

set -e

DEPLOY_DIR="$HOME/.raspi-cam-view-dual"
CONFIG_DIR="$HOME/Desktop"

echo "Deploying Raspberry Pi Camera Viewer to $DEPLOY_DIR"

# Create deployment directory
mkdir -p "$DEPLOY_DIR"
mkdir -p "$DEPLOY_DIR/logs"

# Copy main application
cp src/frigate_vlc_player.py "$DEPLOY_DIR/"

# Copy scripts
cp -r scripts "$DEPLOY_DIR/"

# Copy utilities
cp -r utils "$DEPLOY_DIR/"

# Set up configuration files if they don't exist
if [ ! -f "$CONFIG_DIR/default_camera.txt" ]; then
    echo "Creating default_camera.txt from example..."
    cp config/default_camera.txt.example "$CONFIG_DIR/default_camera.txt"
fi

if [ ! -f "$CONFIG_DIR/ignored_cameras.txt" ]; then
    echo "Creating ignored_cameras.txt from example..."
    cp config/ignored_cameras.txt.example "$CONFIG_DIR/ignored_cameras.txt"
fi

if [ ! -f "$CONFIG_DIR/detection_priorities.txt" ]; then
    echo "Creating detection_priorities.txt from example..."
    cp config/detection_priorities.txt.example "$CONFIG_DIR/detection_priorities.txt"
fi

# Install Python dependencies
echo "Installing Python dependencies..."
pip3 install -r requirements.txt

# Make scripts executable
chmod +x "$DEPLOY_DIR"/scripts/*.sh
chmod +x "$DEPLOY_DIR"/frigate_vlc_player.py

echo "Deployment complete!"
echo "Main application: $DEPLOY_DIR/frigate_vlc_player.py"
echo "Configuration files: $CONFIG_DIR/*.txt"
echo ""
echo "To run: cd $DEPLOY_DIR && python3 frigate_vlc_player.py"