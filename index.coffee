bunyan = require 'bunyan'
logger = bunyan.createLogger
  name: 'node-bunyan'
  streams: [
    {
      # This stream need to wait for closing
      path: './my.log'
    }
    {
      # This stream does not need for waiting
      stream: process.stderr
    }
  ]

[1..1000].forEach (n) ->
  logger.info number: n, 'hello world'

if process.env.GRACEFUL?
  process.on 'SIGINT', ->
    console.log 'Start graceful shutdown.'
    Promise.all logger.streams.map (s) ->
      if s.closeOnExit
        # Need to close
        new Promise (resolve, reject) ->
          s.stream.end resolve
      else
        # No need to close
        Promise.resolve()
    .then ->
      process.exit 0

process.kill process.pid, 'SIGINT'
