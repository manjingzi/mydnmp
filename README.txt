## 本地安装 docker docker-compose(window不用安装 docker自带docker-compose)
## 网易加速器链接: http://hub-mirror.c.163.com
## ustc加速器链接:https://docker.mirrors.ustc.edu.cn
## windows cmder软件 https://www.jianshu.com/p/5b7c985240a7
## 本地安装 git 如果没有安装需要手动下载源码
## 以下命令在windows10 中的 git base 执行
## 免费申请HTTPS https://freessl.cn/ 选择 Let’s Encrypt

## 安装后的工作目录
├ dnmp
├── conf                    配置文件目录
│   ├── conf.d              Nginx用户站点配置目录
│   ├── nginx.conf          Nginx默认配置文件
│   ├── mysql.cnf           MySQL用户配置文件
│   ├── php-fpm.conf        PHP-FPM配置文件（部分会覆盖php.ini配置）
│   └── php.ini             PHP默认配置文件
├── Dockerfile              PHP镜像构建文件
├── log                     Nginx日志目录
├── mysql                   MySQL数据目录
├── source.list             Debian源文件
├ 
├ 
├ dnmp_www					需手动新建，目录名称是固定不能修改
├── acemap-yii2-2019		项目目录  			acemap.jjcms.com 访问
├── test					项目环境测试目录	www.jjcms.com 访问

## 获取源代码
git clone https://github.com/manjingzi/dnmp.git

## 进入目录
cd dnmp

## 运行镜像环境配置compose以守护进程模式运行
docker-compose up -d --build

## 看到以下字符说明安装成功
## Creating dnmp_mysql_1 ... done
## Creating dnmp_nginx_1 ... done
## Creating dnmp_php72_1 ... done
## Creating dnmp_redis_1 ... done

cd ../

#######################################################
## 本地已安装php 和 php composer					 ##
#######################################################

## 新建目录dnmp_www 固定目录不能修改
mkdir dnmp_www

## 进入目录
cd www

## 获取源代码
git clone https://github.com/SamJia/acemap-yii2-2019.git

## 进入开发项目
cd acemap-yii2-2019

## 项目组建更新
composer update

## 初始化项目 选择开发版 按0 再按yes
php init 

#######################################################
## 本地未安装php 和 composer 可以进入docker服务器安装##	
#######################################################

## 进入指定的容器 如:在容器 dnmp_php72_1 中开启一个交互模式的终端
## WINDOWS中 git base 执行无效 使用windows自带的powershell  默认进入容器/var/www/html/
docker exec -it dnmp_php72_1 /bin/bash

## 新建目录dnmp_www 固定目录不能修改
mkdir dnmp_www

## 进入目录
cd dnmp_www

## 获取测试mysql redis是否正常工作 通过https://www.jjcms.com访问 
git clone https://github.com/SamJia/acemap-yii2-2019.git

## 获取源代码 通过https://acemap.jjcms.com 访问 需要配置本地域名指向
git clone https://github.com/SamJia/acemap-yii2-2019.git

## 进入开发项目
cd acemap-yii2-2019

## 项目组建更新
composer update

## 初始化项目 选择开发版 按0 再按yes
php init

##########################################################################################
## 注意事项																				##
## 关闭计算机前执行停止容器命令 docker-compose stop										##
## 第二次启动																			##
docker-compose start																	##
如果发现启动失败 发现错误如driver failed programming external connectivity on endpoint	##
Starting mysql ... error																##
Starting redis ... error																##
Starting php72 ... error																##
Starting nginx ... error																##
失败原因：docker服务启动时定义的自定义链DOCKER由于某种原因被清掉						##
重启docker服务及可重新生成自定义链DOCKER												##
解决方法:重启docker服务后再启动容器														##
##########################################################################################

## 数据库配置 默认数据库使用了局域网的10.10.10.4
host:mysql
port:3306 
username:root
password:root

## redis 配置
host:redis
port:6379

## https访问网站需要设置
## windows 配置域名指向
## C:\Windows\System32\drivers\etc\hosts 配置域名指向

127.0.0.1 acemap.jjcms.com
127.0.0.1 acemap-api.jjcms.com
127.0.0.1 old.jjcms.com
127.0.0.1 www.jjcms.com
127.0.0.1 api.jjcms.com

## 测试yii2 mysql redis 状态
http://www.jjcms.com/

## 前端
http://acemap.jjcms.com/

## 后端
http://acemap.jjcms.com/backend/

## api
http://acemap-api.jjcms.com/

## 查看docker-compose命令教程 https://blog.csdn.net/qq_14845119/article/details/83276414

#######################################################

## compose以守护进程模式运行加-d选项
docker-compose up -d

## 会优先使用已有的容器，而不是重新创建容器。
docker-compose up  

## 使用 --force-recreate 可以强制重建容器 （否则只能在容器配置有更改时才会重建容器）
docker-compose up -d --force-recreate 

## 修改配置后重启ningx 
docker exec dnmp_nginx_1 nginx -s reload

## 进入指定的容器 如:在容器 dnmp_php72_1 中开启一个交互模式的终端
## WINDOWS中 git base 执行无效 使用windows自带的powershell  默认进入容器/var/www/html/
docker exec -it dnmp_php72_1 /bin/bash

#######################################################

## 启动容器
docker-compose up

## 停止容器
docker-compose stop

# 此命令将会停止 up 命令所启动的容器，并移除网络
docker-compose down

## 启动容器
docker-compose start

#######################################################

## 查看容器
docker ps -a

## 查看镜像
docker images

## 停止容器
docker stop 容器ID

## 批量停止容器 相当于docker-compose stop
docker stop $(docker ps -a -q) 
docker stop `docker ps -a -q`

#######################################################

## 删除容器
docker rm 容器ID

## 批量删除容器
docker rm $(docker ps -a -q)
docker rm `docker ps -a -q`

## 删除镜像
docker rmi 镜像ID和名称

## 删除全部镜像
docker rmi $(docker images) 

#######################################################

## 一起查看容器和镜像
docker ps -a && docker images

## 一起删除容器和镜像
docker rm $(docker ps -a -q) && docker rmi $(docker images -a -q) -f

#######################################################
linux redis 操作 批量模糊删除key
redis-cli keys cache* | xargs redis-cli del

进入redis客户端
docker exec -it 容器ID redis-cli

info 查看redis 信息
dbsize 查看redis keys数量

docker中清除redis数据


清除缓存
flushall  所有数据库
flushdb  当前库

清除指定key

查询所有key：keys *
删除指定key：del xxx（key）