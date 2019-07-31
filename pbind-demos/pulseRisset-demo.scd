Pbindef(\pulseRisset,
    \instrument, "pulseRisset",
	\freq, Pseq([440, 880, 605, 889, 1800], inf),
	\dur, Pseq([4, 3, 2, 1/4, 1/3]),
	\rel, Pseq([Pn(11, 3), 2, 1]),
	\amp, 0.6,
	\pan, Pwhite(-1.0, 1.0),
	\pulseFreq, 8
);
