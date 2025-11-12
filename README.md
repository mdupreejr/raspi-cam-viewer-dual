# Raspberry Pi Camera Viewer Dual

A Python application for displaying Frigate security camera feeds on dual monitors using VLC, with automatic camera switching based on motion detections.

## Features

- Automatic camera switching based on Frigate motion detection events
- Priority-based detection handling (person > dog > car, etc.)
- Dual monitor support with Chrome browser integration
- Configurable default camera and ignored cameras
- Automatic return to default camera after detection timeout
- VLC process management and monitoring
- Comprehensive logging

## Project Structure

```
raspi-viewer-dual/
├── src/
│   └── frigate_vlc_player.py    # Main application
├── scripts/
│   ├── birdseye_browser.sh      # Browser for Frigate birdseye view
│   ├── move_chrome_to_second_monitor.sh  # Dual monitor management
│   ├── test_vlc.sh              # VLC testing
│   ├── view_logs.sh             # Log viewing utility
│   ├── vlc_monitor.sh           # VLC process monitoring
│   └── vlc_wrapper.sh           # VLC wrapper script
├── utils/
│   ├── fix_camera_names.py      # Camera name mapping fixes
│   ├── simple_logging.py        # Logging utilities
│   ├── add_logging.py           # Add logging to scripts
│   └── update_priorities.py     # Update detection priorities
├── config/
│   ├── default_camera.txt.example
│   ├── ignored_cameras.txt.example
│   └── detection_priorities.txt.example
├── deploy.sh                    # Deployment script
├── requirements.txt             # Python dependencies
└── README.md                    # This file
```

## Installation

1. Clone this repository to your local machine
2. Copy to Raspberry Pi: `scp -r raspi-viewer-dual/ pi@yourpi:~/`
3. SSH to Pi: `ssh pi@yourpi`
4. Run deployment: `cd raspi-viewer-dual && ./deploy.sh`

## Configuration

Configuration files are created in `~/Desktop/` during deployment:

- `default_camera.txt` - Camera to show by default
- `ignored_cameras.txt` - Cameras to ignore for detections
- `detection_priorities.txt` - Priority levels for different detection types

## Environment Variables

- `FRIGATE_MQTT_HOST` - Frigate MQTT broker host (default: "fl7")
- `FRIGATE_MQTT_PORT` - MQTT port (default: 1883)
- `FRIGATE_MQTT_TOPIC` - MQTT topic (default: "frigate/events")
- `FRIGATE_RTSP_BASE` - RTSP base URL (default: "rtsp://{host}:8554")
- `DISPLAY` - X11 display (default: ":0")

## Usage

```bash
# Run from deployment directory
cd ~/.raspi-cam-view-dual
python3 frigate_vlc_player.py

# Or run with custom environment
FRIGATE_MQTT_HOST=192.168.1.100 python3 frigate_vlc_player.py
```

## Development

See [AGENTS.md](AGENTS.md) for development guidelines and coding standards.