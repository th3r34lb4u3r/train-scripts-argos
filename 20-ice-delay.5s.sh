#!/bin/bash
nmcli connection show --active | grep "WIFIonICE" > /dev/null 
if  [ $? -eq 0 ]; 
then
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

    stops=()
    delays=()
    arrivals_ms=()
    mapfile -t stops < <(echo $output | jq -r ".trip.stops[] | select(.info.passed == false) | .station.name")

    delay=()
    mapfile -t delays < <(echo $output | jq --raw-output ".trip.stops[] | select(.info.passed == false) | .timetable.arrivalDelay") 
    mapfile -t arrivals_ms < <(echo $output | jq --raw-output ".trip.stops[] | select(.info.passed == false) | .timetable.scheduledArrivalTime")
    

    COUNTER=0
    for stop in "${stops[@]}"; do
      stop_arrival_ms=${arrivals_ms[COUNTER]}
      stop_arrival_ms=$(($stop_arrival_ms / 1000))
      stop_arrival=$(date -d "@$stop_arrival_ms" "+%H:%M")
      stop_delay=${delays[COUNTER]}

      echo "$stop_arrival $stop_delay - $stop"
      let COUNTER++
    done
  else
    echo "---"
  fi
else
	echo "---"
fi