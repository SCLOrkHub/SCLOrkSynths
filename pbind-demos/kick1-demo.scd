Pbindef(\kick1,
	\instrument, "kick1",
	\dur, Pseq([
		3/4, 1/4,
		1/2, 1/2,
		Rest(1/2), 1/2,
		Rest(1/4), 3/4
	], 3) * 0.5,
	\amp, 0.9,
	\rel, Pseq([0.9, Pn(0.15, 6), 0.6], inf),
	\glissf, Pseq([Pn(0.9, 7), 0.5], inf)
);