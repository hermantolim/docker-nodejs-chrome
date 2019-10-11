#!/bin/sh

mkdir -p /tmp/docker
docker container run --network host --rm -v /tmp/docker:/tmp -i -t hermantolim/firefox-geckodriver-baseimage:0.1.0 /sbin/my_init -- bash -l