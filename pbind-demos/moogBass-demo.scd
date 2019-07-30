Pdef(\moogBass,
	Pmono(
		"moogBass",
		\amp, 0.9,
		\ctranspose, Pseq([Pn(0, 8), Pn(3, 8), Pn(5, 8)]),
		\midinote, Pseq([24, 36, 48, 36, 35, 36, 43, 48], 3),
		\dur, 0.2,
		\gain, Pseries(2, 0.1, inf),
		\cutoff, Pseries(4000, 400, inf),
		\chorus, Pwhite(0.7, 0.9)
));