FROM node:4.2.4
MAINTAINER zysam

# npm set cnpm
RUN npm config set registry https://registry.npm.taobao.org
RUN npm config set distcurl https://npm.taobao.org/dist

ADD . /app
WORKDIR　/app

#EXPOSE 22
CMD ["/run.sh"]
