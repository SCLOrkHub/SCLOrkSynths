Pbindef( \sillyVoice,
	\instrument, "sillyVoice",
	\ctranspose, -12,
	\degree, Prand([0, 1, 2, 4, 5, 7], inf),
	\vowel, Pwhite(0.0, 3.0),
	\dur, Pseq([Pseq([1, 2, 1], 4), 4]) / 3,
	\amp, 1
);