#!/bin/bash
set -e
source /build/buildconfig

header "Installing Python..."
minimal_install python python2.7 python3
