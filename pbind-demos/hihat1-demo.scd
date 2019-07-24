Pbindef(\hihat1,
	\instrument, "hihat1",
	\dur, Pseq([
		1, 1, 1, 1,
		Prand([1, 1, Pn(0.5, 2)], 4)
	], 2) * 0.2,
	\ffreq, Pwhite(7000, 11000),
	\rel, 0.1,
	\amp, 0.5
);