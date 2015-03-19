modulo = (a, b) ->
	((a%b)+b)%b



module.exports = class Vector

	@add: (a, b) ->
		new Vector
			x: a.x+b.x
			y: a.y+b.y

	@mult: (k, a) ->
		new Vector
			x: k*a.x
			y: k*a.y

	@minus: (a, b) ->
		Vector.add(a, Vector.mult(-1, b))


	@distance: (a, b) ->
		Math.sqrt (b.x-a.x)**2 + (b.y-a.y)**2


	@modulo: (a, m) ->
		new	Vector
			x: modulo a.x, m.x
			y: modulo a.y, m.y


	@fromPolar: ({r, t}) ->
		new Vector
			x: r * Math.cos t
			y: r * Math.sin t

	x: 0
	y: 0

	constructor: ({@x, @y}) ->
		@r = Math.sqrt @x**2 + @y**2
		@t = Math.atan @y / @x
		@t += Math.PI if @x < 0

	toJSON: -> {@x, @y}



