FROM ubuntu:latest

MAINTAINER Wurstmeister 

ENV KAFKA_VERSION="0.9.0.0" SCALA_VERSION="2.10"
RUN  rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y software-properties-common

RUN add-apt-repository ppa:openjdk-r/ppa && apt-get update && apt-get install -y unzip openjdk-8-jdk wget curl git docker.io jq

ADD download-kafka.sh /tmp/download-kafka.sh
RUN /tmp/download-kafka.sh
RUN tar xf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt

VOLUME ["/kafka"]

ENV KAFKA_HOME /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}
ADD start-kafka.sh /usr/bin/start-kafka.sh
ADD broker-list.sh /usr/bin/broker-list.sh
CMD start-kafka.sh
