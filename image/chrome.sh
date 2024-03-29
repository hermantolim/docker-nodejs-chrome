#!/bin/bash
set -e
source /build/buildconfig

header "Installing chrome"
#CHROME_PACKAGE="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
#curl -L "$CHROME_PACKAGE" > $HOME/chrome.deb
#dpkg -i $HOME/chrome.deb

curl -s https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
cat >>/etc/apt/sources.list.d/google-chrome.list <<EOF
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
EOF

apt-get update
minimal_install google-chrome-stable
