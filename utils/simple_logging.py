#!/usr/bin/env python3
# Add simple file logging

with open('/home/spike/frigate_vlc_player.py', 'r') as f:
    lines = f.readlines()

# Find the logging setup section and add file handler
for i, line in enumerate(lines):
    if 'logging.basicConfig(' in line:
        # Add file handler setup before basicConfig
        lines[i] = '''# Logging setup with file output
LOG_FILE = os.path.expanduser('~/vlc_activity.log')
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler(LOG_FILE)
    ]
)
'''
        break

with open('/home/spike/frigate_vlc_player.py', 'w') as f:
    f.writelines(lines)

print('Simple logging added')
