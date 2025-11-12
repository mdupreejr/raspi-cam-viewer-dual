#!/bin/bash
# Script to clean up the messy files on the Raspberry Pi

set -e

RASPI_HOST="spike@raspi-bar"

echo "Cleaning up files on Raspberry Pi..."

# Create backup of current config files before deleting
echo "Creating backup of current configuration..."
ssh $RASPI_HOST "mkdir -p ~/backup-$(date +%Y%m%d)"
ssh $RASPI_HOST "cp ~/Desktop/*.txt ~/backup-$(date +%Y%m%d)/ 2>/dev/null || true"

# Remove all the scattered files from home directory
echo "Removing scattered files from home directory..."
ssh $RASPI_HOST "rm -f ~/frigate_vlc_player*.py ~/fix_camera_names.py ~/simple_logging.py ~/add_logging.py ~/update_priorities.py"
ssh $RASPI_HOST "rm -f ~/*.sh"
ssh $RASPI_HOST "rm -f ~/vlc_activity.log"

# Clear Desktop except for config files (we'll let deploy script handle those)
echo "Clearing Desktop files..."
ssh $RASPI_HOST "rm -f ~/Desktop/*.sh"

# Remove old virtual environment
echo "Removing old virtual environment..."
ssh $RASPI_HOST "rm -rf ~/frigate-vlc-env"

echo "Cleanup complete!"
echo "Configuration backup saved to ~/backup-$(date +%Y%m%d)/ on raspi"
echo ""
echo "Now you can deploy the clean version with:"
echo "  scp -r . $RASPI_HOST:~/raspi-cam-viewer-dual/"
echo "  ssh $RASPI_HOST 'cd raspi-cam-viewer-dual && ./deploy.sh'"