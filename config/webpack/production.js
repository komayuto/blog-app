process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment.js')

module.exports = environment.toWebpackConfig()
