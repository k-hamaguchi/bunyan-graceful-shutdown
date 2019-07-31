# Shutdown node-bunyan gracefully

## Exit before write log

```bash
[bunyan-graceful-shutdown]$ yarn start 2>/dev/null
yarn run v1.17.3
$ : > my.log && coffee index.coffee && tail -n 1 my.log
error Command failed with exit code 130.
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.
```

## Exit after write log

```bash
[bunyan-graceful-shutdown]$ GRACEFUL=1 yarn start 2>/dev/null
yarn run v1.17.3
$ : > my.log && coffee index.coffee && tail -n 1 my.log
Start graceful shutdown.
{"name":"node-bunyan","hostname":"localhost","pid":9064,"level":30,"number":1000,"msg":"hello world","time":"2019-07-31T08:27:32.826Z","v":0}
Done in 0.27s.
```
