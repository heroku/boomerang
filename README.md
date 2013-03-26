# Boomerang

## TL;DR

Boomerang is a Javascript widget that Heroku Add-on Providers embed on their
single-sign-on pages, giving customers a way back to the Heroku website.
It has no dependencies, a small footprint, and it works over SSL.

## Manifesto

The ideal Heroku nav should be consistent in appearance and behavior across Heroku sites
while adapting to the given context. As contextual information like `user`, `app`, `addon`, and `org`
are made available to this nav, it should respond intelligently.

[Many](https://github.com/heroku/heroku-nav)
[previous](https://github.com/heroku/fuji)
[solutions](https://github.com/heroku/fuji-sherpa) have appeared and are in use today, but the
complexity, ruby-language specificity, and general inflexibility of these tools has hindered
their adoption and maintenance.

Boomerang is the latest incarnation of the Heroku nav.
Currently being beta-tested by a handful of add-on providers on their SSO pages, this library
can easily be re-purposed to function pan-Heroku. It stands apart from its predecessors in that
it's rendered client-side by a Javascript widget. The most obvious benefits to this approach are
ease of integration and portability across sites regardless of their server-side lanuage.

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

## Overriding Styles

The included styles for Boomerang target the `.boomerang` selector.

If you would like to override any aspect of its style, write your CSS
declarations for the `#boomerang` selector. This is more specific, and will
override the default styles.

## Test Drive

If you're an existing addon provider using the old Heroku SSO header, you can try out
Boomerang in your browser's JavaScript console:

```js
document.querySelector('#heroku-header').style.display = 'none';
document.querySelector('#heroku-subheader').style.display = 'none';
var s = document.createElement('script');
s.src = 'https://s3.amazonaws.com/assets.heroku.com/boomerang/boomerang.js';
document.querySelector('body').appendChild(s);
Boomerang.init({app: 'foo', addon: 'bar'});
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

## Old Header

![http://cl.ly/image/3C0w2c1x0I3F](http://cl.ly/image/3C0w2c1x0I3F/content#.png)

## New Header

![http://cl.ly/image/3P3f012h3w1Y](http://cl.ly/image/3P3f012h3w1Y/content#.png)
