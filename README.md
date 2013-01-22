![http://cl.ly/image/3k1t463x2e0u](http://cl.ly/image/3k1t463x2e0u/content#.png)

Boomerang is a Javascript widget that Heroku Addon Providers embed on their 
single-sign-on pages, giving customers a boomerang back to the Heroku website.
It has no dependencies, a small footprint, and it works over SSL.

## Basic Usage

Drop this snippet on your page and you're good to go.

```html
<script src="https://s3.amazonaws.com/assets.heroku.com/boomerang/boomerang.js"></script>
<script>
  document.addEventListener("DOMContentLoaded", function() {
    Boomerang.init({app: 'foo', addon: 'bar'});
  });
</script>
```

If you're an existing addon provider using the old Heroku SSO header, you can try out 
Boomerang in your browser's JavaScript console:

```js
document.querySelector('#heroku-header').style.display = 'none';
document.querySelector('#heroku-subheader').style.display = 'none';
var s = document.createElement('script');
s.src = 'https://s3.amazonaws.com/assets.heroku.com/boomerang/boomerang.js';
document.querySelector('body').appendChild(s);
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
npm install
brew install casperjs
cp .env{.sample,}
```

```bash
foreman run cake cut    # Build and sync static files with S3
cake dev                # runs an http server and auto-compiles code changes
cake test               # runs casperjs test suite
```
