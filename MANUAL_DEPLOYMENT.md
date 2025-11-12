# Manual Deployment Instructions

Since SSH automation isn't working, here are the manual steps to clean up and deploy:

## Step 1: Copy Project to Raspberry Pi

From your local machine:
```bash
# Option A: If you have SSH access working
scp -r /Users/spike/projects/raspi-viewer-dual spike@raspi-bar:~/

# Option B: If SSH doesn't work, use a USB drive or other method
# Copy the entire raspi-viewer-dual folder to the Pi
```

## Step 2: Clean up the messy files on Raspberry Pi

SSH to the Pi and run these commands:
```bash
ssh spike@raspi-bar

# Create backup of current config
mkdir -p ~/backup-$(date +%Y%m%d)
cp ~/Desktop/*.txt ~/backup-$(date +%Y%m%d)/ 2>/dev/null || true

# Remove scattered files from home directory
rm -f ~/frigate_vlc_player*.py
rm -f ~/fix_camera_names.py 
rm -f ~/simple_logging.py
rm -f ~/add_logging.py
rm -f ~/update_priorities.py
rm -f ~/*.sh
rm -f ~/vlc_activity.log

# Clear Desktop scripts (keep config files for now)
rm -f ~/Desktop/*.sh

# Remove old virtual environment
rm -rf ~/frigate-vlc-env
```

## Step 3: Deploy the organized version

```bash
# Navigate to the copied project
cd ~/raspi-viewer-dual

# Run deployment script
./deploy.sh
```

## Step 4: Verify deployment

```bash
# Check that files are in the right place
ls -la ~/.raspi-cam-view-dual/

# Test run the application
cd ~/.raspi-cam-view-dual
python3 src/frigate_vlc_player.py
```

## Step 5: Clean up project directory (optional)

```bash
# After successful deployment, you can remove the source
rm -rf ~/raspi-viewer-dual
```

## Expected Result

After deployment you should have:
- `~/.raspi-cam-view-dual/` - Clean organized application
- `~/Desktop/` - Only your config files (*.txt)
- Clean home directory with no scattered files
- Backup of old configs in `~/backup-YYYYMMDD/`