Pbindef( \crossoverDistortion,
	\instrument, "crossoverDistortion",
	\dur, Pseq([2, Pseq([Pser([1], 7), 2, Pser([1], 7)], inf)]) / 4,
	\rel, Pseq([2, Pseq([Pser([1], 7), 2, Pser([1], 7)], inf)]),
	\ctranspose, -12,
	\degree, Pseq([6, //De-gree da ba dee da ba da
		[7, -2], 2, 5, 7, [8, -3], 4, 6, [7, -4], 5, 7, 9, [10, -6], 5, 9, 8,
		[7, -2], 2, 5, 7, [8, -3], 4, 6, [7, -4], 5, 7, 9, [10, -6], 5, 9, 8,
		[7, -2], 2, 5, 7, [8, -3], 4, 6, [7, -4]]),
	\nonlinearity, Pseq([0.5, Pser([0.6], 22), 0.7, Pser([0.8], 23)]),
	\preamp, 1.625,
	\amp, 0.3,
	\pan, Pwhite(-0.0025, 0.0025)
);
