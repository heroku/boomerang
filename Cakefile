{spawn, exec} = require 'child_process'

s3 = require('s3')
async = require('async')

runCommand = (name, args, callback=null) ->
  proc =           spawn name, args
  # proc.stderr.on   'data', (buffer) -> console.log buffer.toString()
  # proc.stdout.on   'data', (buffer) -> console.log buffer.toString()
  proc.on          'exit', (status) ->
    if callback?
      callback(null, name)
    else
      process.exit(1) if status != 0

uploadFile = (localFile, remoteFile, callback) ->
  unless process.env.S3_KEY and process.env.S3_SECRET and process.env.S3_BUCKET
    console.error('! Set S3_KEY S3_SECRET and S3_BUCKET in your environment')
    process.exit(1)

  client = s3.createClient(
    key: process.env.S3_KEY
    secret: process.env.S3_SECRET
    bucket: process.env.S3_BUCKET
  )

  # Make file are publicly visible
  headers = {'x-amz-acl': 'public-read'}

  uploader = client.upload(localFile, remoteFile, headers)

  uploader.on 'error', (err) ->
    console.error 'unable to upload:', err.stack
    process.exit(1)

  uploader.on 'end', =>
    callback(null, localFile)

task 'cut', 'Build and sync static files with S3', ->
  async.series
    compile_stylus: (callback) ->
      runCommand('stylus', ['--compress', 'src/boomerang.styl', '--out', 'lib'], callback)
    compress_css: (callback) ->
      runCommand('yuglify', ['--type', 'js', 'lib/boomerang.js'], callback)
    compile_coffee: (callback) ->
      runCommand('coffee', ['-c', '-o', 'lib', 'src'], callback)
    compress_js: (callback) ->
      runCommand('yuglify', ['--type', 'css', 'lib/boomerang.css'], callback)
    upload_css: (callback) ->
      uploadFile('lib/boomerang.min.css', 'boomerang/boomerang.css', callback)
    upload_js: (callback) ->
      uploadFile('lib/boomerang.min.js', 'boomerang/boomerang.js', callback)
  , (err, results) ->
    out = ("✓ #{k.replace('_', ' ')}" for k,v of results).join("\n")
    console.log "\n#{out}\n"

task 'dev', 'Watch source files and build JS & CSS', (options) ->
  runCommand 'http-server'
  runCommand 'stylus', ['--watch', 'src', '--out', 'lib']
  runCommand 'coffee', ['-cw', '-o', 'lib', 'src']

task 'test', 'Run the tests', (options) ->
  runCommand 'casperjs', ['test', 'test/', '--coffee']
