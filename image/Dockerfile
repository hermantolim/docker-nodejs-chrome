FROM ubuntu:18.04

COPY . /bd_build
ARG APT_CACHER_NG
RUN /bd_build/install.sh
ENV DEBIAN_FRONTEND="noninteractive" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

CMD ["/sbin/my_init"]
EXPOSE 80 443 22