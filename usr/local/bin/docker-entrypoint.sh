#!/bin/bash

# Update user IDs
usermod -u ${PUID} -g ${PGID} amp 2>/dev/null

exec su -l amp -c "AMPUSER=$AMPUSER AMPPASSWORD=$AMPPASSWORD BINDADDRESS=$BINDADDRESS PORT=$PORT $@"
