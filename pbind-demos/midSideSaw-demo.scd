Pbindef( \midSideSaw,
	\instrument, "midSideSaw",
	\ctranspose, -12,
	\degree, Pseq([
		3, 7, 3, 5, 9, 5, 4, 8, 4, 4, 8,
		3, 7, 3, 5, 9, 5, 4, 8, 4, 4, 8,
		3, 7, 3, 5, 9, 5, 4, 8, 4
	]),
	\dur, Pseq([
		1/2, 1/4, 1/4, 1/2, 1/4, 1/4,
		1/2, 1/4, 1/2, 3/8, 3/8] * 2, inf),
	\amp, Pseq([
		1, 0.25, 0.2, 1, 0.25, 0.2,
		1, 0.25, 0.2, 1, 0.7], inf),
	\monoSwitch, Pseq([Pn(1, 11), Pn(0, inf)]),
	\filterHi, Pseq([Pn(1000, 11), Pn(2000, inf)]),
	\legato, 0.7,
);