Pbindef( \moreHarmonics,
	\instrument, "moreHarmonics",
	\dur, Pseq([3/4, 3/4, 2.5], 5),
	\ctranspose, -27,
	\legato, 0.5,
	\degree, Pseq([7, 4, 5], 5),
	\amp, 0.3,
	\blend, Pseq([0, 0, 1], 5),
	\select, Pseq([
		0, 0, 0, 1, 1, 1, 2, 2, 2,
		3, 3, 3, 4, 4, 4]),
	\focus, 0,
);