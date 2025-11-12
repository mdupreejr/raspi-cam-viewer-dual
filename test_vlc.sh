#!/bin/bash
DISPLAY=:0 vlc \
    --intf dummy \
    --dummy-quiet \
    --fullscreen \
    --loop \
    --no-video-title-show \
    --network-caching=1000 \
    --file-caching=1000 \
    --live-caching=1000 \
    --clock-jitter=0 \
    --drop-late-frames \
    --skip-frames \
    rtsp://fl7:8554/gr_frontdoor &
