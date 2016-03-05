## 环境需求

- docker
- docker-compose
- apache2-utils

## 文件结构

```
├── data
├── docker-compose.yml
├── nginx
│   ├── dev-docker-registry.com.csr
│   ├── devdockerCA.crt
│   ├── devdockerCA.key
│   ├── devdockerCA.srl
│   ├── domain.crt
│   ├── domain.key
│   ├── registry.conf
│   └── registry.password
└── readme.md

```
## 创建用户, 按提示输入密码
```
htpasswd -c ./auth/registry.password admin
```
or
```
htpasswd -bn test testpwd
```

- 上面命令中 USERNAME 代表你指定的用户名，命令会交互式要求你设置密码
- 如果需要创建多个账号，可以追加命令 htpasswd 不带 -c (create)，否则会清空之前数据库。

## 使用 SSL 生成自签名证书
```
openssl req \
		 -newkey rsa:2048 -nodes -keyout domain.key \
		 -x509 -days 365 -out domain.crt
```
加入SSL验证

如果你有经过认证机构认证的证书，则直接使用将证书放入nginx目录下即可。如果没有，则使用openssl创建自己的证书。
进行/data/programs/docker/nginx目录

生成一个新的root key
$ openssl genrsa -out devdockerCA.key 2048

生成根证书（一路回车即可）
$ openssl req -x509 -new -nodes -key devdockerCA.key -days 10000 -out devdockerCA.crt

为server创建一个key。（这个key将被nginx配置文件registry.con中ssl_certificate_key域引用）
$openssl genrsa -out domain.key 2048

制作证书签名请求。注意在执行下面命令时，命令会提示输入一些信息，”Common Name”一项一定要输入你的域名（官方说IP也行，但是也有IP不能加密的说法），其他项随便输入什么都可以。不要输入任何challenge密码，直接回车即可。
$ openssl req -new -key domain.key -out dev-docker-registry.com.csr
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:
State or Province Name (full name) []:
Locality Name (eg, city) [Default City]:
Organization Name (eg, company) [Default Company Ltd]:
Organizational Unit Name (eg, section) []:
Common Name (eg, your name or your server's hostname) []:docker-registry.com
Email Address []:
Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:  
签署认证请求
$ openssl x509 -req -in dev-docker-registry.com.csr -CA devdockerCA.crt -CAkey devdockerCA.key -CAcreateserial -out domain.crt -days 10000

配置nginx使用证书
修改registry.conf配置文件，取消如下三行的注释
```
ssl on;  
ssl_certificate /etc/nginx/conf.d/domain.crt;  
ssl_certificate_key /etc/nginx/conf.d/domain.key; 
```
运行Registry
执行docker-compose up -d在后台运行Registry，并使用curl验证结果。这时使用localhost:5000端口仍然可以直接访问Registry，但是如果使用443端口通过nginx代理访问，因为已经加了SSL认证，所以使用http将返回“400 bad request”
```
$ curl http://localhost:5000/v2/
{}
$ curl http://localhost:443/v2/
<html>
<head><title>400 The plain HTTP request was sent to HTTPS port</title></head>
<body bgcolor="white">
<center><h1>400 Bad Request</h1></center>
<center>The plain HTTP request was sent to HTTPS port</center>
<hr><center>nginx/1.9.9</center>
</body>
</html>
```
应该使用https协议
```
$ curl https://localhost:443/v2/
curl: (60) Peer certificate cannot be authenticated with known CA certificates
More details here: http://curl.haxx.se/docs/sslcerts.html
curl performs SSL certificate verification by default, using a "bundle"
 of Certificate Authority (CA) public keys (CA certs). If the default
 bundle file isn't adequate, you can specify an alternate file
 using the --cacert option.
If this HTTPS server uses a certificate signed by a CA represented in
 the bundle, the certificate verification probably failed due to a
 problem with the certificate (it might be expired, or the name might
 not match the domain name in the URL).
If you'd like to turn off curl's verification of the certificate, use
 the -k (or --insecure) option.
```
由于是使用的未经任何认证机构认证的证书，并且还没有在本地应用自己生成的证书。所以此时会提示使用的是未经认证的证书，可以使用“-k"选项不进行验证。
```
$ curl -k https://localhost:443/v2/
<html>
<head><title>401 Authorization Required</title></head>
<body bgcolor="white">
<center><h1>401 Authorization Required</h1></center>
<hr><center>nginx/1.9.9</center>
</body>
</html>
```