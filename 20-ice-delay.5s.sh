#!/usr/bin/env bash

URL="https://iceportal.de/api1/rs/tripInfo/trip"

output=$(curl -s $URL)

if [ $(echo $output | wc -c) -gt 1 ]; then
  delay=$(echo $output | jq --raw-output ".trip.stops[] | select(.info.passed == false) | .timetable.arrivalDelay" | head -n 1) 
  arrival_ms=$(echo $output | jq --raw-output ".trip.stops[] | select(.info.passed == false) | .timetable.scheduledArrivalTime" | head -n 1)
  arrival_ms=$(($arrival_ms / 1000))
  arrival=$(date -d "@$arrival_ms" "+%H:%M")
  next_stop=$(echo $output | jq --raw-output ".trip.stops[] | select(.info.passed == false) | .station.name" | head -n 1)

  echo "$arrival $delay"
  echo "---"
  echo "Nächster Halt: $next_stop"
else
  echo "NIT"
fi
