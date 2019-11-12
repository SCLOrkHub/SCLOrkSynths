Pbindef( \neuroSnare,
	\instrument, "neuroSnare",
	\dur, 1/5,
	\freq, Pseq([Pn(160, 8), Pn(180, 6), Pn(210, 8), Pn(250, 6), 160]),
	\sweepstart, Prand([3000, 750], inf),
	\amp, Pseq([1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0], inf) / 3
);