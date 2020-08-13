Pbindef( \superSaw,
	\instrument, "superSaw",
	\ctranspose, -12,
	\legato, 0.6,
	\numberOscs, Pseq([10, 30, 100, 50, 100, 75, 50, 100, 50])/2,
	\dur, Pseq([3, 3, 8, 2, 8, 3, 3, 10, 20])/2,
	\fatt, Pseq([0.5, 0.5, 2, 0.5, 2, 0.5, 0.5, 2, 4]),
	\degree, Pseq([7, 4, 5, 4, 3, 2, 4, 0, -7]),
);