## 运行 mongo

```
docker run -d \
  --name m1 \
  -p 27017:27017 \
  -v $PWD/m1:/data/db \
  docker.koala.cn/mongo

```