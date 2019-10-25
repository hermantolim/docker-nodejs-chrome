#!/bin/bash
set -e
source /build/buildconfig

export INITRD=no
mkdir -p /etc/container_environment
echo -n no > /etc/container_environment/INITRD

# Ensure that docs and non-English locales are not installed.
run cp /build/config/dpkg-nodocs.conf /etc/dpkg/dpkg.cfg.d/01_nodoc
run cp /build/config/dpkg-only-english-locale.conf /etc/dpkg/dpkg.cfg.d/01_only_english_locale

[[ -n "${APT_CACHER_NG}" ]] && proxy "${APT_CACHER_NG}"

header "Preparing installation packages"
cat >/etc/apt/sources.list <<EOF
deb http://archive.ubuntu.com/ubuntu/ bionic main universe
deb http://archive.ubuntu.com/ubuntu/ bionic-security main universe
deb http://archive.ubuntu.com/ubuntu/ bionic-updates main universe
EOF

apt-get update
minimal_install gnupg

dpkg-divert --local --rename --add /sbin/initctl
ln -sf /bin/true /sbin/initctl

dpkg-divert --local --rename --add /usr/bin/ischroot
ln -sf /bin/true /usr/bin/ischroot

#    xdg-utils \
#    fonts-liberation \

#    libxss1 \
#    libappindicator3-1 \
#    libasound2 \
#    libatk1.0-0 \
#    libatk-bridge2.0-0 \
#    libcairo-gobject2 \
#    libgconf-2-4 \
#    libgtk-3-0 \
#    libnspr4 \
#    libnss3 \
#    libx11-xcb1 \
#    libxcomposite1 \
#    libxcursor1 \
#    libxdamage1 \
#    libxfixes3 \
#    libxi6 \
#    libxinerama1 \
#    libxrandr2 \
#    libxss1 \
#    libxtst6 \

minimal_install \
    apt-utils \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    fontconfig \
    gconf-service \
    language-pack-en \
    git \
    curl

apt-get dist-upgrade -y --no-install-recommends -o Dpkg::Options::="--force-confold"

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

locale-gen
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_CTYPE=en_US.UTF-8
echo -n en_US.UTF-8 > /etc/container_environment/LANG
echo -n en_US.UTF-8 > /etc/container_environment/LC_CTYPE
echo -n UTC > /etc/container_environment/TZ

header "Performing miscellaneous preparation"

## Create a user for the web app.
run addgroup --gid 9999 app
run adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app
run usermod -L app
run mkdir -p /home/app/.ssh
run chmod 700 /home/app/.ssh
run chown app:app /home/app/.ssh