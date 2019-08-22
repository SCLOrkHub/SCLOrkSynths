Pbindef( \kick_electro,
	\instrument, "kick_electro",
	\dur, Pseq([Pseq([3/8, 1/8, 2/8, 2/8, 1/8, 3/8, 1/4, 1/4], 2), 1]) * 1.1,
	\amp, Pseq([0.5, 0.2], inf),
	\rel, Pwhite(0.25, 0.5),
);