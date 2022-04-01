#!/bin/bash
set -e

JOIN_ADDR=$(dig aaaa nearest.of.$FLY_APP_NAME.internal +short | tail -1)

exec serf agent \
  -node="${FLY_REGION}-$(hostname)" \
  -profile=wan \
  -join=$JOIN_ADDR \
  -bind=fly-local-6pn \
  -rpc-addr=fly-local-6pn:7373 \
  -tag region="${FLY_REGION}" \
  -tag app="keydb" \
  -event-handler "member-join=member_join.sh" \
  -event-handler "member-leave,member-failed=member_leave.sh"
