Pbindef( \snareElectro,
	\instrument, "snareElectro",
	\dur, Pseq([
		3/8, 3/8, 1/4, 3/8, 3/8, 1/4,
		3/8, 3/8, 1/4, 1/4, 1/4, 1/2,
		3/8, 3/8, 1/4, 1/4, 1/4, 1/2,
		3/8, 3/8, 1/4, 1]),
	\amp, 0.4,
	\curve, -2,
	\blend, Pwhite(0.4, 0.6, inf),
	\popfreq, Pstutter(3, Pgeom(100, 7/6))
);