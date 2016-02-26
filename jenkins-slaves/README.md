### 说明
运行 jenkins , 多个 jenkins 主机: jenkins-slave。
参考[appcontainers](http://www.appcontainers.com/jenkins)

运行
----
	docker-compose up -d

打包
---
	docker build -t image-name path

### 测试容器

```
docker run -it --rm\
--name j-test \
--volumes-from jenkins_keydata_1 \
-h j-test \
-e ROLE="slave" \
appcontainers/jenkins:debian
```
### 提取数据 管理容器
1
----
docker run -it --rm \
	-v /home/docker/tmp:/home \
	--volumes-from jenkins_data_1 \
	-e ROLE="slave" \
	koala/jenkins-slave

2
----
docker run -it --rm \
	-v /home/docker/tmp:/home \
	--volumes-from kj_data_1 \
	-e ROLE="slave" \
	koala/jenkins-slave

### Dockerfile [hub.docker.com](https://hub.docker.com/r/appcontainers/jenkins/)

CentOS 6.7 Based Customizable Jenkins Container - 494 MB - Updated 12/27/2015

Built from appcontainers/centos:6

appcontainers/jenkins:latest
appcontainers/jenkins:centos

In Depth Container Details, and Changelog can be found here:
http://www.appcontainers.com/jenkins

 

Debian 8 Jessie Based Customizable Jenkins Container - 378MB - Updated 12/27/2015

Built from appcontainers/debian:jessie

appcontainers/codiad:jenkins

In Depth Container Details, and Changelog can be found here:
http://www.appcontainers.com/jenkins

 

Ubuntu 15.10 Wily Werewolf Based Customizable Jenkins Container - 413MB - Updated 12/27/2015

Built from appcontainers/ubuntu:wily

appcontainers/jenkins:ubuntu

In Depth Container Details, and Changelog can be found here:
http://www.appcontainers.com/jenkins