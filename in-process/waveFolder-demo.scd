Pbindef( \waveFolder,
	\instrument, "waveFolder",
	\dur, Pseq([0.5, 0.5, 1, 1, 1, 5, 7, 0.5, 0.5, 1, 1, 1, 5, 1, 7]) / 4,
	\rel, Pseq([0.25, 0.25, 1, 1, 1, 5, 7, 0.25, 0.25, 1, 1, 1, 5, 1, 7]) / 5,
	\ctranspose, -12,
	\degree, Pseq([0, 0, 0, 1, 2, -3, -4, 0, 0, 0, 1, 2, -3, -4, 0]),
	\nonlinearity, Pwhite(0.0, 1.0),
	\preamp, Pseq([2, 2, 6, 7, 8, 10, 15, 2, 2, 6, 7, 8, 10, 7, 20]),
	\amp, 0.3,
	\pan, Pwhite(-0.0025, 0.0025)
);