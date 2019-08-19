Pbindef(\beating,
	\instrument, "beating",
	\ctranspose, -8,
	\curve, -6,
	\beatFreq, 9,
	\dur, Pwhite(0.25, 0.3, inf),
	\dec, Pwhite(0.7, 1.75, inf),
	\note, Pseq([Pseq([0, 11, 7], 4), Pseq([3, 14, 10], 2), 2, 6, 7, 6, [0, 7, 11]], 1),
	\amp, Pseq([Pseq([0.35, 0.15, 0.35, 0.2, 0.2, 0.2], 3), 0.35, 0.35, 0.35, 0.25, 0.25], 1),
	// comment out next three lines for another variation
	// \ctranspose, [-8, 0],
	// \strum, 0.045,
	// \amp, Pkey(\amp) * [1, 0.2]
);
