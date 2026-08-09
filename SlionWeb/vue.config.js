/* eslint-disable @typescript-eslint/no-unused-vars */

/**
 * @description vue.config.js全局配置
 */

const {
    baseURL,
    title,
    devPort,
    assetsDir,
    outputDir,
    lintOnSave,
    publicPath,
    transpileDependencies,
} = require('./src/config')
const dayjs = require('dayjs')
const pkg = require('./package.json')

const { resolve, relative } = require('path')
const { defineConfig } = require('@vue/cli-service')
const {
    createVuePlugin,
    createChainWebpack,
} = require('./library/build/index.ts')

const pc = require('picocolors')

const info = {
    ...pkg,
    lastBuildTime: dayjs().format('YYYY-MM-DD HH:mm:ss'),
}

process.env.VUE_APP_TITLE = title
process.env.VUE_APP_AUTHOR = pkg.author
process.env.VUE_APP_INFO = JSON.stringify(info)
process.env.VUE_APP_UPDATE_TIME = info.lastBuildTime
process.env.VUE_APP_GITHUB_USER_NAME = process.env.VUE_GITHUB_USER_NAME
process.env.VUE_APP_RANDOM = `${info.lastBuildTime}-${process.env.VUE_GITHUB_USER_NAME}`

module.exports = defineConfig({
    publicPath,
    assetsDir,
    outputDir,
    lintOnSave,
    transpileDependencies,
    parallel: true, // 启用多进程处理
    devServer: {
        compress: true,
        client: {
            progress: false,
            overlay: {
                warnings: false,
                errors: true,
            },
        },
        hot: true,
        port: devPort,
        // 使用代理时关闭 mock 中间件，避免与 /dev-api|/prod-api 冲突
        // setupMiddlewares: require('./mock'),
        proxy: {
            '/dev-api': {
                target: 'http://localhost:8080',
                ws: true,
                changeOrigin: true,
                pathRewrite: {
                    '^/dev-api': '',
                },
            },
            '/prod-api': {
                target: 'http://localhost:8080',
                ws: true,
                changeOrigin: true,
                pathRewrite: {
                    '^/prod-api': '',
                },
            },
        },
    },
    pwa: {
        workboxOptions: {
            skipWaiting: true,
            clientsClaim: true,
        },
        themeColor: '#ffffff',
        msTileColor: '#ffffff',
        appleMobileWebAppCapable: 'yes',
        appleMobileWebAppStatusBarStyle: 'black',
        manifestOptions: {
            name: 'Vue Admin Better - Admin Plus',
            short_name: 'Admin Plus',
            background_color: '#ffffff',
        },
    },
    configureWebpack() {
        // cnpm / npminstall 会在 node_modules 下生成大量嵌套软链；Webpack5 的 filesystem 缓存在
        // 增量编译时遍历软链上下文可能触发 FileSystemInfo 中 hashes 数组溢出（RangeError）。
        // 开发环境关闭持久化缓存可避免该问题；生产构建仍使用 filesystem 以提速。
        const useFilesystemCache = process.env.NODE_ENV === 'production'
        return {
            cache: useFilesystemCache
                ? {
                      type: 'filesystem',
                      buildDependencies: {
                          config: [__filename],
                      },
                      version: pkg.version, // 添加版本号，版本变更时自动刷新缓存
                  }
                : false,
            resolve: {
                // 避免跟随 cnpm 软链链路过深，减轻 FileSystemInfo 对 symlink 上下文的爆炸式展开
                symlinks: false,
                alias: {
                    '~': resolve(__dirname, '.'),
                    '@': resolve(__dirname, 'src'),
                    '/#': resolve(__dirname, 'types'),
                    '@vab': resolve(__dirname, 'library'),
                    '@gp': resolve('library/plugins/vab'),
                },
                fallback: {
                    fs: false,
                    path: require.resolve('path-browserify'),
                },
            },
            plugins: createVuePlugin(),
            performance: {
                hints: false,
            },
        }
    },
    chainWebpack(config) {
        //为了防止忘记配置而造成项目无法打包，请保留以下提示
        if (
            process.env.NODE_ENV === 'production' &&
            (process['env'].VUE_GITHUB_USER_NAME === 'test' ||
                process['env'].VUE_APP_SECRET_KEY === 'preview')
        ) {
            console.log(
                `\n\n${pc.red(
                    '检测到您的用户名或key未配置，key在购买时通过邮件邀请函发放，如您已购买请仔细阅读文档并进行配置，配置完成后方可打包使用。购买地址：https://vuejs-core.cn/authorization'
                )}\n`
            )
            // 必须非 0，否则 Docker 会认为构建成功但 dist 不存在
            process.exit(1)
        }

        // 优化构建速度
        config.module.rule('vue').use('thread-loader').loader('thread-loader')

        // 优化构建速度，跳过node_modules中已编译的文件
        config.module
            .rule('js')
            .exclude.add(/node_modules\/core-js/)
            .end()

        createChainWebpack(process.env.NODE_ENV, config)
    },
    runtimeCompiler: false,
    productionSourceMap: false,
    css: {
        sourceMap: false,
        extract:
            process.env.NODE_ENV === 'production'
                ? {
                      ignoreOrder: true,
                  }
                : false,
        loaderOptions: {
            sass: {
                sassOptions: { outputStyle: 'expanded' },
                additionalData(content, { rootContext, resourcePath }) {
                    const relativePath = relative(rootContext, resourcePath)
                    if (
                        relativePath.replace(/\\/g, '/') !==
                        'library/styles/variables/variables.module.scss'
                    )
                        return `@use "~@vab/styles/variables/variables.module.scss" as *;${content}`
                    return content
                },
            },
        },
    },
})
