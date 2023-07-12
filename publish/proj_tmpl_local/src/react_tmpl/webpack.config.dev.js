const path = require('path');

module.exports = {
    mode: 'development', // development or production.
    entry: path.join(__dirname, './app/main_dev.jsx'), // package entry file.
    devtool: 'eval-source-map',
    output: {
        filename: 'dev.js', // package output name inmemory.
    },
    module: {
        rules: [
            {
                // rule for using babel to support high verion of ES.
                test: /\.jsx$/i,
                exclude: /node_modules/,
                use: [
                    {
                        loader: 'babel-loader',
                        options: {
                            presets: ['@babel/preset-env', '@babel/preset-react'],
                        },
                    },
                ],
            },
            {
                // rule for supporting less with module in .jsx.
                test: /\.less$/i,
                exclude: /node_modules/,
                use: [
                    'style-loader',
                    {
                        loader: 'css-loader',
                        options: {
                            modules: {
                                auto: true,
                                localIdentName: '[path][name]-[local]-[hash:base64:8]',
                            },
                        },
                    },
                    'less-loader',
                ],
            },
            {
                // rule for supporting static file.
                test: /\.(png|jpe?g|gif|svg|eot|ttf|woff|woff2)$/i,
                exclude: /node_modules/,
                type: 'asset',
                parser: {
                    dataUrlCondition: {
                        maxSize: 4 * 1024, // max file size to inline.
                    },
                },
                generator: {
                    filename: '[path][name][hash][ext]', // output to single file.
                },
            },
        ],
    },
    devServer: {
        // options for webpack-dev-server.
        static: {
            directory: path.join(__dirname, '/'),
        },
        port: 8081,
        hot: true,
    },
};
