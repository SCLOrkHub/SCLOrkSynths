Pbindef(\marimba1,
	\instrument, "marimba1",
	\degree, Pseq([
		[-5, 0, 2, 5],
		2, 4, 6, 8, 10, 12, 14, Pn(16, 4)], 1),
	\dur, Pseries(0.2, -0.01, 12),
	\amp, Pseries(0.4, 0.05, 12)
);