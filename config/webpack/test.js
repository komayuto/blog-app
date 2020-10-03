process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment.js')

module.exports = environment.toWebpackConfig()
