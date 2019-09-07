#!/bin/bash

# Create the controller instance if it doesn't exist
if [ ! -d ~/.ampdata/instances/ADS01/ ]; then
	ampinstmgr quick ${AMPUSER} ${AMPPASSWORD} 0.0.0.0 8080
    #TODO: Check if we need to start here
fi

#TODO: Run in foreground?
/usr/bin/tail -f /dev/null
