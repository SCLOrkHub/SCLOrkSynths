Pdef(\moogBass,
	Pmono(
		"moogBass",
		\amp, 0.5,
		\midinote, Pseq([24, 36, 48, 36, 35, 36, 43, 48], 1),
		\dur, 0.25,
		\gain, Pseries(2, 0.1, 8),
		\cutoff, Pseries(4000, 400, 8),
		\chorus, 0.7
));