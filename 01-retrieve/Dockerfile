#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu

# Install.
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y jq ruby && gem install twurl

ADD downloads /var/downloads


