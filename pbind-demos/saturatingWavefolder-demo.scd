Pbindef(\saturatingWavefolder,
	\instrument, "saturatingWavefolder",
	\rel, Pseq([
		Pn(1/8, 5), 3/4, \rest,
		1/8, Rest(1/4), Pn(1/8, 3), 3/4, \rest,
		1/2, 1/4, \rest, Pn(1/8, 4), 3/4,
		Pn(1/8, 3), 3/4, \rest,
		Pn(1/4, 3), 1/2, \rest, 1
	], 1),
	\dur, Pseq([
		Pn(1/8, 6), Rest(1),
		1/8, Rest(1/4), Pn(1/8, 4), Rest(7/8),
		3/8, 1/8, Rest(7/8), 1/4, 1/4, 1/8, 1/8, 3/8,
		Pn(1/8, 4), Rest(1),
		Pn(1/4, 4), Rest(1/2), 1/4
	], 1) * 1.05,
	\degree, Pseq([
		11, 10, 7, 6, 9, 5, \rest,
		5, \rest, 4, 6, 7, 3, \rest,
		3, 7, \rest, 9, 10, 11, 10, 9,
		7, 6, 9, 5, \rest,
		5, 6, 7, 4, \rest, 3
	], 1),
	\limit, Pseq([
		-0.5, -0.2, -0.5, -0.2, -0.3, -0.5, \rest,
		-0.3, \rest, -0.3, -0.2, -0.3, -0.5, \rest,
		-0.2, -0.5, \rest, -0.2, -0.2, -0.5, -0.2, -0.3,
		-0.5, -0.2, -0.3, -0.5, \rest,
		Pn(-0.3, 4), \rest, -0.7
	], 1),
	\amp, 0.3,
);