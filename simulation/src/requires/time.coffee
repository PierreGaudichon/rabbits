module.exports = time =
	out: (t, f) -> setTimeout f, t
	interval: (t, f) -> setInterval f, t
	now: -> (new Date).getTime()
