Pbindef(\acidOto3092,
	\instrument, "acidOto3092",
	\dur, Pseq([Pn(1/8, 8), 1/2, 1/8, 1/8, Rest(1/8), 1/8, Rest(1/8), 1/8, Rest(1/8), 1/8, 3/8, 3/8, 3/8, 1/2]),
	\rel, Pseq([Pn(0.4, 8), 0.8, Pn(0.4, 8), Pn(0.4, 2), 0.8, 1]),
	\att, Pseq([Pn(0.001, 8), 0.05, Pn(0.001, 8), 0.01, 0.1, 0.3, 0.5]),
	\ctranspose, -32,
	\filterRange, Pn(Pseries(3, 1, 3)), // in octaves
	\width, Pwhite(0.25, 0.75, inf),
	\degree, Pseq([Pn(2, 6), 4, 5, -2, -3, -2, \rest, 0, \rest, 3, \rest, 1, 4, 6, 2, -2]),
	\amp, Pseq([0.1, 0.1, 0.15, 0.2, 0.2, 0.25, 0.3, 0.3, 0.7, 0.1, 0.15, 0, 0.2, 0, 0.3, 0, 0.4, 0.5, 0.6, 0.6, 0.4]),
);