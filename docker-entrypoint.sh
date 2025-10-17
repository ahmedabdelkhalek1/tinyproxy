#!/usr/bin/env sh
set -eu

CONF="/etc/tinyproxy/tinyproxy.conf"
PORT_VALUE="${PORT:-10000}"
USER_VALUE="${TINYPROXY_USER:-user}"
PASS_VALUE="${TINYPROXY_PASS:-pass}"

sed -i "s/__PORT__/${PORT_VALUE}/" "$CONF"
sed -i "s/__USER__/${USER_VALUE}/" "$CONF"
sed -i "s/__PASS__/${PASS_VALUE}/" "$CONF"

# drop privileges to the tinyproxy user for the server process
exec su-exec tinyproxy /opt/tinyproxy/sbin/tinyproxy -d -c "$CONF"
