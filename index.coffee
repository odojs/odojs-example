path = require 'path'

express = require 'express'
app = express()
compression = require 'compression'
app.use compression()
bodyParser = require 'body-parser'
app.use bodyParser.urlencoded extended: yes
app.use bodyParser.json()
oneDay = 1000 * 60 * 60 * 24
app.use '/dist', express.static path.join(__dirname, 'dist'), maxAge: oneDay
app.use '/public', express.static path.join(__dirname, 'public'), maxAge: oneDay

# app.get '/query', (req, res) ->
#   query = JSON.parse req.query.q
#   ql.exec query, stores, (err, results) ->
#     if err?
#       res.status 400
#       res.json err
#       return
#     res.json results


oneshot = require 'odo-relay/oneshot'

{ component, widget } = require 'odojs'
odoql = require 'odoql/odojs'
component.use odoql
widget.use odoql

exe = require 'odoql-exe'
exe = exe()

app.get '/*', (req, res) ->
  # TODO router not direct to component
  component = require './app/default'
  # TODO params from url
  params = {}
  oneshot exe, component, params, (err, result) ->
    # TODO templating engine
    res.send """
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset=\"utf-8\">
      <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge, chrome=1\" />
      <meta name=\"viewport\" content=\"width=700\">
      <title>Odo.js Examples</title>
      <link rel=\"stylesheet\" href=\"/public/loading.css\" />
      <link rel=\"stylesheet\" href=\"/dist/odojs-examples-1.0.0.min.css\" />
    </head>
    <body>
      <div class=\"loading wrapper\">
        <svg class=\"logo\">
          <use xmlns:xlink=\"http://www.w3.org/1999/xlink\" xlink:href=\"/dist/odojs-examples-1.0.0.min.svg#odojs\"></use>
        </svg>
        <div class=\"timeout\" style=\"display: none;\">
          <h1>Loading too slow, something is wrong</h1>
        </div>
      </div>
      <script src=\"/public/loading.js\"></script>
      <script>
        window.__queries = #{JSON.stringify result.queries};
        window.__state = #{JSON.stringify result.state};
      </script>
      <script src=\"/dist/odojs-examples-1.0.0.min.js\"></script>
    </body>
  </html>
  """

port = 8085
app.listen port

console.log "Odo.js examples are listening on port #{port}..."