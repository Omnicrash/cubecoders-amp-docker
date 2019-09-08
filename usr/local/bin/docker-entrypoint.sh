#!/bin/bash

# Update user IDs
usermod -u ${PUID} -g ${PGPID} amp 2>/dev/null

su -l amp -c "/home/amp/start.sh"
