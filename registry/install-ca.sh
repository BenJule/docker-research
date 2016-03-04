#!/bin/bash
#
#生成一个新的root key
openssl genrsa -out devdockerCA.key 2048

#生成根证书（一路回车即可）
openssl req -x509 -new -nodes -key devdockerCA.key -days 10000 -out devdockerCA.crt

# 为server创建一个key。（这个key将被nginx配置文件registry.con中ssl_certificate_key域引用）
openssl genrsa -out domain.key 2048

#制作证书签名请求。注意在执行下面命令时，命令会提示输入一些信息，”Common Name”一项一定要输入你的域名（官方说IP也行，但是也有IP不能加密的说法），其他项随便输入什么都可以。不要输入任何challenge密码，直接回车即可。
openssl req -new -key domain.key -out dev-docker-registry.com.csr

# 签署认证请求
openssl x509 -req -in dev-docker-registry.com.csr -CA devdockerCA.crt -CAkey devdockerCA.key -CAcreateserial -out domain.crt -days 10000
