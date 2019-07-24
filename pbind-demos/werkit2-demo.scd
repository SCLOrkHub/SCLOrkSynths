Pbindef(\werkit2,
	\instrument, "werkit2",
	\amp, Pwhite(0.05, 0.1),
	\note, Pshuf([11, 12, 15, 17, 18, 19, 20, 23, 26], 1),
	\dur, 0.15,
	\att, Pn(Pgeom(0.01, 1.1, 16), inf),
	\rel, 0.8,
	\rq, Pwhite(0.005, 0.02)
);