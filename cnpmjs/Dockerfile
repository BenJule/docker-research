FROM mhart/alpine-node:4

MAINTAINER zysam<explnwind@gmail.com>

#install of ustc source if in china
RUN echo "http://mirrors.ustc.edu.cn/alpine/v3.3/main/" > /etc/apk/repositories
RUN apk update \
    && apk add make gcc g++ python \
    && rm -rf /var/cache/apk/*

# install cnpmjs.org sqlite3@3.1.0 because @latest will be fail
RUN npm config set registry https://registry.npm.taobao.org \
    && npm config set distcurl https://npm.taobao.org/dist
RUN npm install -g cnpmjs.org
RUN npm install -g sqlite3@3.1.0
RUN npm cache clean

WORKDIR /data
# cnpmjs.org default save db in HOME 
ENV HOME /data

EXPOSE 7001 7002

CMD ["cnpmjs.org", "start", "--dataDir='/data'"]
