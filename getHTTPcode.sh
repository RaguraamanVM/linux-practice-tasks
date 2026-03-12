#!/bin/bash

URL="https://www.guvi.in"
status_code=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

echo "Target: $URL"
echo "HTTP Status Code: $status_code"

if [ "$status_code" -ge 200 ] &&  [ "$status_code" -lt 400 ];
then
        echo "Result: Success - site up and running..."
else
        echo "Result: Failed - site is NOT reachable!"
fi
