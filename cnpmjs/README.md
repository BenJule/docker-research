## 基于 alpine 的 cnpm

### 注意项
- cnpmjs.org@2.8.0 最新版加 --dataDir 参数，自定义 config.json 有问题。所以只有写进 ./.cnpmjs.org/config.json, 如果修复的话。直接在根目录建立 config.json, 并不需要 .cnpmjs.org 目录。
- 虽然定义 dataDir , 但数据还是保存在 HOME, 所以将 HOME=dataDir

### BUILD
`docker build -t zysam/cnpmjs .`
### RUN
```
docker run -d \
  --name cnpmjs \
  -v ${PWD}:/data  \
  -p 7001:7001 \
  -p 7002:7002 \
  zysam/cnpmjs 
```
or 
```
docker run -d \
  --name cnpmjs_1 \
  -v ${PWD}:/data  \
  -p 7011:7001 \
  -p 7012:7002 \
  docker.koala.cn/cnpmjs \
  cnpmjs.org start \
    --admins='admin, test' \
    --scopes='@admin, @test' \
    --dataDir='/data'
```



