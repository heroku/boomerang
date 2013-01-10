{spawn, exec} = require 'child_process'

runCommand = (name, args) ->
  proc =           spawn name, args
  proc.stderr.on   'data', (buffer) -> console.log buffer.toString()
  proc.stdout.on   'data', (buffer) -> console.log buffer.toString()
  proc.on          'exit', (status) -> process.exit(1) if status != 0

task 'dev', 'Watch source files and build JS & CSS', (options) ->
  runCommand 'http-server'
  runCommand 'stylus', ['--watch', 'src', '--out', 'lib']
  runCommand 'coffee', ['-cw', '-o', 'lib', 'src']

task 'test', 'Run the tests', (options) ->
  runCommand 'casperjs', ['test', 'test/', '--coffee']
