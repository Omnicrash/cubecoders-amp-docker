#!/bin/bash

function killtail {
  if [[ -n ${TAILPID} ]]; then
    kill ${TAILPID}
    wait ${TAILPID} 2>/dev/null
  fi
}

trap killtail EXIT

ADSPATH=~/.ampdata/instances/ADS01

# Create the controller instance if it doesn't exist
if [ ! -d "${ADSPATH}/" ]; then
  echo "No controller found, creating..."
  ampinstmgr --strict --QuickStart ${AMPUSER} ${AMPPASSWORD} ${BINDADDRESS} ${PORT}
else
  echo "Upgrading instances..."
  ampinstmgr --UpgradeAll
  
  echo "Booting instances..."
  ampinstmgr --StartBoot
fi

# Monitor latest log file
LOGPATH="${ADSPATH}/AMP_Logs/*.log"

ACTIVELOGFILE=
while sleep 1; do
  LOGFILE=`ls -t ${LOGPATH} 2>/dev/null | head -n1`
  if [[ "${LOGFILE}" != "${ACTIVELOGFILE}" ]]; then
    killtail
    ACTIVELOGFILE=${LOGFILE}
    tail -f "${ACTIVELOGFILE}" &
    TAILPID=$!
  fi
done

#TODO: Monitor process
