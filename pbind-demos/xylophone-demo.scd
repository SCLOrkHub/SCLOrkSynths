Pbindef( \xylophone,
	\instrument, "xylophone",
    \ctranspose, 12,
	\dur, Pseq([Pn(1/3, 6), 2/3, Pn(1/3, 6), 1], 1) * 10,
    \degree, Pseq([7, 5, 6, 4, 5, 3, 4, 3, 1, 2, 0, 1, -1, 0], 1),
);
