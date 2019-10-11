#!/bin/bash
set -e
source /bd_build/buildconfig

export INITRD=no
mkdir -p /etc/container_environment
echo -n no > /etc/container_environment/INITRD

cat >/etc/apt/sources.list <<EOF
deb http://archive.ubuntu.com/ubuntu/ bionic main universe
deb http://archive.ubuntu.com/ubuntu/ bionic-security main universe
deb http://archive.ubuntu.com/ubuntu/ bionic-updates main universe
EOF

apt-get update

dpkg-divert --local --rename --add /sbin/initctl
ln -sf /bin/true /sbin/initctl

dpkg-divert --local --rename --add /usr/bin/ischroot
ln -sf /bin/true /usr/bin/ischroot

minimal_install \
    apt-utils \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    curl

minimal_install xvfb firefox-geckodriver
## Upgrade all packages.
apt-get dist-upgrade -y --no-install-recommends -o Dpkg::Options::="--force-confold"

minimal_install language-pack-en

locale-gen en_US
update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8
echo -n en_US.UTF-8 > /etc/container_environment/LANG
echo -n en_US.UTF-8 > /etc/container_environment/LC_CTYPE

header "Performing miscellaneous preparation"

## Ensure that docs and non-English locales are not installed.
run cp /bd_build/config/dpkg-nodocs.conf /etc/dpkg/dpkg.cfg.d/01_nodoc
run cp /bd_build/config/dpkg-only-english-locale.conf /etc/dpkg/dpkg.cfg.d/01_only_english_locale

## Create a user for the web app.
run addgroup --gid 9999 app
run adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app
run usermod -L app
run mkdir -p /home/app/.ssh
run chmod 700 /home/app/.ssh
run chown app:app /home/app/.ssh
