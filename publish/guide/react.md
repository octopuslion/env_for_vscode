# Development for React with LESS in VSCode

1. 从 https://nodejs.org/en/download 下载 Windows Binary (.zip) (64-bit) 的安装包, 解压到 **_.\proj_tmpl_local\env\node_**

2. 在项目 **_.\proj_tmpl_local\src_** 目录下建立基于 webpack 结构的 react 目录, 参考 **_.\proj_tmpl_local\src\react_tmpl_**

3. 在 vscode 中重新启动 shell 确保环境被正确设置, 从 https://developer.aliyun.com/mirror/npm 获取配置 npm 源为阿里镜像的方式<br>
   使用 `npm --location=global config set registry https://registry.npmmirror.com` 替换源为阿里镜像<br>
   在目录 **_.\proj_tmpl_local\src\react_tmpl_** 下使用 `npm install --save-dev` 安装依赖

4. 执行 project.dev.bat 脚本开启开发环境调试, 浏览器打开 http://127.0.0.1:8081/index.dev.html 进行调试

5. 使用 `depl local react` 打包 react 项目, 或者<br>
   使用 `depl server full` 配合 java 项目进行完全打包, 上传至 linux, 并执行镜像构建脚本, 最后创建容器并运行

6. 浏览器打开 http://\*.\*.\*.\*:8080/web/index.html 进行验证, 相关配置需在 java 项目中进行设置
