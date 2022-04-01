#!/bin/sh
set -e

sysctl vm.overcommit_memory=1
sysctl net.core.somaxconn=1024

TOTALRAM=$(cat /proc/meminfo | grep -i 'memtotal' | grep -o '[[:digit:]]*')
TOTALRAM=$((($TOTALRAM)/1024))
MAXMEMORY=$(((($TOTALRAM*10)-$TOTALRAM)/10))
MAXMEMORY_POLICY="allkeys-lru"

exec keydb-server /etc/keydb.conf \
  --requirepass $KEYDB_PASSWORD \
  --masterauth $KEYDB_PASSWORD \
  --maxmemory "${MAXMEMORY}mb" \
  --maxmemory-policy $MAXMEMORY_POLICY
