#!/usr/bin/env python3
# Add file logging to the VLC player script

import re

with open('/home/spike/frigate_vlc_player.py', 'r') as f:
    content = f.read()

# Update the logging configuration section
new_logging_config = '''# Logging setup
import logging.handlers

# Create formatters
console_formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
file_formatter = logging.Formatter('%(asctime)s - %(levelname)s - [%(funcName)s] - %(message)s')

# Console handler
console_handler = logging.StreamHandler()
console_handler.setFormatter(console_formatter)
console_handler.setLevel(logging.INFO)

# File handler with rotation
file_handler = logging.handlers.RotatingFileHandler(
    os.path.expanduser('~/vlc_activity.log'),
    maxBytes=10*1024*1024,  # 10MB
    backupCount=3
)
file_handler.setFormatter(file_formatter)
file_handler.setLevel(logging.DEBUG)

# Configure root logger
logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
logger.addHandler(console_handler)
logger.addHandler(file_handler)

# Log startup
logger.info("="*50)
logger.info("FRIGATE VLC VIEWER STARTING")
logger.info("="*50)'''

# Replace the old logging setup
content = re.sub(
    r'# Logging setup.*?logger = logging\.getLogger\(__name__\)',
    new_logging_config,
    content,
    flags=re.DOTALL
)

# Add VLC process monitoring in play_camera
vlc_monitor = '''
            # Monitor VLC process in background
            def monitor_vlc_process():
                import time
                time.sleep(5)
                if self.vlc_process:
                    poll = self.vlc_process.poll()
                    if poll is not None:
                        logger.error(f"VLC exited unexpectedly with code {poll} after 5 seconds")
                    else:
                        logger.debug(f"VLC still running after 5 seconds (PID: {self.vlc_process.pid})")
            
            import threading
            monitor_thread = threading.Thread(target=monitor_vlc_process, daemon=True)
            monitor_thread.start()'''

# Add the monitor after VLC starts
content = re.sub(
    r'(logger\.info\(f"VLC started for camera.*?\))',
    r'\1' + vlc_monitor,
    content
)

# Add periodic status logging
status_logger = '''
    def log_status(self):
        """Log current status periodically"""
        import threading
        def status_thread():
            import time
            while True:
                time.sleep(60)  # Log every minute
                if self.vlc_process and self.vlc_process.poll() is None:
                    logger.debug(f"STATUS: VLC running - Camera: {self.current_camera}, Priority: {self.current_priority}")
                else:
                    logger.debug("STATUS: VLC not running - waiting for detections")
        
        thread = threading.Thread(target=status_thread, daemon=True)
        thread.start()
'''

# Add status logger function after load_detection_priorities
content = re.sub(
    r'(def load_detection_priorities.*?return priorities)',
    r'\1\n' + status_logger,
    content,
    flags=re.DOTALL
)

# Call status logger in __init__
content = re.sub(
    r'(self\.setup_mqtt\(\))',
    r'\1\n        self.log_status()',
    content
)

with open('/home/spike/frigate_vlc_player.py', 'w') as f:
    f.write(content)

print('Enhanced logging added to script')
