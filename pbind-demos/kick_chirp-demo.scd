Pbindef( \kick_chirp,
	\instrument, "kick_chirp",
	\dur, Pseq([Pn(1/2, 4), Pn(1/4, 8), Pn(1/8, 16), Pn(1/16, 16), 1/2, Pseq([3/8, 3/8, 1/4], inf)]),
	\maxFreq, Pseq([Pn(300, 4), Pn(450, 8), Pn(660, 16), Pn(900, 8), Pn(1200, 8), 60, Pn(200)]),
	\amp, Pseq([Pn(0.5, 44), 1, 1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1]),
);