#!/bin/bash
set -e
source /build/buildconfig

header "Finalizing..."

run apt-get remove -y autoconf automake
run apt-get autoremove -y
run apt-get clean
run rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
run find / -mount -name *.pyc -delete
run find / -mount -name *__pycache__* -delete
run rm -rf /etc/ssh/ssh_host_*
run rm -rf /build
run rm -rf /etc/apt/apt.conf.d/99proxy