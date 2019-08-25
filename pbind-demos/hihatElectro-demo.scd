Pbindef(\hihatElectro,
	\instrument, "hihatElectro",
	\dur, Pseq([
		Rest(1/16), Pn(1/16, 3),
		1/8, 1/8,
		Rest(1/8), 1/8,
		Rest(1/16), 1/8, 1/16
	], 2) * 2,
	\amp, Pseq([
		\rest, 0.1, 0.3, 0.5,
		0.7, 0.5,
		\rest, 0.5,
		\rest, 0.6, 0.4
	], inf),
	\rel, Pseq([
		\rest, Pn(0.3, 3),
		0.4, 0.5,
		\rest, 0.3,
		\rest, 0.3, 0.5
	], inf),
	\filterFreq, Pseries(4500, -75)
);