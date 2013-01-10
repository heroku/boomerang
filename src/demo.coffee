NodeList::forEach = Array::forEach

document.addEventListener "DOMContentLoaded", ->
  
  # window.hook = new Hook(localMode: true)

  document.querySelectorAll("ul.demo_links li a").forEach (el) ->
    el.addEventListener "click", ->
      
      console.log "Demo #{el.className.toUpperCase()}"

      Hook.reset()
      
      switch el.className
        when "a"
          window.hook = new Hook(localMode: true)
        when "b"
          window.hook = new Hook(localMode: true, app: "queriac")
        when "c"
          # window.hook = new Hook(localMode: true)
          window
        
      # return false
          
      