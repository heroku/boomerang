![http://cl.ly/image/3k1t463x2e0u](http://cl.ly/image/3k1t463x2e0u/content#.png)

Hook is a Javascript widget that Heroku Addon Providers embed on their 
single sign-on pages, giving customers a hook back to the Heroku website.
It has no dependencies, a small footprint, and it works over SSL.

## Basic Usage

Drop this snippet on your page and you're good to go.

```js
<script src="https://s3.amazonaws.com/assets.heroku.com/hook/hook.js"></script>
```

## Advanced Usage

You can prevent Hook from automatically displaying by giving your `<body>` 
element a class of `no-hook`. This will allow you to instantiate a hook object 
manually:

```html
<head>
  <script src="https://s3.amazonaws.com/assets.heroku.com/hook/hook.js"></script>
  <script>
    document.addEventListener('DOMContentLoaded', function(){
      window.hook = new Hook({
        addon: 'foo', app: 'bar'
      });
    });
  </script>
</head>

<body class='no-hook'></body>
```

## Demoing Locally

Hook won't work over the `file://` protocol, so you need to serve
it over HTTP. If you're on a Mac or Linux, fire up a python 
SimpleHTTPServer and visit 
[localhost:8000/demo.html](http://localhost:8000/demo.html) 
in your browser.

```bash
python -m SimpleHTTPServer
```

## Development

CoffeeScript includes a simple build system similar to Make and Rake. Naturally, it's called Cake, and is used for the tasks that build and test the CoffeeScript language itself. If you don't already have node and the coffee-script module installed, you'll need them:

```bash
open http://nodejs.org/download/
npm install -g coffee-script
cake assets:watch
```

Testing is done with [CasperJS](http://casperjs.org/):

```bash
brew install casperjs         # Install casperjs (on OS X)
casperjs test test/ --coffee  # Run all .coffee tests in the /test directory
```