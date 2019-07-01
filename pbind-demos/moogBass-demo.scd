Pmono(
	"moogBass",
	\amp, 0.5,
	\midinote, Pseq([24, 36, 48, 36, 35, 36, 43, 48],inf),
	\dur, Pstutter(8, Pseq([0.5, 0.25], inf)),
	\gain, Pn(Pseries(2, 0.1, 19),inf),
	\cutoff, Pn(Pseries(4000, 400, 18), inf),
	\chorus, 0.7
).play;