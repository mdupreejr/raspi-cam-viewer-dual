#!/bin/bash
# Easy log viewing script for Frigate VLC Viewer

echo "====================================="
echo "   Frigate VLC Viewer Log Monitor   "
echo "====================================="
echo ""
echo "Options:"
echo "1) View last 50 lines of activity log"
echo "2) Follow activity log in real-time"
echo "3) View only errors and warnings"
echo "4) View detection events"
echo "5) Check VLC status"
echo "6) View systemd service logs"
echo "7) Clear old logs"
echo ""
read -p "Select option (1-7): " option

case $option in
    1)
        tail -50 ~/vlc_activity.log
        ;;
    2)
        tail -f ~/vlc_activity.log
        ;;
    3)
        grep -E "ERROR|WARNING" ~/vlc_activity.log | tail -50
        ;;
    4)
        grep -E "New detection|Playing stream|Ignoring" ~/vlc_activity.log | tail -50
        ;;
    5)
        if pgrep -f "vlc.*rtsp" > /dev/null; then
            echo "VLC is RUNNING"
            ps aux | grep vlc | grep -v grep
        else
            echo "VLC is NOT running"
        fi
        ;;
    6)
        sudo journalctl -u frigate-vlc.service -n 50 --no-pager
        ;;
    7)
        echo "Backing up current log..."
        cp ~/vlc_activity.log ~/vlc_activity.log.backup
        > ~/vlc_activity.log
        echo "Log cleared (backup saved as vlc_activity.log.backup)"
        ;;
    *)
        echo "Invalid option"
        ;;
esac