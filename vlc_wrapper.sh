#!/bin/bash
# VLC wrapper script that logs everything

LOG_FILE="/home/spike/vlc_wrapper.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$TIMESTAMP] VLC STARTED with args: $@" >> $LOG_FILE

# Run VLC and capture its exit code
cvlc "$@" 2>&1 | while read line; do
    echo "[$TIMESTAMP] VLC OUTPUT: $line" >> $LOG_FILE
done

EXIT_CODE=${PIPESTATUS[0]}
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$TIMESTAMP] VLC EXITED with code: $EXIT_CODE" >> $LOG_FILE

exit $EXIT_CODE