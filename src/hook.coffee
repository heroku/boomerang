# https://s3.amazonaws.com/assets.heroku.com/hook/hook.js
# https://s3.amazonaws.com/assets.heroku.com/hook/hook.css
# https://assets.heroku.com.s3.amazonaws.com/hook/hook.woff

class Hook
  
  constructor: (@options={}) ->

    # Config
    @cssUrl = @options.cssUrl || "https://s3.amazonaws.com/assets.heroku.com/hook/hook.css"
    @corner = @options.corner or 'tr'
    
    # DOM Shortcuts
    @head = document.querySelector("head")
    @body = document.querySelector("body")

    @attachStylesheet()
    @attachDiv()
    
    window.addEventListener('click', @hideMenu);
    document.querySelector("#hook a.toggler").addEventListener('click', @toggleMenu);
    
    console.log @
    

  attachStylesheet: ->
    link = document.createElement("link")
    link.type = "text/css"
    link.rel  = "stylesheet"
    link.href = @cssUrl
    @head.appendChild(link)
  
  attachDiv: ->
    @div = document.createElement("div")
    @div.className = "hook"
    @div.id = "hook"
    @div.innerHTML = """
      <a href="#" class="toggler">&#xf100</a>
      <ul>
        <li><a href="https://www.heroku.com">My Apps</a></li>
        <li><a href="https://addons.heroku.com">Addons</a></li>
        <li><a href="https://devcenter.heroku.com">Documentation</a></li>
        <li><a href="https://help.heroku.com">Support</a></li>
      </ul>
    """        
    @body.appendChild(@div)

  hideMenu: ->
    console.log 'hideMenu'
    document.querySelector("#hook").classList.remove("active")
    
  toggleMenu: (e) ->
    document.querySelector("#hook").classList.toggle("active")
    e.stopPropagation()
        
window.Hook = Hook

document.addEventListener "DOMContentLoaded", ->
  unless document.querySelector("body.no-hook")
    window.hook = new Hook()