#!/bin/bash
set -e
source /bd_build/buildconfig

header "Installing Python..."
minimal_install python python2.7 python3
