Pbindef(\triangleWaveBells,
		\instrument, "triangleWaveBells",
		\amp, Pwhite(0.1, 0.15),
		\legato, 1.1,
		\note, Pseq([0, 7, 3, 0, 8, 7, 8, 5, 7, 12, 5, 3, 12, 7, 15, [-19, -7], [-12, -5, 0, 3, 7]], 2),
		\dur, Pwrand([0.6, 1.2], [0.9, 0.1], inf),
		\lfowidth, Pn(Pseries(0.0, 0.005, 16), inf),
		\lforate, Pn(Pseries(1, 0.5, 16), inf),
		\rq, Pn(Pseries(0.9, -0.01, 16),inf),
		\cutoff, Pn(Pseries(60, 20, 16),inf)
);