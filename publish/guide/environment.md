# Environment Settings for VSCode

1. 建立项目开发所需目录层次结构, 参考 **_.\proj_tmpl_local_** :

    | 主目录    | 次目录  |
    | :-------- | :------ |
    | proj_tmpl | --      |
    |           | .vscode |
    |           | env     |
    |           | src     |
    |           | depl    |
    |           | doc     |

2. 在 **_.\proj_tmpl_local\env_** 下放入 shell 脚本:

    - env.bat
    - vm.bat
    - mvn.bat<br><br>

    在 **_.\proj_tmpl_local\depl_** 下放入 shell 脚本:

    - depl.bat<br><br>

    _注意 ***env.bat*** 和 ***depl.bat*** 是必要脚本, 其他脚本根据项目类型调整_

3. 调整各脚本中的 **options** 参数值, 使之符合项目, 尽量确保路径参数不带有空格等特殊符号以避免可能的脚本参数传递错误

4. 在 **_.\\.vscode_** 下建立 **_settings.json_** 文件, 添加配置:

    ```
    // vscode
    "terminal.integrated.defaultProfile.windows": "Command Prompt",
    "terminal.integrated.profiles.windows": {
        "Command Prompt": {
            "path": ["${env:windir}\\Sysnative\\cmd.exe", "${env:windir}\\System32\\cmd.exe"],
            "args": ["/k", "${workspaceFolder}\\env\\env.bat", "-import"],
            "icon": "terminal-cmd"
        }
    },
    ```

    选择 **终端 -> 新建终端** 确认脚本被正确加载到 vscode 的 shell 中

5. 在 linux 中建立项目开发和发布所需目录层次结构, 参考 **_.\proj_tmpl_server_** :
   | 主目录 | 次目录 1 |次目录 2 |
   | :-------- | :------ |:-|
   | proj_tmpl | -- ||
   | | ~~.vscode~~ ||
   | | dev |--|
   | | |env|
   | | |src|
   | | |depl|
   | | |data|
   | | prod |--|
   | | |depl|
   | | |data|
