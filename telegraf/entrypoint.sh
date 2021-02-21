#!/bin/bash

# this file supersedes the original entrypoint.sh for telegraf containers
# mainly because we need to fire off a cron job that runs every 20 minutes

# see: https://github.com/mihailescu2m/powerwall_monitor/issues/14#issuecomment-778478572

mkdir -p /tmp/cookies
CURL_CMD="curl -s -k -i -c /tmp/cookies/pw.txt -X POST -H 'Content-Type: application/json' -d '{\"username\":\"customer\",\"password\":\"$POWERWALL_PASSWORD\",\"force_sm_off\":false}' https://powerwall/api/login/Basic"
CRON_CMD="*/20 * * * * $CURL_CMD"
eval $CURL_CMD

( crontab -l 2>/dev/null | grep -Fv powerwall ; printf -- "$CRON_CMD\n" ) | crontab

set -e

if [ "${1:0:1}" = '-' ]; then
	    set -- telegraf "$@"
fi

exec "$@"
