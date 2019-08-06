Pbindef( \vintageSine2,
	\instrument, "vintageSine2",
    \ctranspose, -6,
    \legato, 1,
	\dur, 5/4,
	\degree, Pseq([Pseq([Prand([0, 2, 5], 1), Prand([1, 4, 7], 1)], 7), 0, 0], 1),
	\amp, Pseq([1, 1, 1, 1, 0], inf)
);