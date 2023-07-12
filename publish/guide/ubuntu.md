# Install Ubuntu on Windows

1. 从 https://www.vmware.com/cn/products/workstation-pro.html 下载或者 **_VMware-workstation-full-17.0.2-21581411.rar_** 解压并安装 vmware, 需要关闭 windows 安全中心, 并根据安装提示开启 bios 的虚拟化.

2. 启动 vmware 关闭 nat 模式下的 dhcp 分配.

3. 从 https://cn.ubuntu.com/download/server/step1 下载 ubuntu lts 版本系统镜像, 使用 vmware 进行系统安装:

    - vmware 虚拟机选项中设置 vmware tools 手动更新, 固件类型使用 **uefi**
    - ubuntu 使用 minimized 安装
    - 根据 vmware 的 nat 信息设置 ubuntu 的静态 ip 为 **_\*.\*.\*.\*_**, 其中 name server 填写 **\*.\*.\*.\*** _(查询当地 dns)_, search domains 填写
      **\*.\*.\*.\*** _(查询当地 dns)_
    - 创建用户为 **\~**, 系统名称为 **ubuntu_server_22042**<br><br>

4. 进入 ubuntu 系统后, 进行必要设置和软件安装:

    - 从 https://mirrors.aliyun.com/ubuntu/ 获取设置 apt 源为阿里镜像的方法
    - 使用 `sudo apt update` 更新 apt
    - 使用 `sudo apt install vim` 安装 vim 编辑器
    - 使用 `sudo apt install cron` 安装 crontab 工具进行脚本启动配置
    - _(可选)_ 使用 `sudo apt install net-tools` 安装 ip 工具
    - _(可选)_ 使用 `sudo apt install inetutils-ping` 安装 ping 工具<br><br>

5. 设置 ubuntu 和宿主 windows 之间的文件共享:

    - vmware 中添加共享文件夹, 名称为 **share**.
    - 使用 `sudo apt install open-vm-tools` 安装 vmware 扩展工具
    - 使用 `sudo groupadd -g 1001 share` 添加 **share** 用户组, 使用 `vi /etc/group` 可进行确认.
    - 使用 `sudo usermod -a -G share ~` 添加用户 **\~** 到 **share** 用户组中, 使用 `vi /etc/passwd` 可进行确认
    - 使用 `sudo chmod g+w hgfs` 为 **_/mnt/hgfs_** 文件夹添加用户组的写权限
    - 使用 `sudo chown root:share` 更改 **_/mnt/hgfs_** 文件夹的用户组为 **share**
    - 使用 `vmhgfs-fuse .host:/share /mnt/hgfs` 确认开启文件共享<br><br>

6. 设置 ubuntu 用户的自启动脚本, 实现开机自动执行脚本:

    - 在 **_/home/\~_** 目录下建立 **_startup.sh_**, 给予 **x** 权限
    - 在 **_shartup.sh_** 中添加代码:

        ```
        #!/bin/bash

        # start file share.
        vmhgfs-fuse .host:/share /mnt/hgf
        ```

    - 使用 `crontab -e -u ~` 打开 cron 编辑器, 在末尾添加指令
        ```
        @reboot /home/~/startup.sh
        ```
        使得开机执行此脚本
    - 重启 ubuntu 后进入 **_/mnt/hgfs_** 文件夹进行验证

7. 使用 vscode 远程登陆到 ubuntu:

    - 宿主 windows 使用 `ssh-keygen -t rsa -C "~_vscode"` 创建 ssh 密钥文件对至 **_C:\Users\~\project\env_common\ssh_** 目录
    - 将 **_\~\_vscode_rsa.pub_** 拷贝至 ubuntu 的 **_/home/\~/.ssh_** 目录下
    - ubuntu 使用 `cat ~_vscode_rsa.pub >> authorized_keys` 导入公钥
    - 设置 vscode 的 remote ssh 配置, 在 **_vscode_ssh_config_** 文件中添加:
        ```
        Host ubuntu_server_22042
            HostName *.*.*.*
            User ~
            Port 22
            IdentityFile C:/Users/~/project/env_common/ssh/~_vscode_rsa
        ```
    - ubuntu 使用 `systemctl status ssh` 确保 ssh 服务正常运行, 此时可以通过 vscode 的 remote ssh 连接到 ubuntu 中
    - 第一次使用 vscode 进行远程连接时指定 server 类别为 linux, 此时在 **文件 -> 首选项 -> 设置 -> 用户 -> 切换至 json 编辑模式** 中会自动添加以下配置:
        ```
        "remote.SSH.remotePlatform": {
            "ubuntu_server_22042": "linux"
        }
        ```

8. 配置使用 putty 系列工具远程连接 ubuntu:

    - 从 https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html 下载 **puttygen.exe** 和 **plink.exe**
    - 使用 **puttygen.exe -> Coversions -> Import Key** 导入私钥文件 **_\~\_vscode_rsa_**, 点击 **Save private key** 保存 **_\~\_vscode_rsa.ppk_** 至 **_C:\Users\\~\project\env_common\ssh_** 目录
    - 使用 `plink -i C:\Users\~\project\env_common\ssh\~_vscode_rsa.ppk` 即可通过密钥连接到 ubuntu<br><br>

9. 为 ubunt 安装并配置 docker:
    - 使用 `sudo apt install docker.io` 安装 docker
    - 使用 `sudo gpasswd -a ~ docker` 添加用户 **\~** 到 **docker** 组中, 并使用 `newgrp docker` 更新 docker 组
    - 使用 ` systemctl start docker` 启动 docker, 并使用 `systemctl enable docker` 设置开机启动 docker
    - 从 https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors 获取阿里的私有 docker 镜像, 并获取配置 docker 源的方法, 打开或建立 **_/etc/docker/daemon.json_** 文件, 并添加配置:
        ```
        {
          "registry-mirrors": [
            "https://*.mirror.aliyuncs.com",
            "http://hub-mirror.c.163.com",
            "https://docker.mirrors.ustc.edu.cn",
            "https://mirror.ccs.tencentyun.com",
            "https://registry.docker-cn.com"
          ]
        }
        ```
        使用 `systemctl start docker` 重新启动 docker 使配置生效
    - 使用 `docker info` 获取 docker 的 Registry Mirrors 信息确保镜像被正确添加并识别
