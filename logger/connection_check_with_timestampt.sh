#!/bin/sh

LOG_FILE="/db-data/ping.log"
PING_HOST="google.com"
PING_INTERVAL=15

echo "Started ping logging to $LOG_FILE"

while true; do
  # get the current timestamp, in milliseconds since epoch
  TIMESTAMP=$(date '+%s%3N')

  # set status based on ping result. We only care for connected/disconnected status.
  # so we use the option -c 1 to only send one packet
  # we redirect the output to /dev/null, since we don't want to see the output
  # and we use the exit code of the ping command to determine if the ping was successful
  STATUS="disconnected"
  if ping -c 1 $PING_HOST > /dev/null 2>&1; then
    STATUS="connected"
  fi

  # push the timestamp and status to the log file
  echo "$TIMESTAMP - $STATUS" >> $LOG_FILE

  # wait for the next interval, so we don't flood the network
  sleep $PING_INTERVAL
done

