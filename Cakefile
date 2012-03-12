fs            = require 'fs'
{print}       = require 'util'
{spawn, exec} = require 'child_process'

# ANSI Terminal Colors
bold = '\033[0;1m'
green = '\033[0;32m'
reset = '\033[0m'
red = '\033[0;31m'

log = (message, color, explanation) ->
  console.log color + message + reset + ' ' + (explanation or '')

runCmd = (cmd, options, callback) ->
  obj = spawn cmd, options
  obj.stdout.on 'data', (data) -> print data.toString()
  obj.stderr.on 'data', (data) -> log data.toString(), red
  obj.on 'exit', (status) -> callback?() if status is 0

build = (watch, callback) ->
  if typeof watch is 'function'
    callback = watch
    watch = false
  options = ['-c', '-b', '-o', 'lib', 'src']
  options.unshift '-w' if watch
  runCmd 'coffee', options, callback

spec = (callback) ->
  options = []
  runCmd 'mocha', options, callback

task 'docs', 'Generate annotated source code with Docco', ->
  fs.readdir 'src', (err, contents) ->
    files = ("src/#{file}" for file in contents when /\.coffee$/.test file)
    runCmd 'docco', files

task 'build', 'build source files', ->
  build -> log ":)", green

task 'watch', 'watch and build source files', ->
  build true, -> log ":)", green

task 'spec', 'run tests', ->
  build -> spec -> log ":)", green
