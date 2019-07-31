Pbindef(\cheapPiano1,
	\instrument, "cheapPiano1",
    \ctranspose, -8,
    \legato, Pseq([0.9, 0.5, 0.5, 0.9, 0.5, 0.5, 0.5, 0.5, 0.9, 0.9, 1], inf),
	\dur, Pseq([3/4, 1, 1/4, 1/16, 3/16, Pn(1/4, 4), 1/2, 1], inf),
    \degree, Pseq([[0, 2, 4], [0, 2, 6], 7, 7, 8, 7, 6, 4, [1, 4, 6], [1, 4, 6], [0, 4, 7]], 1),
	\amp, Pwhite(0.3, 0.6),
);
