Pbindef(\snare1,
	\instrument, "snare1",
	\dur, Pseq([
		Pseq([Pn(1/16, 3), 1/3, Rest(1/3)], 2),
		Pn(1/12, 3),
		Pn(1/3, 3)
	], 1),
	\amp, 0.25,
	\rel, 0.1
);