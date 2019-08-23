Pbindef(\rissetBell,
	\instrument, "rissetBell",
	\freq, Prand([1, 1.5, 2, 2.1], 4) * 600,
	\dur, Pwhite(1/2, 3),
	\amp, 0.025,
	\att, 0.005,
	\rel, Pwhite(3, 7)
);