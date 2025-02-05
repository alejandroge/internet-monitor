#!/bin/sh

touch /db-data/ping.log

sh ./process_ping_logs.sh

# Start the ping logging script
sh ./connection_check_with_timestampt.sh &

# Start cron in the background
touch /db-data/cron.log
cron

# tail the logs, so the container shows them both
tail -f /db-data/ping.log /db-data/cron.log
