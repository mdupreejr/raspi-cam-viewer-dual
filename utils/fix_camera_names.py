import sys

# Read the script
with open('/home/spike/frigate_vlc_player.py', 'r') as f:
    content = f.read()

# Replace the format_camera_for_rtsp function
old_func = '''    def format_camera_for_rtsp(self, camera_name):
        """Convert camera name to RTSP stream format"""
        # Replace hyphens with underscores and convert to lowercase
        formatted = camera_name.replace('-', '_').lower()
        return formatted'''

new_func = '''    def format_camera_for_rtsp(self, camera_name):
        """Convert camera name to RTSP stream format"""
        # Special case for GL-FrontDoor -> gr_frontdoor
        if camera_name.lower() == 'gl-frontdoor':
            return 'gr_frontdoor'
        # Replace hyphens with underscores and convert to lowercase
        formatted = camera_name.replace('-', '_').lower()
        return formatted'''

content = content.replace(old_func, new_func)

# Write it back
with open('/home/spike/frigate_vlc_player.py', 'w') as f:
    f.write(content)

print('Fixed camera name mapping')
