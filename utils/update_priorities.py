#!/usr/bin/env python3
# Add priority support to the VLC player script

import re

# Read the current script
with open('/home/spike/frigate_vlc_player.py', 'r') as f:
    content = f.read()

# Add priority loading to __init__ method
init_addition = '''        self.detection_priorities = self.load_detection_priorities()
        self.current_priority = 0'''

# Add the priority loading function after load_ignored_cameras
priority_function = '''
    def load_detection_priorities(self) -> dict:
        """Load detection priority configuration"""
        priorities = {
            'person': 10,
            'dog': 8, 
            'cat': 7,
            'car': 5,
            'bird': 0  # Ignored
        }
        priority_file = os.path.expanduser('~/Desktop/detection_priorities.txt')
        if os.path.exists(priority_file):
            try:
                with open(priority_file, 'r') as f:
                    for line in f:
                        line = line.strip()
                        if line and not line.startswith('#') and '=' in line:
                            det_type, priority = line.split('=')
                            priorities[det_type.strip()] = int(priority.strip())
                logger.info(f"Loaded detection priorities from {priority_file}")
            except Exception as e:
                logger.warning(f"Could not load priorities file: {e}")
        return priorities
'''

# Update on_message to check priorities
on_message_update = '''            # Get the detection label (person, car, etc.)
            label = data.get("after", {}).get("label", "unknown")
            
            # Check detection priority
            priority = self.detection_priorities.get(label, 1)
            if priority == 0:
                logger.info(f"Ignoring {label} detection on camera '{camera}' (priority=0)")
                return
            
            # Only switch if new detection has higher priority or different camera
            if camera != self.current_camera or priority > self.current_priority:
                logger.info(f"New detection: {label} (priority={priority}) on camera '{camera}'")
                self.current_priority = priority
                # Play the camera stream
                self.play_camera(camera)
            else:
                logger.info(f"Keeping current camera - {label} (priority={priority}) <= current priority={self.current_priority}")
                return'''

# Write the updated script
# Find where to insert the priority function
content = re.sub(
    r'(self\.ignored_cameras = self\.load_ignored_cameras\(\))',
    r'\1\n' + init_addition,
    content
)

# Add the priority function after load_ignored_cameras
content = re.sub(
    r'(def load_ignored_cameras.*?return ignored)',
    r'\1\n' + priority_function,
    content,
    flags=re.DOTALL
)

# Update the on_message method
content = re.sub(
    r'# Get the detection label.*?# Play the camera stream.*?self\.play_camera\(camera\)',
    on_message_update,
    content,
    flags=re.DOTALL
)

# Write the updated script
with open('/home/spike/frigate_vlc_player.py', 'w') as f:
    f.write(content)

print('Script updated with priority support')
