#!/bin/bash
set -e
source /bd_build/buildconfig

header "installing nodejs"

curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
cat >>/etc/apt/sources.list <<EOF
deb https://deb.nodesource.com/node_12.x bionic main
EOF

apt-get update
minimal_install nodejs
run npm update npm -g

if [[ ! -e /usr/bin/node ]]; then
    ln -s /usr/bin/nodejs /usr/bin/node
fi
