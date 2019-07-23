Pbindef(\werkit2,
	\instrument, "werkit2",
	\amp, Pwhite(0.05, 0.1),
	\note, Pseq([-1, 1, -1, 1, 3, 6, 9, 11, 12, 15, 17, 18, 19, 20, 23, 26], inf),
	\dur, 0.25,
	\att, Pn(Pgeom(0.01, 1.1, 16), inf),
	\rel, Pn(Pgeom(0.02, 1.35, 16), inf),
	\rq, Pwhite(0.005, 0.02)
);