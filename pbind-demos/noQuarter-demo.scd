Pbindef(\noQuarter,
	\instrument, "noQuarter",
	\midinote, Pseq([
		Pseq([
			42, 42, 42, \rest, 42, // m. 1
			42, 42, 45, 42, 47, \rest, 47, 45 // m. 2
		], 2),
		42
	]),
	\dur, Pseq([
		Pseq([
			1, 1, 1, Rest(3/4), 1/4,
			1/2, 1/2, 1/2, 1/4, 1/4, Rest(1.5), 1/4, 1/4,
		], 2),
		1
	]) * 0.56,
	\att, 0,
	\rel, 1,
	\amp, 0.7
);