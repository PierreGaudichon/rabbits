World = require "./requires/World"
anim = require "./requires/anim"
time = require "./requires/time"
CST = require "./requires/CST"
Vector = require "./requires/Vector"


cl = (e) ->
	console.log JSON.stringify e, null, "\t"



if window? and document? then $ ->

	world = World.generate()
	pause = true


	board = $ "#board-canvas"
		.attr
			height: CST.world.height
			width: CST.world.width
	context = board[0].getContext "2d"


	bytime = $ "#bytime-canvas"
		.attr
			height: CST.smoothie.height
			width: CST.smoothie.width
	bytimeCanvas = bytime.get(0).getContext "2d"
	smoothie = new SmoothieChart CST.smoothie.chartOptions
	smoothie.streamTo bytime.get(0), CST.smoothie.delay
	rabbitLine = new TimeSeries
	grassLine = new TimeSeries
	smoothie.addTimeSeries rabbitLine, CST.smoothie.rabbitLineOptions
	smoothie.addTimeSeries grassLine, CST.smoothie.grassLineOptions


	circle = $ "#circle-canvas"
		.attr
			height: CST.circle.height
			width: CST.circle.width
		.css
			"border-left-color": CST.rabbit.color
			"border-bottom-color": CST.grass.color
			"border-left-width": "3px"
			"border-bottom-width": "3px"
		.click ->
			circleContext.fillStyle = "#000000"
			circleContext.fillRect 0, 0, CST.circle.width, CST.circle.height
	circleContext = circle.get(0).getContext "2d"
	circleContext.fillRect 0, 0, CST.circle.width, CST.circle.height

	world.draw context


	$ "#make-1"
		.click ->
			bytime.hide()
			circle.hide()
		.click()

	$ "#make-2"
		.click ->
			bytime.show()
			circle.hide()

	$ "#make-3"
		.click ->
			bytime.show()
			circle.show()

	$ "#reset"
		.click ->
			world = World.generate()
			circleContext.fillStyle = "#000000"
			circleContext.fillRect 0, 0, CST.circle.width, CST.circle.height


	$ "#pause"
		.click ->
			if pause
				pause = false
				smoothie.start()
			else
				pause = true
				smoothie.stop()

	now = 0
	step = ->
		requestAnimationFrame step

		if !pause
			elapsed = time.now() - now
			now = time.now()
			world.tick CST.world.timeMult*elapsed/1000
			world.draw context

			rabbitLine.append time.now(), world.rabbits.length / CST.smoothie.rabbitDivider
			grassLine.append time.now(), world.grass.length

			pos = new Vector
				x: (world.grass.length/CST.world.maxEntity)*CST.circle.height
				y: CST.circle.height - (world.rabbits.length/CST.world.maxEntity)*CST.circle.width
			circleContext.fillStyle = "#ffffff"
			circleContext.fillRect pos.x, pos.y, 2, 2

	now = time.now()
	requestAnimationFrame step


# file:///home/pierre/dev/rabbits3/bin/index.html
