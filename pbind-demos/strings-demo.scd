Pbindef( \strings,
	\instrument, "strings",
    \ctranspose, -6,
    \legato, Pseq([0.9, 0.5, 0.5, 0.9, 0.5, 0.5, 1], inf),
	\dur, Pseq([1, 1/2, 1/2, 1, 1/2, 1/2, 1], 1),
	\degree, Pseq([[-4, 7, 12], [-3, 6, 13], [-2, 5, 14], [-3, 6, 15], [-3, 7, 13], [-3, 6, 11], [-2, 5, 12]], 1),
	\amp, 0.5,
);