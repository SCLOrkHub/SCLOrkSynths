Pbindef( \distortedGuitar,
	\instrument, "distortedGuitar",
	\ctranspose, -24,
	\amp, Pseq([Pseq([
		    0.1, 0.1, 0.1, 0.1, 0.1, 0, 0.1, 0.1,
		    0.1, 0.1, 0, 0.1, 0.1, 0, 0.1, 0.1],
	    4), 0.1]) * 0.6,
	\dur, 0.175,
	\strum, Pseq([1, -1], inf) * Pwhite(0.02, 0.03),
	\degree, Pstutter(8, Pseq([0, 3, 5, 4], 3) + [0, 4, 7]),
	\openStringFreq, [110, 147, 196] * Prand([1, 1, 2], inf),
	\pickPos, Pwhite(0.2, 0.8),
	\muteSus, Pseq([Pseq([
		    0.15, 0.15, 0.15, 0.15, 0.25, 0, 0.15, 0.15,
		    0.15, 0.3, 0, 0.15, 0.2, 0, 0.15, 0.15],
	    4), 10])
);