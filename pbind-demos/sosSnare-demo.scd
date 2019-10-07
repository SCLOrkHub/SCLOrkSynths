Pbindef( \sosSnare,
	\instrument, "sosSnare",
	\snareRez, Pwhite(750, 1250),
	\nyquist, Pwhite(5000, 15000),
	\rq, Pwhite(0.05, 0.2),
	\dur, Pseq([Pseq([2, 3, 2], 2), 1]) / 6,
	\amp, 1
);