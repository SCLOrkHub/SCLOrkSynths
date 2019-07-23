Pbindef(\prophet5pwmStrings,
	\instrument, "prophet5pwmStrings",
	\note, Pseq([0, 3, 8, 7, 5, 8, 7, 3], inf),
	\ctranspose, -12,
	\amp, 0.1,
	\dur, Pseq([Pn(0.5, 8), Pn(0.25, 8), Pn(0.125, 16)], 2),
	\lfowidth, Pn(Pseries(0.0, 0.025, 7), inf),
	\lforate, Pn(Pseries(2, 1, 11), inf),
	\rq, Pn(Pseries(0.9, -0.1, 5), inf)
)