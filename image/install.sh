#!/bin/bash
set -e
source /bd_build/buildconfig

#run /bd_build/enable_repos.sh
run /bd_build/prepare.sh
run /bd_build/system_services.sh
run /bd_build/utilities.sh
run /bd_build/nodejs.sh
run /bd_build/python.sh
run /bd_build/finalize.sh
