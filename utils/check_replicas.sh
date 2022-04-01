#!/bin/sh

refresh=5
replicacount=""
echo "checking for replicas every $refresh secs..."
export REDISCLI_AUTH=$(echo $KEYDB_PASSWORD)

check_replica_count()
{ 
  if ( ps aux | grep -v grep | grep -q keydb-server ); then
    replicas=$(keydb-cli info replication | grep "_host:")
    count=$(echo "$replicas" | grep -v ^$ | wc -l)
    if [ "$replicacount" != "$count" ]; then
      replicacount="$count"
      echo "keydb replicas: $replicacount"
    fi
  else
    echo "keydb-server is not running"
  fi
}

while true; do
  sleep $refresh
  check_replica_count
done
