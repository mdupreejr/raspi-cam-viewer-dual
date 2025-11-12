#!/bin/bash

# Kill any existing Chrome instances for birdseye
pkill -f "chrome.*birdseye"

# Wait a moment for cleanup
sleep 1

# Start Chrome with birdseye view on second monitor
# Disable GPU acceleration to fix black screen issues
DISPLAY=:0 \
chromium \
    --kiosk \
    --window-position=1920,0 \
    --window-size=1920,1080 \
    --user-data-dir=/tmp/chrome-birdseye \
    --noerrdialogs \
    --disable-infobars \
    --disable-session-crashed-bubble \
    --disable-features=TranslateUI \
    --disable-dev-shm-usage \
    --disable-gpu \
    --disable-software-rasterizer \
    --no-first-run \
    --password-store=basic \
    http://fl7:5000/birdseye
