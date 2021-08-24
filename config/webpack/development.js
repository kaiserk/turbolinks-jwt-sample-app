process.env.NODE_ENV = process.env.NODE_ENV || 'development'
process.env.HOST = process.env.HOST || 'https://512afbc47b5b.ngrok.io'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()
