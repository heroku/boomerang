{spawn, exec} = require 'child_process'

s3 = require('s3')

runCommand = (name, args) ->
  proc =           spawn name, args
  proc.stderr.on   'data', (buffer) -> console.log buffer.toString()
  proc.stdout.on   'data', (buffer) -> console.log buffer.toString()
  proc.on          'exit', (status) -> process.exit(1) if status != 0

uploadFile = (localFile, remoteFile, client) ->
  uploader = client.upload(localFile, remoteFile)

  uploader.on 'error', (err) ->
    console.error 'unable to upload:', err.stack
    process.exit(1)

  uploader.on 'progress', () ->
    console.log "uploading #{localFile}"

  uploader.on 'end', ->
    console.log 'done'
    process.exit(0)

task 'cut', 'Build and sync static files with S3', ->
  unless process.env.S3_KEY and process.env.S3_SECRET and process.env.S3_BUCKET
    console.error('! Set S3_KEY S3_SECRET and S3_BUCKET in your environment')
    process.exit(1)

  client = s3.createClient(
    key: process.env.S3_KEY
    secret: process.env.S3_SECRET
    bucket: 'assets.heroku.com'
  )

  runCommand 'stylus', ['--include', 'src', '--out', 'lib']
  runCommand 'coffee', ['-c', '-o', 'lib', 'src']

  uploadFile('lib/boomerang.css', 'boomerang/boomerang.css', client)
  uploadFile('lib/boomerang.js', 'boomerang/boomerang.js', client)

task 'dev', 'Watch source files and build JS & CSS', (options) ->
  runCommand 'http-server'
  runCommand 'stylus', ['--watch', 'src', '--out', 'lib']
  runCommand 'coffee', ['-cw', '-o', 'lib', 'src']

task 'test', 'Run the tests', (options) ->
  runCommand 'casperjs', ['test', 'test/', '--coffee']
