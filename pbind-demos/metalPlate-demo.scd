Pbindef( \metalPlate,
	\instrument, "metalPlate",
	\dur, Pseq([
		0.3, 0.15, 0.3, 0.3, 0.3], inf),
	\legato, 0.25,
	\freq, Pseq([
		200,
		Pxrand([75, 100, 120, 150], 4)], inf),
	\rel, Pseq([0.75, 0.5, 0.5, 0.5, 0.5], inf) * 1.5,
	\xpos, Pwhite(0.1, 0.9),
	\ypos, Pwhite(0.1, 0.9),
	\ratio, Pwhite(0.1, 0.9),
	\thumpDec, Pseq([2, 0.01, 2, 0.01, 0.01], inf),
	\decCoef, Pseq([Pstutter(5, Pseq([0.5, 0.3, 0.2, 0.1])), 0.15])
);