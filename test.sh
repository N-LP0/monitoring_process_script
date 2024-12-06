#!/bin/bash

MYSITE="https://www.google.com"
PROCESS="sshd"
MYAPI="https://www.google.com/myapi"
LOGFILE="/var/log/monitoring.log"
TIMEWAIT=60
DEBUG=false


checksite() {
  local RESPONSE=$(curl -s --head  --request GET ${1} | grep "HTTP/2 200" | awk '{print $2}')
  if [[ "${RESPONSE}" -ne 200 ]]; then 
   monitoring_log "my site ${1} is DOWN"
  fi
}

api(){
  curl -X POST -d "process=${1}" $2
}	

log() {
  echo $1 
}

monitoring_log() {
  echo $1 >> $LOGFILE
  if [[ "${DEBUG}" ]]; then
    log "${1}"
  fi 
}

while true; do
  PID=$(pgrep -x $PROCESS)
  if [[ "${TMPPID}" -ne "${PID}" ]]; then
    monitoring_log "${PID} ${PROCESS} process was restarted"
  fi
  if [[ -v "${PID}" ]]; then
    api $PROCESS $MYAPI 
  fi	  
  TMPPID=$PID
  checksite $MYSITE
  sleep $TIMEWAIT
done
