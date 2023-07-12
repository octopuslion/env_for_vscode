# Development for JAVA with SpringBoot in VSCode

1. 从 https://maven.apache.org/download.cgi 下载适配 jdk 17 版本的 maven, 解压到 **_C:\Users\\~\project\env_common\maven_**. 修改 **_conf\settings.xml_** 中的配置为:

    ```
    <localRepository>C:\\Users\\~\\project\\env_common\\cache\\maven_global_repo</localRepository>
    ```

2. 在 **文件 -> 首选项 -> 设置 -> 用户 -> 切换至 json 编辑模式** 中确认以下配置指向了正确 maven 路径:

    ```
    // maven for java
    "maven.showInExplorerContextMenu": false,
    "maven.executable.path": "C:\\Users\\~\\project\\env_common\\maven\\bin\\mvn",
    ```

3. 在 **_.\proj_tmpl_local\env_** 下建立 **_maven_** 目录并放入 **_settings.xml_** 文件进行配置:

    ```
    <localRepository>C:\\Users\\~\\project\\proj_tmpl_local\\env\\maven\\repo</localRepository>
    ```

    从 https://developer.aliyun.com/mirror/maven 获取配置 maven 源为阿里镜像的方式, 并更新镜像配置:

    ```
    <mirror>
      <id>aliyun-maven</id>
      <mirrorOf>*</mirrorOf>
      <name>aliyun maven</name>
      <url>	https://maven.aliyun.com/repository/public</url>
    </mirror>
    ```

4. 从 ~~https://www.oracle.com/cn/java/technologies/downloads~~ (license 策略, 避免使用) 或 http://www.codebaoku.com/jdk/jdk-index.html 下载 jdk 17 _(vscode 的 java linting 插件必须支持此版本以上)_, 解压到 **_.\proj_tmpl_local\env\jdk_**

5. 在 **_.\\.vscode\settings.json_** 中添加以下针对 java 和 maven 的配置:

    ```
    // debugger for java
    "java.jdt.ls.java.home": "C:\\Users\\~\\project\\proj_tmpl_local\\env\\jdk",
    "java.configuration.maven.userSettings": "C:\\Users\\~\\project\\proj_tmpl_local\\env\\maven\\settings.xml",
    "java.configuration.maven.globalSettings": "C:\\Users\\~\\project\\proj_tmpl_local\\env\\maven\\settings.xml",

    // maven for java
    "terminal.integrated.env.windows": {
        "JAVA_HOME": "C:\\Users\\~\\project\\proj_tmpl_local\\env\\jdk"
    },
    "maven.terminal.customEnv": [
        {
            "environmentVariable": "JAVA_HOME",
            "value": "C:\\Users\\~\\project\\proj_tmpl_local\\env\\jdk"
        }
    ],
    "maven.executable.options": "--settings \"C:\\Users\\~\\project\\proj_tmpl_local\\env\\maven\\settings.xml\"",
    ```

    调整此配置中的参数值使之符合项目, 使用绝对路径以避免可能的错误

6. 在项目 **_.\proj_tmpl_local\src_** 目录下建立基于 maven 结构的 java 目录, 参考 **_.\proj_tmpl_local\src\java_tmpl_**

7. 在 **_.\\.vscode_** 下建立 **_launch.json_** 文件 _(如果不存在的话)_, 添加调试启动项配置:

    ```
    {
        "version": "0.2.0",
        "configurations": [
            {
                "type": "java",
                "name": "java tmpl dev",
                "request": "launch",
                "mainClass": "java_tmpl.App",
                "projectName": "java_tmpl",
                "javaExec": "${workspaceFolder}/env/jdk/bin/java.exe",
                "cwd": "${workspaceFolder}/src/java_tmpl",
                "args": "--spring.profiles.active=dev"
            }
        ]
    }

    ```

8. 从 maven 插件使用 compile 来进行依赖下载并编译开发所需文件, 进行开发

9. 使用 `docker pull ubuntu:22.04` 拉取基础的 ubuntu 镜像用于创建部署镜像, 在 **_./proj_tmpl_server/prod/depl_** 目录下建立 **_proj_** 目录, 放入脚本和配置文件:

    - Dockerfile
    - launch.sh<br><br>

    调整脚本和配置文件中的参数, 使之符合项目

10. 从 http://www.codebaoku.com/jdk/jdk-index.html 下载 jdk 17 for linux, 使用 `tar -zxvf` 解压到 **_./proj_tmpl_server/prod/depl/proj/jdk_**

11. 确认 **_./proj_tmpl_server/prod/data/proj_** 目录被创建

12. 在本地 **_.\proj_tmpl_local\dev_** 目录下建立 **_putty_** 目录, 放入 **plink.exe**

13. 在 vscode 中重新启动 shell 确保环境被正确设置<br>
    使用 `vm start` 启动 linux 虚拟机<br>
    使用 `depl server full` 打包 java 项目, 上传至 linux, 并执行镜像构建脚本, 最后创建容器并运行
