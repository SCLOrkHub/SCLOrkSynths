Pbindef(\modalMarimba,
	\instrument, "modalMarimba",
	\ctranspose, 8,
	\rel, 0.4,
	\dur, 1/5.5,
	\degree, Pseq([
		[0, 7], 5, 6, 6, 5, 4, 2, [-2, 7], 5, 6, 6, 5, 4, 2,
		[1, 7], 5, 6, 6, 5, 4, 2, [2, 7], 5, 6, 6, 5, 4, 2,
		[0, 7], \rest, [0, 6], \rest, \rest, 4, 2, [-2, 7], \rest, [-2, 6], \rest, \rest, 4, 2,
		[1, 7], \rest, [1, 6], \rest, \rest, 4, 2, [2, 7], \rest, [2, 6], \rest, \rest, [2, 4], \rest,
		[0, 7], 5, [0, 6], 6, 5, 4, 2, [-2, 7], 5, [-2, 6], 6, 5, 4, 2,
		[1, 7], 5, [1, 6], 6, 5, 4, 2, [2, 7], 5, [2, 6], 6, 5, 4, 2,
		[0, 7], \rest, [0, 6], \rest, \rest, [0, 7], \rest, [0, 6], \rest, \rest,
		[0, 7], \rest, [0, 6]
	], 1),
	\amp, 0.25,
	\position, Pwhite(0.65, 0.85),
);
