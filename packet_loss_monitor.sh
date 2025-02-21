#!/bin/bash

get_webhook_id() {
    grep -oP "(?<=^WEBHOOK_ID=).*" config.cfg
}

#static discord webhook URL
WEBHOOK_BASE_URL="https://discord.com/api/webhooks/"
WEBHOOK_ID=$(get_webhook_id)

#construct the full webhook URL
WEBHOOK_URL="${WEBHOOK_BASE_URL}${WEBHOOK_ID}"

#config
TARGET="8.8.8.8"
THRESHOLD=0
SLEEP_INTERVAL=90   #in seconds
PACKETS_TO_SEND=100

send_discord_message(){
    local message=$1
    curl -X POST -H "Content-Type: application/json" \
    -d "{\"content\": \"$message\"}" "$WEBHOOK_URL"
}

while true; do
    #ping the target and get latency stats
    ping_output=$(ping -c $PACKETS_TO_SEND $TARGET)
    packet_loss=$(echo "$ping_output" | grep -oP '\d+(?=% packet loss)')
    rtt_stats=$(echo "$ping_output" | grep 'rtt min/avg/max/mdev' | awk -F'=' '{ print $2 }' | tr -d ' ')
    read min_rtt avg_rtt max_rtt mdev <<< $(echo "$rtt_stats" | tr '/' ' ')

    #discord message
    message="**🚨 High Packet Loss Alert**"
    message+="\n**Packet Loss($PACKETS_TO_SEND):** ${packet_loss}%\n"
    message+="**RTT Statistics:**\n"
    message+="\`RTT Avg:\` **${avg_rtt} ms** | \`RTT Mdev:\` **${mdev} ms**"

    #check criteria and send discord message
    if (( packet_loss > THRESHOLD )); then
        send_discord_message "$message"
    fi
    
    sleep $SLEEP_INTERVAL
done