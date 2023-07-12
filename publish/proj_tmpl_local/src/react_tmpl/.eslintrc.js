module.exports = {
    env: {
        browser: true, // 启用浏览器环境.
        es2021: true, // 使用 ES2021 版本的特性.
        commonjs: true, // 启用 CommonJS 模块规范.
        node: true, // 启用 node 模块规范.
    },
    extends: [
        'eslint:recommended', // 使用 eslint 推荐的基本规则.
        'plugin:react/recommended', // 使用 react 插件推荐的规则.
        'plugin:prettier/recommended', // 使用 prettier 插件推荐的规则.
    ],
    parserOptions: {
        ecmaVersion: 'latest', // 使用最新的 ECMAScript 版本.
        sourceType: 'module', // 使用模块化的文件结构.
        ecmaFeatures: {
            jsx: true, // 启用 jxs 的支持.
        },
    },
    plugins: ['react', 'prettier', 'html'], // 启用插件.
    rules: {
        'prettier/prettier': 'error', // eslint 包含 prettier 的错误.
        'arrow-body-style': 'off', // prettier 导致冲突的特殊规则.
        'prefer-arrow-callback': 'off', // prettier 导致冲突的特殊规则.
        quotes: ['error', 'single'], // 强制使用单引号
    },
};
