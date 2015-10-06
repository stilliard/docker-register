FROM ubuntu:14.04
MAINTAINER Jason Wilder <jason@influxdb.com>

RUN apt-get update
RUN apt-get install -y wget python python-pip python-dev libssl-dev libffi-dev bash

RUN mkdir /app
WORKDIR /app

ENV DOCKER_GEN_VERSION 0.4.1

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
  && rm docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

RUN pip install python-etcd

ADD . /app

ENV DOCKER_HOST unix:///var/run/docker.sock

CMD docker-gen -interval 10 -watch -notify "python /tmp/register.py" etcd.tmpl /tmp/register.py

# CMD docker-gen -watch -only-published -notify "python /tmp/register.py" etcd.tmpl /tmp/register.py

