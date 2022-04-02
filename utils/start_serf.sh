#!/bin/bash
set -e

exec serf agent \
  -node="${FLY_REGION}-$(hostname)" \
  -profile=wan \
  -join $FLY_APP_NAME.internal \
  -bind="fly-local-6pn:7946" \
  -rpc-addr="fly-local-6pn:7373" \
  -tag region="${FLY_REGION}" \
  -tag app="keydb" \
  -event-handler "member-join=member_join.sh" \
  -event-handler "member-leave,member-failed=member_leave.sh"
