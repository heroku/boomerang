![http://cl.ly/image/3k1t463x2e0u](http://cl.ly/image/3k1t463x2e0u/content#.png)

Boomerang is a Javascript widget that Heroku Addon Providers embed on their 
single-sign-on pages, giving customers a boomerang back to the Heroku website.
It has no dependencies, a small footprint, and it works over SSL.

## Basic Usage

Drop this snippet on your page and you're good to go.

```js
<script src="https://s3.amazonaws.com/assets.heroku.com/boomerang/boomerang.js"></script>
```

## Advanced Usage

You can prevent Boomerang from automatically displaying by giving your `<body>` 
element a class of `no-boomerang`. This will allow you to instantiate a boomerang object 
manually:

```html
<head>
  <script src="https://s3.amazonaws.com/assets.heroku.com/boomerang/boomerang.js"></script>
  <script>
    document.addEventListener('DOMContentLoaded', function(){
      window.boomerang = new Boomerang({
        addon: 'foo', app: 'bar'
      });
    });
  </script>
</head>

<body class='no-boomerang'></body>
```

## Development

You'll need [node](http://nodejs.org/download/) to hack on this.

```bash
[sudo] npm install -g stylus coffee-script http-server s3
brew install casperjs
cp .env{.sample,}
```

```bash
foreman run cake cut    # Build and sync static files with S3
cake dev                # runs an http server and auto-compiles code changes
cake test               # runs casperjs test suite
```
