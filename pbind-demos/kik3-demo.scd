Pbindef( \kik3,
	\instrument, "kik3",
	\dur, Pseq([3, 1, 2, 2, 4, 3, 1, 2, 2], inf)/8,
	\amp, Pseq([1, 0.7, 0.05, 0.5, 1, 1, 0.7, 0.05, 0.5], inf) / 2,
	\freq, Prand([60, 50, 40], 32),
	\harmonic, 4,
	\preamp, Pgeom(1, 1.1)
);