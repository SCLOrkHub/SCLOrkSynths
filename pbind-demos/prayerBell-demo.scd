Pbindef(\prayerBell,
	\instrument, "prayerBell",
	\dur, Pwhite(0.6, 0.8),
	// \freq, 2434 * Prand([1, 1.5, 1.3, 0.5], inf),
	\degree, Pseq([25, 0, 1, 2, 3, 4, 5, 6, 7, 20], 1),
	\amp, 0.09,
	\pan, Pseq([-1, 0, 1], inf),
	\decayScale, 1
);
