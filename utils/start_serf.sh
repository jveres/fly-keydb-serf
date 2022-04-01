#!/bin/bash
set -e

JOIN_ADDR=$(dig aaaa nearest.of.$FLY_APP_NAME.internal +short | tail -1)
LOCAL_IP=$(grep fly-local-6pn /etc/hosts | awk '{print $1}')

exec serf agent \
  -node="${FLY_REGION}-$(hostname)" \
  -profile=wan \
  -join="[$JOIN_ADDR]" \
  -bind="[$LOCAL_IP]:7946" \
  -rpc-addr="[$LOCAL_IP]:7373" \
  -tag region="${FLY_REGION}" \
  -tag app="keydb" \
  -event-handler "member-join=member_join.sh" \
  -event-handler "member-leave,member-failed=member_leave.sh"
