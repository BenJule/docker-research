FROM nginx
 
COPY registry.conf /etc/nginx/conf.d/nginx.conf
COPY docker-registry.conf /etc/nginx/docker-registry.conf
COPY docker-registry-v2.conf /etc/nginx/docker-registry-v2.conf
COPY domain.crt /etc/nginx/domain.crt
COPY domain.key /etc/nginx/domain.key