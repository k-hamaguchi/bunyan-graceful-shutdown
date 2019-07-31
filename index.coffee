###
Exit before write log
$ yarn start
yarn run v1.17.3
$ : > my.log && coffee index.coffee && tail -n 1 my.log
error Command failed with exit code 130.
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.

Exit after write log
$ GRACEFUL=1 yarn start
yarn run v1.17.3
$ : > my.log && coffee index.coffee && tail -n 1 my.log
Start gracefull stop.
{"name":"node-bunyan","hostname":"BEPC-0981","pid":7781,"level":30,"number":1000,"msg":"hello world","time":"2019-07-31T08:06:20.876Z","v":0}
Done in 0.24s.
###
bunyan = require 'bunyan'
logger = bunyan.createLogger
  name: 'node-bunyan'
  streams: [
    {
      path: './my.log'
    }
  ]
[1..1000].forEach (n) =>
  logger.info number: n, 'hello world'

if process.env.GRACEFUL?
  process.on 'SIGINT', =>
    console.log 'Start gracefull stop.'
    logger.streams[0].stream.end =>
      process.exit 0

process.kill process.pid, 'SIGINT'
