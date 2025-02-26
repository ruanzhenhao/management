const { defineConfig } = require('@vue/cli-service');

module.exports = defineConfig({
  transpileDependencies: true,
  devServer: {
    port: 7070,
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
        pathRewrite: { '^/api': '' }, // 可选，用于重写路径
        secure: false, // 允许自签名的 SSL 证书
        logLevel: 'debug' // 打印调试信息，帮助排查问题
      }
    }
  }
});
