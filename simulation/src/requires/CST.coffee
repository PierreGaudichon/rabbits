CST = {}


CST.grass =
	#randTimeBetweenSpawn: -> 0.5 + (Math.random()*0.2)
	randTimeBetweenSpawn: -> 0.5
	color: "#2ecc71"
	startingNb: 50


CST.rabbit =
	life: 2
	color: "#e74c3c"
	startingNb: 30
	originalSpeedRandom: -> 70 + Math.random() * 60 # px/sec
	spawnClose: true
	spawnDistance: 2


CST.world =
	width: 900
	height: 450
	maxEntity: 500
	radius: 5
	timeMult: 1.5


CST.smoothie =

	height: 300
	width: 550

	chartOptions:
		grid:
			verticalSections: 1
			strokeStyle: "#000000"
		labels:
			disabled: true
		interpolation: "linear"

	delay: 20

	rabbitLineOptions:
		strokeStyle: CST.rabbit.color
		lineWidth: 3

	grassLineOptions:
		strokeStyle: CST.grass.color
		lineWidth: 3

	rabbitDivider: 2


CST.circle =
	height: 300
	width: 300



module.exports = CST
