Pbind(
	\instrument, "werkit",
	\amp, Pwhite(0.05, 0.1),
	\note, Pseq([-1, 1, -1, 1, 3, 6, 9, 11, 12, 15, 17, 18, 19, 20, 23, 26], 3),
	\dur, 0.25,
	\rq, Pwhite(0.005, 0.01)
)