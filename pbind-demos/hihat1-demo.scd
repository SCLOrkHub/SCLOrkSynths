Pbindef(\hihat1,
	\instrument, "hihat1",
	\dur, Pseq([
		1, 1, 1, 1,
		Prand([1, Pn(0.5, 2), Pn(0.25, 4)], 4)
	], 2),
	\ffreq, 9000,
	\rel, 0.1,
	\amp, 0.4
);