# Common Settings for VSCode

1. 初次启动 vscode 安装简体中文插件:

    - Chinese (Simplified) (简体中文) Language Pack for Visual Studio Code<br><br>

2. **"ctrl + shift + p"** 输入 **"Configure Display Language"** 选择 **"中文(简体)"**

3. 选择 **文件 -> 首选项 -> 键盘快捷方式 -> 切换至 json 编辑模式**, 使用以下配置:

    ```
    [
        {
            "key": "ctrl+d ctrl+z",
            "command": "editor.unfoldAll",
            "when": "editorTextFocus && foldingEnabled"
        },
        {
            "key": "ctrl+d ctrl+v",
            "command": "editor.action.removeCommentLine",
            "when": "editorTextFocus && !editorReadonly"
        },
        {
            "key": "ctrl+d ctrl+b",
            "command": "workbench.action.navigateBack"
        },
        {
            "key": "ctrl+d ctrl+r",
            "command": "editor.action.referenceSearch.trigger"
        },
        {
            "key": "ctrl+d ctrl+f",
            "command": "editor.action.formatDocument",
            "when": "editorHasDocumentFormattingProvider && editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly"
        },
        {
            "key": "ctrl+d ctrl+c",
            "command": "editor.action.addCommentLine",
            "when": "editorTextFocus && !editorReadonly"
        },
        {
            "key": "ctrl+d ctrl+g",
            "command": "editor.action.goToImplementation",
            "when": "editorHasImplementationProvider && editorTextFocus && !isInEmbeddedEditor"
        },
        {
            "key": "ctrl+d ctrl+x",
            "command": "editor.foldAll",
            "when": "editorTextFocus && foldingEnabled"
        }
    ]
    ```

4. 安装以下插件:

    - Project Manager
    - Git Graph
    - XML
    - Prettier - Code formatter
    - ESLint
    - Python
    - Pylance
    - Flake8
    - Remote - SSH
    - Remote - SSH: Editing Configuration Files
    - Remote Explorer
    - Debugger for Java
    - Maven for Java
    - Language Support for Java(TM) by Red Hat
    - SQLTools
    - SQLTools MySQL/MariaDB/TiDB<br><br>

    _注意某些插件可能属于一个插件包,需要卸载多余插件_

5. 选择 **文件 -> 首选项 -> 设置 -> 用户 -> 切换至 json 编辑模式**, 使用以下配置:

    ```
    {
        // vscode
        "editor.fontFamily": "Fira Code, 'Courier New', monospace",
        "editor.fontSize": 14,
        "workbench.sideBar.location": "right",
        "workbench.tree.indent": 16,
        "workbench.view.alwaysShowHeaderActions": true,
        "debug.console.fontSize": 14,
        "debug.console.fontFamily": "Fira Code, 'Courier New',  monospace",
        "editor.renderWhitespace": "all",
        "editor.rulers": [80, 120],
        "editor.renderControlCharacters": true,
        "debug.allowBreakpointsEverywhere": true,
        "extensions.ignoreRecommendations": true,
        "editor.links": false,

        // xml
        "xml.format.maxLineWidth": 120,
        "xml.server.workDir": "C:\\Users\\~\\project\\env_common\\cache\\.lemminx",

        // git graph
        "git.path": "C:\\Users\\~\\project\\env_common\\PortableGit\\bin\\git.exe",
        "git-graph.integratedTerminalShell": "C:\\Users\\~\\project\\env_common\\PortableGit\\bin\\bash.exe",

        // debugger for java
        "java.compile.nullAnalysis.mode": "automatic",
        "java.inlayHints.parameterNames.enabled": "none",
        "java.configuration.updateBuildConfiguration": "interactive",

        // maven for java
        "maven.showInExplorerContextMenu": false,
        "maven.executable.path": "C:\\Users\\~\\project\\env_common\\maven\\bin\\mvn",

        // language support for java by red hat
        "redhat.telemetry.enabled": false,

        // prettier
        "json.format.enable": false,
        "html.format.enable": false,
        "prettier.singleQuote": true,
        "prettier.jsxSingleQuote": true,
        "prettier.tabWidth": 4,
        "prettier.printWidth": 120,
        "javascript.suggestionActions.enabled": false,
        "javascript.format.enable": false,
        "css.format.enable": false,
        "[less]": {
            "editor.defaultFormatter": "esbenp.prettier-vscode"
        },

        // eslint
        "eslint.validate": ["javascript", "javascriptreact", "jsx", "html"],

        // python
        "python.analysis.diagnosticSeverityOverrides": {
            "reportShadowedImports": "information"
        },
        "python.formatting.yapfArgs": ["--style", "{based_on_style: yapf, indent_width: 4, column_limit: 120}"],
        "python.linting.flake8CategorySeverity.E": "Warning",
        "python.linting.flake8Args": ["--indent-size=4", "--max-line-length=120"],

        // sqltools
        "sqltools.format": {
            "language": "sql",
            "linesBetweenQueries": 2,
            "reservedWordCase": "upper"
        },
        "sqltools.highlightQuery": false,
        "sqltools.autoOpenSessionFiles": false,

        // remote - ssh
        "remote.SSH.configFile": "C:\\Users\\~\\project\\env_common\\ssh\\vscode_ssh_config",
        "files.associations": {
            "vscode_ssh_config": "ssh_config"
        }
    }
    ```

6. 从 https://git-scm.com/download/win 下载 64-bit git for windows portable 安装包, 解压到 **_C:\Users\\~\project\env_common\PortableGit_**

7. 需要为 git 添加代理快速访问 git hub:

    ```
    git config --global http.proxy 127.0.0.1:0
    git config --global https.proxy 127.0.0.1:0
    git config --local http.proxy 127.0.0.1:0
    git config --local https.proxy 127.0.0.1:0
    ```
