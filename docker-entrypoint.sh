#!/usr/bin/env sh
set -eu

CONF="/etc/tinyproxy/tinyproxy.conf"
PORT_VALUE="${PORT:-10000}"
USER_VALUE="${TINYPROXY_USER:-user}"
PASS_VALUE="${TINYPROXY_PASS:-pass}"

# Substitute placeholders with env values expected by Render and your secrets
sed -i "s/__PORT__/${PORT_VALUE}/" "$CONF"
sed -i "s/__USER__/${USER_VALUE}/" "$CONF"
sed -i "s/__PASS__/${PASS_VALUE}/" "$CONF"

# Exec Tinyproxy in foreground so Render can manage the process
exec /opt/tinyproxy/sbin/tinyproxy -d -c "$CONF"
