Pbindef( \hashercymbal,
	\instrument, "hashercymbal",
	\dur, 1/8,
	\rel, 0.15,
	\amp, Pseq([Pseq([0.1, 0.05, 0.05, 0.1, 0.05, 0.05, 0.1, 0.05], 4), 0.1]),
	\timbre, Pwhite(-100, 100),
	\looprate, Pwhite(10, 10000),
	\samplerate, Pwhite(200, 22500),
);