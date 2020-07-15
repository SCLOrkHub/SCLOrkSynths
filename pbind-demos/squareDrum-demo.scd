Pbindef( \squareDrum,
	\instrument, "squareDrum",
	\freq, 180,
	\dur, Pseq([1, 2/3, 1/3, 1, 1, Rest(1), 1, 1] * 0.4),
	\amp, Pwhite(0.5, 0.625),
	\rel, Pkey(\amp)/3,
);