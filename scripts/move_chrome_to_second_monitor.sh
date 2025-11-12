#!/bin/bash
# Wait for Chrome window to appear
sleep 3

# Use wlr-randr to get output names and swaymsg/labwc commands to move window
# Since we're in labwc, we'll use labwc's built-in commands

# Get the window ID of chromium
export DISPLAY=:0

# Try using xdotool if available to move the window
if command -v xdotool &> /dev/null; then
    # Find the chromium window
    WINDOW_ID=$(xdotool search --class chromium 2>/dev/null | head -1)
    if [ -n "$WINDOW_ID" ]; then
        echo "Found Chrome window: $WINDOW_ID"
        # Move window to position 1920,0 (second monitor)
        xdotool windowmove $WINDOW_ID 1920 0
        xdotool windowsize $WINDOW_ID 1920 1080
        echo "Moved Chrome to second monitor"
    fi
fi
