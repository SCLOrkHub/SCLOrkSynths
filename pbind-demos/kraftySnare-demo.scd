Pbindef( \kraftySnare,
	\instrument, "kraftySnare",
	\dur, 1/5,
	\freq, Pseq([Pn(2000, 8), Pn(1500, 4), Pn(2000, 4)], inf),
	\rq, Pseries(0.1, 0.05, 16),
	\dec, Pseq([0.3, 0.2, 0.3, 0.7], inf),
	\amp, 0.5
);