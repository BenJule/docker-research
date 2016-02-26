### 测试容器

```
docker run -it \
--privileged \
--name j-test \
--volumes-from jenkins_keydata_1 \
-h j-test \
-e ROLE="slave" \
appcontainers/jenkins:debian
```

### 安装node及其它
	apt-get update && apt-get -y install python gcc make g++ vim

### debain 修改源


 cp /etc/apt/sources.list /etc/apt/sources.list.bak
 echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" > /etc/apt/sources.list
 echo "deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib" >> /etc/apt/sources.list
 echo "deb http://mirrors.163.com/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list
 echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >> /etc/apt/sources.list
 echo "deb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib" >> /etc/apt/sources.list
 echo "deb-src http://mirrors.163.com/debian/ jessie-backports main non-free contrib" >> /etc/apt/sources.list
 echo "deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list
 echo "deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list

### 安装 node 0.10.35
wget http://npm.taobao.org/mirrors/node/v0.10.35/node-v0.10.35-linux-x64.tar.gz && \
	tar xzf node-v0.10.35-linux-x64.tar.gz && \
	ln -s /apps/node-v0.10.35-linux-x64/bin/node /usr/local/bin/node && \
	ln -s /apps/node-v0.10.35-linux-x64/bin/npm /usr/local/bin/npm

### 安装 node 4.x



### 安装 docker
curl -sSL https://get.docker.com/ | sh
service docker start
