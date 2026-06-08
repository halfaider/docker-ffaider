#!/bin/bash                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                            
if [ "$GD_POLLER" = "yes" ] && [ -d "/app/gd-poller" ]; then
    echo "Updating gd-poller..."
    (cd /app/gd-poller && git pull)
fi

if [ "$FFAIDER_BOT" = "yes" ] && [ -d "/app/flaskfarmaider-bot" ]; then
    echo "Updating flaskfarmaider-bot..."
    (cd /app/flaskfarmaider-bot && git pull)
fi

HAS_JOBS=false

# FFAIDER_BOT 실행
if [ "$FFAIDER_BOT" = "yes" ]; then
    echo "Starting ffaider-bot loop..."
    while true; do
        echo "Running ffaider-bot..."
        python3 -u /app/flaskfarmaider-bot/app.py "${FFAIDER_BOT_CONFIG:-/config/ffaider-bot.yaml}"
        echo "ffaider-bot stopped. Restarting in 5 seconds..."
        sleep 5
    done &
    HAS_JOBS=true
fi

# GD_POLLER 실행
if [ "$GD_POLLER" = "yes" ]; then
    echo "Starting gd-poller loop..."
    while true; do
        echo "Running gd-poller..."
        python3 -u /app/gd-poller/app.py "${GD_POLLER_CONFIG:-/config/gd-poller.yaml}"
        echo "gd-poller stopped. Restarting in 5 seconds..."
        sleep 5
    done &
    HAS_JOBS=true
fi

if [ "$HAS_JOBS" = true ]; then
    wait
else
    echo "Error: Neither FFAIDER_BOT nor GD_POLLER is set to 'yes'."
    exit 1
fi