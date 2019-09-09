#!/bin/bash
trap killtail EXIT

function killtail {
	if [[ -n ${TAILPID} ]]; then
    kill ${TAILPID}
    wait ${TAILPID} 2>/dev/null
  fi
}

ADSPATH=~/.ampdata/instances/ADS01

# Create the controller instance if it doesn't exist
if [ ! -d "${ADSPATH}/" ]; then
	ampinstmgr --strict --QuickStart ${AMPUSER} ${AMPPASSWORD} ${BINDADDRESS} ${PORT}
fi

ampinstmgr --StartBoot

# Monitor latest log file
LOGPATH="${ADSPATH}/AMP_Logs/*.log"

ACTIVELOGFILE=

while true; do
  #TODO: Ignore not found errors
  LOGFILE=`ls -t ${LOGPATH} | head -n1`
  if [[ "${LOGFILE}" != "${ACTIVELOGFILE}" ]]; then
    killtail
    ACTIVELOGFILE=${LOGFILE}
    tail -f "${ACTIVELOGFILE}" &
    TAILPID=$!
  fi
  sleep 1
done

#TODO: Monitor process