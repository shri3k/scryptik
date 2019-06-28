#!/usr/bin/env bash

declare -A hosts
sleep_time=30

hosts["my-hostname"]="curl localhost:3090"
hosts["another-hostname"]="curl localhost:3090"
hosts["yet-another-hostname"]="curl localhost:3090"

function is_up {
  cmd=$1
  host=$2
  while true; do
    _=eval $1
    if [ $? -eq 0 ]; then
      echo "Done" $host
      break
    fi
    sleep 1
  done
}

for h_name in "${!hosts[@]}"
do
  if [ `hostname` == $h_name ]
  then
    echo "restarting now..."
    is_up "${hosts[$h_name]}" $h_name
  else
    echo "Waiting for ${h_name}"
    sleep $sleep_time
  fi
done
