Pbindef(\laserbeam,
	\instrument, "laserbeam",
	\amp, 0.2,
	\midinote,Pseq([36, 48, 60, 72, 84], inf),
	\dur, 0.5,
	\att, Pstutter(8, Pseq([Pshuf((0.01, 0.02..0.1), 1)],inf))
);

