#!/usr/bin/env bash

URL="https://railnet.oebb.at/assets/modules/fis/combined.json"

STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" $URL)

if [ $STATUS_CODE = '200' ]; then
  output=$(curl $URL -s)
  arrival=$(echo $output | jq --raw-output ".nextStation.arrival.scheduled")
  arrival_f=$(echo $output | jq --raw-output ".nextStation.arrival.forecast")
  next_stop=$(echo $output | jq --raw-output ".nextStation.name.de") 

  f_m=$(date -d "$arrival_f" +"%s")
  a_m=$(date -d "$arrival" +"%s")
  delay=$((($f_m - $a_m) / 60))
  delay=+$delay
  
  echo "$arrival $delay"
  echo "---"
  echo "Nächster Halt: $next_stop"
else
  echo "NIT"
fi
