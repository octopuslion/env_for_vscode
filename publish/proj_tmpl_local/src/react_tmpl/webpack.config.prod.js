const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CssMinimizerWebpackPlugin = require('css-minimizer-webpack-plugin');
const TerserWebpackPlugin = require('terser-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');

const outputName = 'react_tmpl';
module.exports = {
    mode: 'production', // development or production.
    entry: path.join(__dirname, './app/main.jsx'), // package entry file.
    // devtool: 'source-map',
    output: {
        filename: outputName + '.js', // package output name.
        path: path.join(__dirname, './dist'),
        clean: true,
        publicPath: '',
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
                    {
                        loader: MiniCssExtractPlugin.loader,
                        options: {
                            publicPath: './',
                        },
                    },
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
                    filename: 'res/[name][hash][ext]', // output to single file.
                },
            },
        ],
    },
    optimization: {
        minimizer: [
            // css compress.
            new CssMinimizerWebpackPlugin({ parallel: true }),
            // js compress.
            new TerserWebpackPlugin({
                test: /\.js(\?.*)?$/i,
                parallel: true,
                terserOptions: {
                    toplevel: true, // top level to remove all unused code.
                },
            }),
        ],
    },
    plugins: [
        // plugin for split to single css file.
        new MiniCssExtractPlugin({
            filename: outputName + '.css',
        }),
        // plugin for template html.
        new HtmlWebpackPlugin({
            templateParameters: () => {
                return {
                    title: outputName,
                };
            },
            minify: {
                // compress html.
                removeAttributeQuotes: true, // remove quots of attributes.
                removeComments: true, // remove comments.
                collapseWhitespace: false, // remove whitespace.
                minifyCSS: true, // compress inline css.
            },
            inject: 'body', // body or head.
            hash: true, // add a hash with js.
            filname: outputName + '.html', // output file name.
            template: './index.prod.html', // template html file.
        }),
    ],
};
