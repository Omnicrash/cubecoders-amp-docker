#!/bin/bash

# Update user IDs
usermod -u ${PUID} -g ${PGPID} amp 2>/dev/null

exec su -l amp -c "$@"
