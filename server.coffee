express = require 'express'
errorhandler = require 'errorhandler'
path = require 'path'
http = require 'http'
stylusCompiler = require './server/route_handlers/stylus_compiler'


app = express()
server = http.createServer(app)

# Defaults
app.set('port', process.env.PORT || 8888)
app.set('views', __dirname + '/server/views')
app.set('view engine', 'hbs')


# Mock API 
require('./fixtures/')(app)


# Load static files out of the 'client' directory in dev
app.use('/', express['static'](path.join(__dirname, './', 'client')))
    
# Stylus compiler
app.get('/styles/:filename', stylusCompiler)

# Root route, render the app
app.get('/', (req, res) ->
  res.render('index', { 
    title: 'React Example'
  })
)

app.use(errorhandler())



# Start the App
server.listen(app.get('port'), ->
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