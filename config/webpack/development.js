process.env.NODE_ENV = process.env.NODE_ENV || 'development'
process.env.HOST = process.env.HOST || 'https://c492-2001-8003-230d-fb01-40ee-b6a3-1701-ed6e.ngrok.io'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()
