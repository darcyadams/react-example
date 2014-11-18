express = require 'express'
errorhandler = require 'errorhandler'
path = require 'path'
http = require 'http'


app = express()
server = http.createServer(app)

# Defaults
app.set('port', process.env.PORT || 8888)
app.set('views', __dirname + '/server/views')
app.set('view engine', 'hbs')


env = app.settings.env

# ------------------- DEVELOPMENT ENVIRONMENT SETTINGS ---------------------------
if env is 'development'

  # Mock API 
  require('./fixtures/')(app)
  
  # Load all static files under the route /assets
  app.use('/client', express['static'](path.join(__dirname, 'client')))

  app.use(errorhandler())



# ------------------- PRODUCTION ENVIRONMENT SETTINGS ---------------------------
if env is 'production'
  
  # Load all static files under the route /build
  app.use('/build', express['static'](path.join(__dirname, 'build')))


  
# Link up the routes
require('./server/routes')(app, server)


# Start the App
server.listen(app.get('port'), () ->
  console.log(
    """
      ████████████████████████████████████████████████████████████████████████████████████████
      Application Started...
      ________________________________________________________________________________________
      
      mode: #{app.settings.env}
      port: #{app.get('port')}

      ████████████████████████████████████████████████████████████████████████████████████████
    """
  )             
)