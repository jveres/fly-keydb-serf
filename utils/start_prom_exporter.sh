#!/bin/sh
set -e

exec redis_exporter --redis.addr=fly-local-6pn --redis.password=$KEYDB_PASSWORD
