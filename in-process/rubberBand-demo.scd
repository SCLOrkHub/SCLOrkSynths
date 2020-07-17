Pbindef( \rubberBand,
	\instrument, "rubberBand",
	\ctranspose, -15,
	\dur, 1/5.5,
	\rel, 0.75,
	\amp, Pseq([Pn(Pseq([0.2, Pn(0.15, 7)]), 4), Pn(0.22, 3)]),
	\degree, Pseq([
		0, 7, 0, 7, 0, 7, 1, 5,
		-2, 5, -2, 6, -2, 7, -2, 5,
		-3, 6, -3, 6, -3, 4, 3, 5,
		-4, 5, -3, 4, -2, 5, -1, 8,
		[0, 7], [0, 7], [0, 7]
	]),
	\impulseStartFreq, Pwhite(1000, 2000),
	\impulseStopFreq, Pwhite(130, 230),
	\bendTime, Pkey(\amp)/2
);