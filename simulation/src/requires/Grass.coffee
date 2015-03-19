Vector = require "./Vector"
CST = require "./CST"

module.exports = class Grass

	world: "World"
	id: "Number"

	position: "Vector"

	lastSpawn: "Number"


	constructor: (@world, @id, x, y) ->
		@position = Vector.modulo (new Vector {x, y}), @world.dimention()
		@lastSpawn = CST.grass.randTimeBetweenSpawn()


	toJSON: ->
		position: @position.toJSON()
		lastSpawn: @lastSpawn


	tick: (t) ->
		@lastSpawn-=t
		if @lastSpawn <= 0
			@world.spawnGrass()
			@lastSpawn = CST.grass.randTimeBetweenSpawn()

