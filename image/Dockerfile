FROM ubuntu:18.04

COPY . /build

ARG APT_CACHER_NG
ENV APT_CACHER_NG=${APT_CACHER_NG}

RUN /build/install.sh

ENV DEBIAN_FRONTEND="noninteractive" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

ENTRYPOINT ["/sbin/my_init", "--"]
CMD ["/bin/bash"]