#!/bin/bash

# Update user IDs
usermod -u ${PUID} -g ${PGID} amp 2>/dev/null

echo "Updating AMP manager..."
apt-get update 1>/dev/null
apt-get install ampinstmgr --install-suggests --only-upgrade 1>/dev/null

exec su -l amp -c "AMPUSER=$AMPUSER AMPPASSWORD=$AMPPASSWORD BINDADDRESS=$BINDADDRESS PORT=$PORT $@"
