Pbindef( \beating,
	\instrument, "beating",
	\ctranspose, -8,
    \strum, 0.075,
	\curve, -6,
	\beatFreq, 9,
	\dur, Pwhite(0.25, 0.3, inf),
	\dec, Pwhite(0.7, 1.75, inf),
	\note, Pseq([Pseq([0, 11, 7], 4), Pseq([3, 14, 10], 2), 2, 6, 7, 6, [0, 7, 11]], 1),
	\amp, Pseq([Pseq([0.7, 0.3, 0.7, 0.7, 0.3, 0.3], 3), 0.7, 0.3, 0.7, 0.3, 0.5], 1)
);