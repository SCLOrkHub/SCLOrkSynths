Pbindef( \violin,
	\instrument, "violin",
    \ctranspose, 14,
	\dur, Pseq([Pn(1/4, 3), 3/4, Pn(1/4, 7), 3/4, Pn(1/4, 3), 3/4, Pn(1/4, 5), 1], 1) * 1.5,
    \degree, Pseq([-1, 0, 1, 2, 1, 2, 5, 4, 2, 1, 0, -2, 0, 2, 3, 4, 5, 4, 2, 0, 1, 0], 1),
);