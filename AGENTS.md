# Agent Development Guidelines

## Build/Test Commands
- **Run main script**: `python3 frigate_vlc_player.py`
- **Install dependencies**: Dependencies auto-install via script (paho-mqtt)
- **Test single function**: Use `python3 -c "from script import function; function()"`
- **Virtual environment**: `python3 -m venv frigate-vlc-env && source frigate-vlc-env/bin/activate`

## Code Style Guidelines
- **Python Version**: Python 3.7+
- **Imports**: Standard library first, third-party second, local imports last
- **Formatting**: 4-space indentation, snake_case for variables/functions, PascalCase for classes
- **Type Hints**: Not currently used but preferred for new code
- **Naming**: Descriptive names (e.g., `format_camera_for_rtsp`, `load_default_camera`)
- **Error Handling**: Use try/except with specific error types, log errors with context
- **Logging**: Use module-level logger with INFO level, file + console output
- **Constants**: ALL_CAPS for module-level constants (e.g., `MQTT_HOST`, `DETECTION_PRIORITIES`)
- **Config**: Environment variables with sensible defaults, config files in `~/Desktop/`
- **Documentation**: Docstrings for classes and complex functions
- **File paths**: Use `os.path.expanduser()` for user home directory paths

## Architecture Notes
- Single-threaded with MQTT event loop
- VLC subprocess management with proper cleanup
- Configuration via environment variables and text files
- Priority-based camera switching system