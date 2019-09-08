#!/bin/bash

# Create the controller instance if it doesn't exist
if [ ! -d ~/.ampdata/instances/ADS01/ ]; then
	ampinstmgr quick ${AMPUSER} ${AMPPASSWORD} ${BINDADDRESS} ${PORT}
    #TODO: Check if we need to start here
fi

#TODO: Run in foreground?/supervisor?
#TODO: Replace crontab boot with supervisor
/usr/bin/tail -f /dev/null
