class Hook
  
  constructor: (@options={}) ->

    # Config
    if @options.localMode
      @cssUrl = "http://localhost:8000/lib/hook.css"
    else
      @cssUrl = "https://s3.amazonaws.com/assets.heroku.com/hook/hook.css"
      
    console.log @cssUrl
    @app = @options.app
    
    # DOM Shortcuts
    @head = document.querySelector("head")
    @body = document.querySelector("body")

    @attachStylesheet()
    @attachDiv()
    
    # Event Listeners
    window.addEventListener('click', @hideMenu)
    document.querySelector("#hook a.toggler").addEventListener('click', @toggleMenu)
    
    # console.log @

  attachStylesheet: ->
    link = document.createElement("link")
    link.type = "text/css"
    link.rel  = "stylesheet"
    link.href = @cssUrl
    # link.onload = -> console.log "stylesheet loaded"
    @head.appendChild(link)
  
  attachDiv: ->
    @div = document.createElement("div")
    @div.className = "hook"
    @div.id = "hook"
    if @app?
      @div.innerHTML = """
        <a href="#" class="toggler">heroku</a>
        <ul>
          <li class="big"><a href="https://dashboard.heroku.com/apps/#{@app}">#{@app}</a></li>
          <li class="sub"><a href="https://dashboard.heroku.com/apps/#{@app}/resources">Resources</a></li>
          <li class="sub"><a href="https://dashboard.heroku.com/apps/#{@app}/activity">Activity</a></li>
          <li class="sub"><a href="https://dashboard.heroku.com/apps/#{@app}/collaborators">Collborators</a></li>
          <li class="sub"><a href="https://dashboard.heroku.com/apps/#{@app}/settings">Settings</a></li>
        </ul>
      """        
    else
      @div.innerHTML = """
        <a href="#" class="toggler">heroku</a>
        <ul>
          <li><a href="https://dashboard.heroku.com">My Apps</a></li>
          <li><a href="https://addons.heroku.com">Add-ons</a></li>
          <li><a href="https://devcenter.heroku.com">Documentation</a></li>
          <li><a href="https://help.heroku.com">Support</a></li>
        </ul>
      """        
    @body.appendChild(@div)

  hideMenu: ->
    h = document.querySelector("#hook")
    h.classList.remove("active") if h
    
  toggleMenu: (e=null) ->
    document.querySelector("#hook").classList.toggle("active")
    # Don't let the click propage to window, or it will @hideMenu
    e.stopPropagation() if e

  # Remove hook and its event listeners.
  # (Used by demo and tests.)
  @reset: ->
    h = document.getElementById('hook')
    if h
      toggler = h.querySelector("a.toggler")
      toggler.removeEventListener('click', @toggleMenu) if toggler
      window.removeEventListener('click', @hideMenu)
      h.parentNode.removeChild(h) if h

window.Hook = Hook

# document.addEventListener "DOMContentLoaded", ->
#   unless document.querySelector("body.no-hook")
#     window.hook = new Hook()