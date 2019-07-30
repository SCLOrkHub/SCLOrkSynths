Pbindef(\kick808,
	\instrument, "kick808",
	\dur, Pseq([
		3/4, 1/4,
		1/2, 1/2,
		Rest(1/2), 1/2,
		Rest(1/4), 3/4
	], 2) * 0.4,
	\amp, 0.8,
	\rel, 0.7,
	\dist, Pseries(0.1, 0.1, 16)
);