Pbind(
	\instrument, "blip1",
	\degree, Pwhite(0, 10),
	\dur, Pn(Pseries(0.16, -0.01, 6), inf),
	\ctranspose, Pstutter(6, Pseq([0, -12], inf)),
	\amp, Pwhite(0.3, 0.5),
	\numharm, Pseq([3, 5, 7, 10, 14, 25], inf),
	\att, 0.01,
	\rel, Pstutter(6, Pseq([0.1, 0.5, 1, 3], inf)),
	\pan, Pwhite(-1, 1.0)
)
