Pbindef(\FMRhodes2,
	\instrument, "FMRhodes2",
    \scale, Scale.mixolydian,
	\ctranspose, -9,
    \legato, Pseq([0.9, 0.5, 0.5, 0.9, 0.9, 0.9, 0.9, 0.7, 1, 0.9, 1, 0.6, 0.3], inf),
	\dur, Pseq([4/3, 1/3, 1/3, 1/7, 6/7, 5/6, 1/6, 1/2, 2/6, 1/6, Rest(1.4), 1, 1/2], inf) * 1/2,
    \degree, Pseq([
        [0, 2, 4], 2, 4, 7, 8, 7, 0, [1, 3, 6], 5, [1, 3, 6], Rest(), [-1, 1, 3], [1, 3, 5],
        [0, 2, 4]
	], 1),
    \mix, 0.2,
	\fmHarmonic, Pseq([Pn(30, 10), Pn(5, inf)]),
    \modIndex, 0.9,
    \lfoSpeed, 9.5,
    \lfoDepth, 0.4,
	\lfoBottom, 0.1,
	\lfoRange, 1,
    \inputLevel, Pgauss(0.8, 0.1, inf),
    \amp, 0.3
);