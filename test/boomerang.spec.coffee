casper.start "http://localhost:8080/demo.html", ->

  @click "a.reset"
  @test.assertDoesntExist('#heroku-boomerang')
    
  @click "a.a"
  @waitUntilVisible "#heroku-boomerang", ->
    @test.assertExists ".boomerang > ul"

  @click "a.reset"
  @test.assertDoesntExist('#heroku-boomerang')
  
  @click "a.b"
  @waitUntilVisible "#heroku-boomerang", ->
    @test.assertExists ".boomerang > ul"

casper.run ->
  @test.done()
  @test.renderResults(true)
  