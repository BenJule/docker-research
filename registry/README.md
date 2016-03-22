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
## 使用 SSL 生成自签名证书

详见 ./install-ca.sh

## 创建用户, 按提示输入密码
```
htpasswd -c ./auth/registry.password admin
htpasswd -c ./auth/registry.password admin
```

- 上面命令中 USERNAME 代表你指定的用户名，命令会交互式要求你设置密码
- 如果需要创建多个账号，可以追加命令 htpasswd 不带 -c (create)，否则会清空之前数据库。

## 客户端安装证书

http://www.cnblogs.com/rader/p/3781880.html

将 devdockerCA 导入客户端证书
