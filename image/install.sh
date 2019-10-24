#!/bin/bash
set -e
source /build/buildconfig

run /build/prepare.sh
run /build/system_services.sh
run /build/utilities.sh
run /build/nodejs.sh
run /build/chrome.sh
run /build/finalize.sh
