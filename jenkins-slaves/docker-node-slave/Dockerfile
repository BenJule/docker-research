# VESION 0.0.1
# jenkins slave for node0.10.35

FROM appcontainers/jenkins:debian
MAINTAINER zysam

# Edit sources
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
RUN echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" > /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list

# Install packages
RUN apt-get update && \
    apt-get -y install vim python gcc make g++
RUN apt-get -y install curl

# install node
# VERSION 0.10.35
RUN mkdir /apps
WORKDIR /apps
RUN wget http://npm.taobao.org/mirrors/node/v0.10.35/node-v0.10.35-linux-x64.tar.gz && \
	tar xzf node-v0.10.35-linux-x64.tar.gz && \
	ln -s /apps/node-v0.10.35-linux-x64/bin/node /usr/local/bin/node && \
	ln -s /apps/node-v0.10.35-linux-x64/bin/npm /usr/local/bin/npm

# npm set cnpm
RUN npm config set registry https://registry.npm.taobao.org
RUN npm config set distcurl https://npm.taobao.org/dist

# install docker
RUN curl -sSL https://get.docker.com/ | sh
RUN service docker start

# clean
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN rm /apps/node-v0.10.35-linux-x64.tar.gz

###################################################################
#*****************  CONFIGURE START ITEMS  ************************
###################################################################

CMD /bin/bash

###################################################################
#****************  EXPOSE APPLICATION PORTS  **********************
###################################################################

# Expose ports to other containers only
EXPOSE 22
EXPOSE 8080
EXPOSE 50000