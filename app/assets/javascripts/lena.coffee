throw new Error('Lena has already been loaded!') if window.lena != undefined

# Global settings for Leña read from the script element that loaded this.
Settings = do ->
  elements = document.getElementsByTagName 'script'
  read = (attribute) ->
    attributes = (el.getAttribute(attribute) for el in elements)
    attributes = (attribute for attribute in attributes when attribute)
    attributes[0]
  destination: read('data-lena-destination')
  submitURL: read('data-lena-remote-url')

# The handlers for each type of logging.
# These take an object with the following properties:
#   message: The error message
#   stacktrace: The stack trace that led to the error (could be null)
handlers =
  remote: (data) ->
    query = for key, value of data when value
      "#{key}=#{encodeURIComponent(value)}"
    img = new Image()
    img.src = "#{Settings.submitURL}?#{query.join('&')}"

  local: (data) ->
    message = data.message
    message = "#{message}\n#{data.stacktrace}" if data.stacktrace

    if console?.warn
      console.warn(message)
    else if console?.log
      console.log(message)

# The main Leña handler. All user calls go through here. The final
# data is aggregated before it is dispatched to one of the handlers.
lena = (message, stacktrace, destinations=[]) ->
  if stacktrace == undefined
    try
      throw new Error('')
    catch e
      stacktrace = e.stack
    try
      stacktrace = stacktrace.split("\n")[2..].join("\n")
    try
      stacktrace ||= 'unsupported'

  data =
    message: message
    stacktrace: stacktrace

  handlers[d](data) for d in destinations

# Log a message via Leña. This uses the configuration values to determine
# where the message should be sent (remote/local/both).
lena.log = (message, stacktrace) ->
  destinations = []
  switch Settings.destination
    when 'local' then destinations = ['local']
    when 'remote' then destinations = ['remote']
    when 'all' then destinations = ['local', 'remote']
    else destinations = ['local', 'remote']
  lena(message, stacktrace, destinations)

# Log a message via Leña. Only logs remote (server).
lena.remote = (message, stacktrace) ->
  lena(message, stacktrace, ['remote'])

# Log a message via Leña. Only logs to local (browser).
lena.local = (message, stacktrace) ->
  lena(message, stacktrace, ['local'])

window.lena = lena
window.lena.onerror = window.onerror
window.onerror = (exception, url, linenum) ->
  lena.log("#{exception}\nResource: #{url}:#{linenum}", null)
  if lena.onerror then lena.onerror() else true
