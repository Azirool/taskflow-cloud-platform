# TaskFlow System Health Check

## Overview

The TaskFlow System Health Check is a Bash-based automation tool designed to provide a quick overview of the development server's operational status.

It reduces the need to manually execute multiple Linux system inspection commands.

## Environment
- Platform: AWS EC2
- Operating System: Ubuntu Linux
- Environment: Development
- AWS Region: ap-southeast-1
- Scripting Language: Bash

## Features
- Display server hostname, current date and system uptime
- Display system memory and swap usage
- Display root filesystem capacity and usage
- Automatically retrieves and evaluates disk usage
- Generates a warning when disk usage reaches or exceeds 80%
- Validates retrieved disk usage data
- Handles disk usage retrieval failures
- Reports SSH service status


## Prequisites
- Linux operating system with bash
- systemd for service status checks
- Standard Linux utilities, including hostname, date, uptime, free, df, awk and tr

## Usage
From the project root directory

``` bash 
chmod u+x scripts/system-heatlth-check.sh
./scripts/system-health-check.sh
```

Alternatively:

```bash
bash scripts/system-health-check.sh"
```

## Configuration
| Variable || Default Value || Purpose |
| -------- || ------------- || ------- |
| PROJECT_NAME || Taskflow || Project identification |
| ENVIRONMENT || Development || Target Environment |
| DISK_THRESHOLD || 80 || Disk usage warning threshold |
| SERVICE_NAME || ssh || Service being monitored |

## Status Messages
- OK: The monitored condition meets the expected criteria
- WARNING: Disk usage has reached the configured threshold, or the monitored service is not active
- ERROR: Disk usage could not be retrieved or validated

## Testing
The following test scenario were performed during development:
- Bash syntax validation
- Normal operating conditions
- High disk usage using a reduced warning threshold
- Invalid disk usage data
- Simulated disk data retrieval failure
- Nonexistent service detection
- Final regression testing.
