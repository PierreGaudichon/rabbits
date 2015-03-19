Vector = require "./Vector"
CST = require "./CST"

module.exports = class Rabbit

	world: "World"
	id: "Number"

	# pixel
	position: "Vector"

	# pixel/sec
	speed: "Vector"

	life: Number


	constructor: (@world, @id, x, y) ->
		@position = Vector.modulo (new Vector {x, y}), @world.dimention()
		@speed = Vector.fromPolar
			r: CST.rabbit.originalSpeedRandom()
			t: 2 * Math.PI * Math.random()
		@life = CST.rabbit.life


	toJSON: ->
		position: @position.toJSON()
		speed: @speed.toJSON()
		life: @life


	move: (t) ->
		journey = Vector.mult(t, @speed)
		@position = Vector.add(@position, journey)
		@position = Vector.modulo(@position, @world.dimention())


	tick: (t) ->
		@goTo @findClosestGrass()
		@move t
		@life-=t
		@world.despawnRabbit @ if @life < 0


	findClosestGrass: ->
		###
		min = @world.dimention().r
		g = null
		for grass in @world.grass
			dist = Vector.distance(@.position, grass.position)
			if dist < min
				min = dist
				g = grass
		return g
		###
		if @world.grass.length > 0
			@world.grass
				.map (grass) =>
					grass: grass
					dist: Vector.distance(@position, grass.position)
				.reduce (a, b) =>
					if a.dist < b.dist then a else b
				.grass

	goTo: (grass) ->
		if grass?
			r = @speed.r
			t = Vector.minus(grass.position, @position).t
			@speed = Vector.fromPolar {r, t}
