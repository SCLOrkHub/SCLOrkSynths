Pbindef(\sawSynth,
	\instrument, "sawSynth",
	\ctranspose, Pseq([Prand([-6, -6, 6], 20), -6], 1),
	\dur, 1/5,
	\degree, Pseq([Pseq([Prand([0, 2, 5], 1), Prand([1, 4, 7], 1)], 10), 0], 1),
	\amp, Pseq([Pwhite(0.15, 0.2, 4), 0.1], inf),
	\rel, Pseries(1, 0.1, 20),
	\att, Pgeom(0.01, 1.1, 20)
);