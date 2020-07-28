Pbindef( \line,
	\instrument, "line",
	\dur, 0.25,
	\ctranspose, 12,
	\filterDelay1, Pwhite(0.00005, 0.0005),
	\filterDelay2, Pwhite(0.00005, 0.0005),
	\hold, Pseq([Pn(0.3, 32), 0.5]),
	\pSwitch, Prand([0, 1], inf),
	\degree, Pseq([
		[-7, 0], 2, 3, [-5, 0], 2, 3, [-4, 4], 6,
		[-7, 7], 6, 4, [-5, 7], 6, 4, [-3, 2], -1,
		[-7, 0], 2, 3, [-5, 0], 2, 3, [-4, 4], 6,
		[-7, 7], 6, 4, [-5, 7], 6, 4, [-3, 2], 4,
		[-7, 0, 7]])
);