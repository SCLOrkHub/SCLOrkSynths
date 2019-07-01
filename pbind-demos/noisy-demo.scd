Pbind(
	\instrument, "noisy",
	\degree, Pseq([0, 1, 2, 3, 4, -10, -5], inf),
	\dur, Pwhite(0.09, 0.15),
	\amp, Pwhite(0.05, 0.2)
).play;


