NodeList::forEach = Array::forEach

document.addEventListener "DOMContentLoaded", ->
  window.boomerang = new Boomerang(localMode: true, app: "queriac", addon: "honeybadger")
  document.querySelectorAll("ul.demo_links li a").forEach (el) ->
    el.addEventListener "click", ->

      console.log "Demo #{el.className.toUpperCase()}"

      Boomerang.reset()

      switch el.className
        when "a"
          window.boomerang = new Boomerang(localMode: true)
        when "b"
          window.boomerang = new Boomerang(localMode: true, app: "queriac", addon: "honeybadger")
        when "c"
          # window.boomerang = new Boomerang(localMode: true)
          window

      # return false
