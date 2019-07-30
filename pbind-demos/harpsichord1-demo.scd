Pbindef(\harpsichord1,
	\instrument, "harpsichord1",
	\scale, Scale.harmonicMinor,
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, [-7, -3, 0, 2, 4, 6], 7, 6, 7], 1),
	\amp, Pseq([Pn(0.5, 8), 0.4, 0.4, 0.3]) * 0.4,
	\dur, Pseq([0.3, Pn(0.1, 6), 1.3, 0.08, 0.1, 1]),
	\strum, 0.09
);