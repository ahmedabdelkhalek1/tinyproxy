#!/usr/bin/env sh
set -eu

TEMPLATE="/etc/tinyproxy/tinyproxy.conf"
OUT="/tmp/tinyproxy.conf"

PORT_VALUE="${PORT:-10000}"
USER_VALUE="${TINYPROXY_USER:-user}"
PASS_VALUE="${TINYPROXY_PASS:-pass}"

sed -e "s/__PORT__/${PORT_VALUE}/" \
    -e "s/__USER__/${USER_VALUE}/" \
    -e "s/__PASS__/${PASS_VALUE}/" \
    "$TEMPLATE" > "$OUT"

exec /opt/tinyproxy/sbin/tinyproxy -d -c "$OUT"
