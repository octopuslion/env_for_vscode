# Set MySQL on Linux

1.  使用 `docker pull mysql:8.0.33-debian` 拉取 mysql 基于 debian 的镜像

2.  使用 `docker run -d -p 3306:3306 --name mysql_temp -e MYSQL_ROOT_PASSWORD=* mysql:8.0.33-debian` 启动临时的 mysql 容器<br>
    使用 `docker exec -i -t mysql_temp /bin/bash` 进入容器并进行以下确认:

    -   使用 `cat /etc/os-release` 查看 debian 版本, 为**"11 (bullseye)"**
    -   使用 `cat /etc/passwd` 查看用户 **mysql** 的 id, 为"**999**"
    -   使用 `cat /etc/group` 查看用户组 **mysql** 的 id, 为"**999**"<br><br>

    _注意以上信息需要在后续步骤中使用_<br>

    使用 `exit` 退出容器<br>
    使用 `docker stop mysql_temp` 退出容器<br>
    使用 `docker rm mysql_temp` 删除容器<br>

3.  创建基于开发环境的 mysql 镜像, 在 **_./proj_tmpl_server/dev/depl_** 目录下建立 **_mysql_** 目录, 放入脚本和配置文件:

    -   Dockerfile
    -   debian.sources.list.http
    -   debian.sources.list
    -   launch.sh<br><br>

4.  调整脚本和配置文件中的参数, 使之符合项目:

    -   在 **_Dockerfile_** 中添加需要的 app 安装命令
    -   从 https://mirrors.tuna.tsinghua.edu.cn/help/debian/ 中确认当前 debian 版本的清华镜像 (http) 配置, 更新 **_debian.sources.list.http_** 中的配置
    -   从 https://developer.aliyun.com/mirror/debian 中确认当前 debian 版本的阿里镜像配置, 更新 **_debian.sources.list_** 中的配置
    -   调整 **_launch.sh_** 的 **options** 参数值<br><br>

5.  确认 mysql 容器中 mysql 用户和用户组的 id 使用 `sudo useradd -M -s /usr/sbin/nologin mysql && sudo usermod -u 999 mysql && sudo groupmod -g 999 mysql` 创建对应的本地 linux 用户和用户组

6.  确认数据目录 **_./proj_tmpl_server/dev/data_** 被创建<br>
    选择执行 `./proj_tmpl_server/depl/dev/depl/mysql/launch.sh -rebuild-image` 脚本构建镜像和容器并启动容器, 或者<br>
    选择执行 `./proj_tmpl_server/depl/dev/depl/mysql/launch.sh -restart` 脚本仅构建并启动容器<br>
    此时镜像和容器均创建成功, 但是容器启动失败, 进行以下设置:

    -   在 **_./proj_tmpl_server/dev/data_** 中确认 **_mysql_** 目录被容器创建
    -   在 **_./proj_tmpl_server/dev/data/mysql/conf_** 下放入 **_my.cnf_**
    -   使用 `sudo chown -R mysql:mysql ./mysql` 更改 **_./proj_tmpl_server/dev/data/mysql_** 目录用户和用户组为 mysql
    -   再次启动容器, 确认容器可以正确运行<br><br>

7.  进入 mysql 容器并创建可供远程连接的用户并创建测试数据库:

    -   使用 `docker exec -i -t proj_tmpl_mysql_dev /bin/bash` 进入 mysql 容器
    -   使用 `mysql -uroot -p*` 进入 mysql cli
    -   使用 `grant all privileges on _._ to 'root'@'localhost';` 为 **root@localhost** 用户授权
    -   使用 `create user 'remote_user_dev'@'%' identified by '*';` 创建进行远程连接的测试用户
    -   使用 `grant all privileges on remote_user_dev.* to 'remote_user_dev'@'%';` 为用户授权
    -   使用 `flush privileges;` 刷新授权
    -   使用 `create database if not exists dev_db default character set utf8;` 创建测试数据库
    -   使用 `grant all privileges on dev_db.* to 'remote_user_dev'@'%';` 将数据库授权给用户
    -   使用 `\q` 退出 mysql cli
    -   使用 `exit` 退出容器<br><br>

8.  vscode 中配置 sqltool 插件以连接到测试数据库进行验证, 此时在 **文件 -> 首选项 -> 设置 -> 工作区 -> 切换至 json 编辑模式** 中会自动添加以下配置:

    ```
    "sqltools.connections": [
        {
            "mysqlOptions": {
                "authProtocol": "default",
                "enableSsl": "Disabled"
            },
            "previewLimit": 50,
            "server": "*.*.*.*",
            "port": 3307,
            "driver": "MySQL",
            "name": "proj_tmpl_mysql_dev",
            "database": "dev_db",
            "username": "remote_user_dev",
            "password": "*"
        }
    ]
    ```

9.  启动基于发布环境的 mysql 容器, 在 **_./proj_tmpl_server/prod/depl_** 目录下建立 **_mysql_** 目录, 放入脚本文件:

    -   launch.sh<br><br>

    调整此脚本中的 **options** 使之符合项目

10. 确认数据目录 **_./proj_tmpl_server/prod/data_** 被创建<br>
    执行 `./proj_tmpl_server/depl/prod/depl/mysql/launch.sh -restart` 脚本仅构建并启动容器<br>
    在 **_prod_** 目录下重复后续步骤 6, 7, 8 以配置发布环境下的 mysql

11. 在 **_/home/octopus/startup.sh_** 添加配置以设置开机启动 mysql 容器:
    ```
    # start mysql dev container from docker.
    /home/~/project/proj_tmpl_server/dev/depl/mysql/launch.sh
    /home/~/project/proj_tmpl_server/prod/depl/mysql/launch.sh
    ```
    重启 linux 以进行验证
