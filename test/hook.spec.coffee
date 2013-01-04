casper.start "http://localhost:8000/demo.html", ->

  @click "a.reset"
  @test.assertDoesntExist('#hook')
    
  @click "a.a"
  @waitUntilVisible "#hook", ->
    @test.assertExists ".hook > ul"

  @click "a.reset"
  @test.assertDoesntExist('#hook')
  
  @click "a.b"
  @waitUntilVisible "#hook", ->
    @test.assertExists ".hook > ul"

casper.run ->
  @test.done()
  @test.renderResults(true)
  