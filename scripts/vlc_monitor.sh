#!/bin/bash
# VLC monitoring script to track what's happening with VLC

LOG_FILE="/home/spike/vlc_monitor.log"

echo "=== VLC Monitor Started at $(date) ===" >> $LOG_FILE

while true; do
    # Check if VLC is running
    VLC_PID=$(pgrep -f "vlc.*rtsp" | head -1)
    
    if [ -n "$VLC_PID" ]; then
        # Get VLC details
        VLC_CMD=$(ps -p $VLC_PID -o args= 2>/dev/null)
        if [ -n "$VLC_CMD" ]; then
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] VLC RUNNING - PID: $VLC_PID" >> $LOG_FILE
            # Check if window is visible
            if xwininfo -id $(xdotool search --pid $VLC_PID 2>/dev/null | head -1) 2>/dev/null | grep -q "Map State: IsViewable"; then
                echo "[$(date '+%Y-%m-%d %H:%M:%S')] VLC window is VISIBLE" >> $LOG_FILE
            else
                echo "[$(date '+%Y-%m-%d %H:%M:%S')] VLC window is NOT VISIBLE or MINIMIZED" >> $LOG_FILE
            fi
        fi
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] VLC NOT RUNNING" >> $LOG_FILE
    fi
    
    sleep 5
done