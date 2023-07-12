# Development for Python in VSCode

## Windows

1. _(配置一次即可)_ Windows 10 在设置中搜索 **应用执行别名** 关掉 **应用程序安装 python.exe** 和 **应用程序安装 python3.exe**

2. 从 https://www.python.org/downloads/windows 下载 Windows embeddable package (64-bit) 的安装包, 解压到 **_.\proj_tmpl_local\env\python_**

3. 配置 pip:

    - 在 **\_.\proj_tmpl_local\env\python\python[x].\_pth\_\_** 中取消 **import site** 注释, **_[x]_** 为 python 版本号
    - 从 https://bootstrap.pypa.io/get-pip.py 下载或拷贝 **_get-pip.py_** 到 **_.\proj_tmpl_local\env\python_** 目录下保存为 **_get-pip.py_**
    - 在 vscode 中重新启动 shell 确保环境被正确设置<br>
      使用 `python .\proj_tmpl_local\env\python\get-pip.py` 安装 pip
    - _(配置一次即可)_ , 从 https://developer.aliyun.com/mirror/pypi 获取配置 pip 源为阿里镜像的方式<br>
      使用 `pip config set global.index-url https://mirrors.aliyun.com/pypi/simple` 替换源为阿里镜像<br>
      使用
      `pip config set install.trusted-host mirrors.aliyun.com` 为此镜像地址添加授信<br><br>

4. 在 vscode 中重新启动 shell 确保环境被正确设置, 安装以下必要包:

    - 使用 `pip install yapf` 安装代码格式化包
    - 使用 `pip install flake8` 安装代码提示包<br><br>

5. 在 **_.\proj_tmpl_local\env\python_** 目录下放入 **_custom.pth_** 文件, 在 vscode 插件目录 **_C:\Users\\~\\.vscode\extensions_** 中找到 **Flake8** 的插件目录 **_ms-python.flake8-2023.6.0_** , 将此目录下的 **_bundled\tool_** 目录更新至 **_custom.pth_** 文件中

6. 在 **_.\\.vscode\settings.json_** 中添加以下针对 python 的配置:

    ```
    // python
    "python.formatting.provider": "yapf",
    "python.formatting.yapfPath": "${workspaceFolder}\\env\\python\\Scripts\\yapf.exe",
    "python.linting.flake8Enabled": true,
    "python.linting.flake8Path": "${workspaceFolder}\\env\\python\\Scripts\\flake8.exe",
    ```

7. 在项目 **_.\proj_tmpl_local\src_** 目录下建立 python 目录, 参考 **_.\proj_tmpl_local\src\python_tmpl_**

8. 在 **_.\\.vscode_** 下建立 **_launch.json_** 文件 _(如果不存在的话)_, 添加调试启动项配置:

    ```
    {
        "version": "0.2.0",
        "configurations": [
            {
                "type": "python",
                "name": "python tmpl",
                "request": "launch",
                "program": "app.py",
                "console": "integratedTerminal",
                "justMyCode": true,
                "cwd": "${workspaceFolder}/src/python_tmpl",
                "env": {
                    "PYTHONPATH": "${workspaceFolder}/src/python_tmpl;${env:PYTHONPATH}"
                }
            }
        ]
    }

    ```

9. 切换至 **_.\proj_tmpl_local\src\python_tmpl\app.py_** 文件从 vscode 右下角 **选择解释器** 指定为 **_.\proj_tmpl_local\env\python_** 目录

## Linux

1. 从 https://github.com/indygreg/python-build-standalone/releases 下载 **cpython** 包, 下载带有 **x86_64-unknown-linux-gnu-pgo+lto-full** 后缀的包, 不要特别使用 v2, v3, v4 版本, 针对不同的
   cpu, 使用 gnu 的 pgo+lto 版本获得最大兼容和最大优化<br>
   使用 `unzstd` 以及 `tar -xf` 解压包至 **_.\proj_tmpl_server\dev\env\python_**

2. 在 **_.\proj_tmpl_server\dev\env_** 下放入脚本 **_cli.sh_** 并运行

3. 配置 pip:

    - _(配置一次即可)_ , 从 https://developer.aliyun.com/mirror/pypi 获取配置 pip 源为阿里镜像的方式<br>
      使用 `pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple` 替换源为阿里镜像<br>
      使用
      `pip3 config set install.trusted-host mirrors.aliyun.com` 为此镜像地址添加授信<br><br>

4. 安装以下必要包:

    - 使用 `pip3 install yapf` 安装代码格式化包
    - 使用 `pip3 install flake8` 安装代码提示包<br><br>

5. 在 vscode 插件中为 linux 安装以下插件:

    - XML
    - Prettier - Code formatter
    - Python
    - Pylance
    - Flake8<br><br>

6. 在 **_./proj_tmpl_server/dev/env/python/install/lib/python3.11/site-packages_** 目录下放入 **_custom.pth_** 文件, 在 vscode 插件目录 **_/home/~/.vscode-server/extensions_** 中找到 **Flake8** 的插件目录 **_ms-python.flake8-2023.6.0_** , 将此目录下的 **_bundled\tool_** 目录更新至 **_custom.pth_** 文件中

7. 在 **_.\\.vscode_** 下建立 **_settings.json_** 文件 _(如果不存在的话)_, 添加以下针对 python 的配置:

    ```
    // python
    "python.formatting.provider": "yapf",
    "python.formatting.yapfPath": "${workspaceFolder}/dev/env/python/install/bin/yapf",
    "python.linting.flake8Enabled": true,
    "python.linting.flake8Path": "${workspaceFolder}/dev/env/python/install/bin/flake8",

    ```

8. 在项目 **_.\proj_tmpl_server\dev\src_** 目录下建立 python 目录, 参考 **_.\proj_tmpl_server\dev\src\python_tmpl_**

9. 在 **_.\\.vscode_** 下建立 **_launch.json_** 文件 _(如果不存在的话)_, 添加调试启动项配置:

    ```
    {
        "version": "0.2.0",
        "configurations": [
            {
                "type": "python",
                "name": "python tmpl",
                "request": "launch",
                "program": "app.py",
                "console": "integratedTerminal",
                "justMyCode": true,
                "cwd": "${workspaceFolder}/src/python_tmpl",
                "env": {
                    "PYTHONPATH": "${workspaceFolder}/src/python_tmpl;${env:PYTHONPATH}"
                }
            }
        ]
    }

    ```

10. 切换至 **_.\proj_tmpl_server\dev\src\python_tmpl\app.py_** 文件从 vscode 右下角 **选择解释器** 指定为 **_.\proj_tmpl_server\dev\env\python\install\bin\python3_**
