#!/bin/bash

set -e
set -o pipefail

SYS_SETTINGS_ENV_FILE=$1
source $SYS_SETTINGS_ENV_FILE

SCRIPT_DIR=$(dirname "$0")

[ -z "${ACCESS_TOKEN}" ] && ACCESS_TOKEN=$(${SCRIPT_DIR}/login.sh ${SYS_SETTINGS_ENV_FILE})


curl -sSfL \
	--request POST "http://${CORE_HOST}:19090/monitor/api/v1/agent/export/register/host" \
	--header "Authorization: Bearer ${ACCESS_TOKEN}" \
	--header 'Content-Type: application/json' \
	--data @- <<-EOF \
	| ${SCRIPT_DIR}/check-status-in-json.sh '.resultCode == "0"'
		{
		  "requestId": "1",
		  "inputs": [
		    {
		      "callbackParameter": "11",
		      "host_ip": "${CORE_HOST}",
		      "group": "default_host_group"
		    },
		    {
		      "callbackParameter": "12",
		      "host_ip": "${PLUGIN_HOST}",
		      "group": "default_host_group"
		    }
		  ]
		}
	EOF
