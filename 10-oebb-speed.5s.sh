#!/usr/bin/env bash

STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" https://railnet.oebb.at/api/speed)

if [ $STATUS_CODE = '200' ]; then
  speed=$(curl https://railnet.oebb.at/api/speed -s)
  echo "$speed km/h"
  echo "---"
  echo "Internet: UNKNOWN"
else
  echo "NIT"
fi
