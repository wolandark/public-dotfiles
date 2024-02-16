#!/usr/bin/env bash

# Set the idle time in seconds
IDLE_TIME=400

# Function to check if audio is playing
is_audio_playing() {
    AUDIO=$(pactl list | grep -A2 "State: RUNNING" | grep "Name" | awk '{print $NF}')
    if [ -n "$AUDIO" ]; then
        return 0 # Audio is playing
    else
        return 1 # Audio is not playing
    fi
}

# Start xidlehook with a command to run when the system is idle for the specified time
# xidlehook --not-when-fullscreen --not-when-audio \
#     --timer $IDLE_TIME "bash -c 'if ! is_audio_playing; then betterlockscreen -l; fi'" "" &
xidlehook --not-when-fullscreen --not-when-audio \
    --timer $IDLE_TIME "bash -c 'if ! is_audio_playing; then slock; fi'" "" &

# Wait for xidlehook to finish
wait

# xidlehook --not-when-fullscreen --not-when-audio  --timer 400 "betterlockscreen -l" ''
# xidlehook \
#     --not-when-fullscreen \
#     --not-when-audio \
#     --timer 900 "betterlockscreen -l" '' \


