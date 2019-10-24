#!/bin/bash
set -e
source /bd_build/buildconfig

run /bd_build/prepare.sh
run /bd_build/system_services.sh
run /bd_build/utilities.sh
run /bd_build/nodejs.sh
run /bd_build/chrome.sh
run /bd_build/finalize.sh
