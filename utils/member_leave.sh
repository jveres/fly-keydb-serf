#!/bin/bash

if ! ( ps aux | grep -v grep | grep -q keydb-server ); then
  echo "keydb-server is not running, exiting..."
  exit 0
fi

export REDISCLI_AUTH=$(echo $KEYDB_PASSWORD)
ip=$(grep fly-local-6pn /etc/hosts | awk '{print $1}')

replicas=$(keydb-cli info replication | grep "_host:")
replicacount=$(echo "$replicas" | grep -v ^$ | wc -l)
echo "-- local ip: $ip, replica count: $replicacount"

while read line; do
  peer=$(echo "$line" | awk '{print $2}')
  echo "Peer left or failed: $peer"
  if [ "$peer" != "$ip" ] && [[ $replicas == *"_host:$peer"* ]]; then
    echo "-- removing replica $peer"
    keydb-cli replicaof remove $peer 6379
  fi
done
