Pbindef( \sosTom,
	\instrument, "sosTom",
	\dur, Pseq([1, 2, 1, 2, 1, 2, 1, 2, 2, 2]) / 7,
	\pan, Pseries(0.75, -0.15, 10),
	\freq, Pstutter(2, Pseq([250, 200, 150, 100, 50])),
);