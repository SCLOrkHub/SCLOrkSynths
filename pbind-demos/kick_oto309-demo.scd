Pbindef( \kick_oto309,
	\instrument, "kick_oto309",
	\dur, 1/6,
	\amp, Pseq([Prand([0.6, 0.1], 16), 0.7, 0, 0.7, 0, 1]),
	\preamp, Pwhite(1.2, 2.5),
	\pulseAmp, Pwhite(0.1, 1),
	\noiseAmp, Pwhite(0.1, 1),
	\sineAmp, Pwhite(0.1, 1),
);