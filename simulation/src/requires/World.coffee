Rabbit = require "./Rabbit"
Grass = require "./Grass"
Vector = require "./Vector"
CST = require "./CST"


module.exports = class World


	@generate: ->
		world = new World
			height: CST.world.height
			width: CST.world.width

		for i in [0...CST.rabbit.startingNb] by 1
			world.spawnRabbit Math.random()*world.width, Math.random()*world.width
		for i in [0...CST.grass.startingNb] by 1
			world.spawnGrass Math.random()*world.width, Math.random()*world.width

		console.log "generate"
		return world



	maxId: Number

	width: Number
	height: Number

	rabbits: [Rabbit]
	grass: [Grass]


	constructor: ({@width, @height})->
		@maxId = 0
		@rabbits = []
		@grass = []


	toJSON: ->
		rabbits = (r.toJSON() for r in @rabbits)
		grass = (g.toJSON() for g in @grass)
		{@width, @height, rabbits, grass}



	maxDimention: -> Math.max @width, @height
	dimention: -> new Vector {x: @width, y: @height}

	nbEntity: -> @rabbits.length + @grass.length


	spawnRabbit: (x, y)->
		if @nbEntity() < CST.world.maxEntity
			r = new Rabbit @, @maxId, x, y
			@rabbits.push r


	despawnRabbit: (rabbit) ->
		id = @rabbits.indexOf rabbit
		@rabbits.splice id, 1 if id > -1


	spawnGrass: (x, y) ->
		if @nbEntity() < CST.world.maxEntity
			if CST.grass.spawnClose
				v = Vector.fromPolar
					r: CST.world.radius * CST.grass.spawnDistance
					t: 2*Math.PI*math.random()
				{x, y} = Vector.add(v, new Vector {x, y})
			else
				x = Math.random() * @width
				y = Math.random() * @height
			g = new Grass @, @maxId, x, y
			@grass.push g


	despawnGrass: (grass) ->
		id = @grass.indexOf grass
		@grass.splice id, 1 if id > -1



	tick: (t) ->
		@rabbits.forEach (rabbit) ->
			rabbit.tick t
		@grass.forEach (grass) ->
			grass.tick t
		@intersectAll()


	intersectAll: ->
		toSpawn = []
		toDespawn = []
		for rabbit in @rabbits
			for grass in @grass
				if @intersectOne(rabbit, grass)
					#console.log "intersect"
					toDespawn.push grass
					toSpawn.push rabbit
					rabbit.life = CST.rabbit.life

		for rabbit in toSpawn
			@spawnRabbit rabbit.position.x, rabbit.position.y
		for grass in toDespawn
			@despawnGrass grass

		return null


	intersectOne: (a, b) ->
		Vector.distance(a.position, b.position) < CST.world.radius


	draw: (c) ->
		c.clearRect 0, 0, @width, @height

		c.beginPath()
		c.fillStyle = CST.rabbit.color
		for r in @rabbits
			c.moveTo r.position.x + CST.world.radius/2, r.position.y
			c.arc r.position.x, r.position.y, CST.world.radius, 0, 2*Math.PI
		c.fill()

		c.beginPath()
		c.fillStyle = CST.grass.color
		for g in @grass
			c.moveTo g.position.x + CST.world.radius/2, g.position.y
			c.arc g.position.x, g.position.y, CST.world.radius, 0, 2*Math.PI
		c.fill()

