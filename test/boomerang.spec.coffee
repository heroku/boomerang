casper.start "http://localhost:8080/demo.html", ->

  @click "a.reset"
  @test.assertDoesntExist('#boomerang')
    
  @click "a.a"
  @waitUntilVisible "#boomerang", ->
    @test.assertExists ".boomerang > ul"

  @click "a.reset"
  @test.assertDoesntExist('#boomerang')
  
  @click "a.b"
  @waitUntilVisible "#boomerang", ->
    @test.assertExists ".boomerang > ul"

  @click "a.reset"
  @test.assertDoesntExist('#boomerang')

  @click "a.c"
  @waitUntilVisible "#boomerang", ->
    @test.assertExists "#parent > .boomerang > ul"

casper.run ->
  @test.done()
  @test.renderResults(true)
  