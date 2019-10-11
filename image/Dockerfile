FROM ubuntu:18.04

ADD . /bd_build
RUN /bd_build/install.sh
CMD ["/sbin/my_init"]
EXPOSE 80 443