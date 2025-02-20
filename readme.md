# LossLess-Liaison (or your chosen name)

## Overview

**LossLess-Liaison** is a Bash script that monitors upstream packet loss to a specified target and sends alerts to a Discord channel via a webhook if the packet loss exceeds a defined threshold. 

I personally use this tool to keep track of network stability and receive immediate notifications about connectivity issues.

## Features

- Monitors packet loss to a specified target IP or hostname.
- Sends alerts to a Discord channel when packet loss exceeds a defined threshold.
- Configurable monitoring interval.
  
## Requirements

- Bash
- `ping` utility (usually available in most Unix-like systems)
- `curl` (for sending webhook messages)
- Discord Webhook URL

## Configuration/Installation

1. **Clone or download the repository** containing the script.

2. **Navigate to the script's directory**:
   ```bash
   cd /path/to/your/script

3. **Configuration**

    This project requires a configuration file to store the unique identifier of your Discord webhook. Follow the steps below to set it up:

    Create a Configuration File:

    Create a file named config.cfg in the root directory of the project.
    ```touch config.cfg```

    Add Webhook ID:

    In config.cfg, add the following line, replacing YOUR_WEBHOOK_ID with the unique identifier portion of your Discord webhook URL:

    ```WEBHOOK_ID=YOUR_WEBHOOK_ID```

    For example, if your webhook URL is https://discord.com/api/webhooks/1234567890/abcdefghijklmnopqrstuvwxyz, the configuration file should look like this:

    ```WEBHOOK_ID=1234567890/abcdefghijklmnopqrstuvwxyz```


4. **Make the script executable**
    ```chmod +x packet_loss_monitor.sh

5. **Execute the script**
    ./packet_loss_monitor.sh
    
    The script will run continuously, checking the specified target every SLEEP_INTERVAL seconds and sending alerts to your Discord channel if the packet loss exceeds the defined threshold.

6. **Stopping the Script**
    To stop the script, press Ctrl + C in the terminal where it is running.