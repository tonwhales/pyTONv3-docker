#!/bin/sh
set -e
echo "Downloading config from ${TON_CONFIG}"
wget -O /usr/src/pytonv3/config.json ${TON_CONFIG}
echo "Config downloaded"
cat /usr/src/pytonv3/config.json
exec "$@"