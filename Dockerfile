FROM daocloud.io/library/nginx:latest

# 将代码copy到镜像
COPY ./dist /usr/share/nginx/html

# 将 nginx 配置文件 copy 到容器内配置文件的目录下
COPY ./deploy/nginx.conf /etc/nginx

# 将 shell copy 到 workdir 目录，此处为 /opt
COPY ./deploy/main.sh /etc/nginx

# 给环境变量设置初始值
ENV SERVER_URL=http://10.0.24.12:3334

RUN #apt update && apt install -y apt-transport-https
RUN  #apt install bind9

# workdir
WORKDIR /etc/nginx

# 容器内给shell文件添加所有用户可执行权限
RUN chmod a+x ./main.sh

# 容器应用端口
EXPOSE 80

# 每次容器启动时执行 main.sh shell 文件
CMD ["sh", "main.sh"]