#!/bin/bash

get_webhook_id() {
    grep -oP "(?<=^WEBHOOK_ID=).*" config.cfg
}

# Static portion of the webhook URL
WEBHOOK_BASE_URL="https://discord.com/api/webhooks/"
WEBHOOK_ID=$(get_webhook_id)

# Construct the full webhook URL
WEBHOOK_URL="${WEBHOOK_BASE_URL}${WEBHOOK_ID}"

#Config
TARGET="8.8.8.8"
THRESHOLD=0
SLEEP_INTERVAL=30   #in seconds

send_discord_message(){
    local message=$1
    curl -X POST -H "Content-Type: application/json" \
    -d "{\"content\": \"$message\"}" "$WEBHOOK_URL"
}

while true; do
    # Ping the target and get packet loss
    ping_output=$(ping -c 100 $TARGET)
    packet_loss=$(echo "$ping_output" | grep -oP '\d+(?=% packet loss)')

    # Check if packet loss is greater than the threshold
    if (( packet_loss > THRESHOLD )); then
        send_discord_message "🚨High Packet Loss Alert: ${packet_loss}% to $TARGET"
    fi
    
    sleep $SLEEP_INTERVAL
done