(Pbindef(\FMRhodes1,
	\instrument, "FMRhodes1",
    \scale, Scale.mixolydian,
	\ctranspose, -10,
    \legato, Pseq([0.9, 0.5, 0.5, 0.9, 0.9, 0.9, 0.9, 0.7, 1, 0.9, 1, 0.6, 0.3], inf),
    \dur, Pseq([1 + (1/3), 1/3, 1/3, 1/7, 6/7, 5/6, 1/6, 1/2, 2/6, 1/6, 2 + 1/2, 1, 1/2], inf) * 1/2,
    \degree, Pseq([
        [0, 2, 4], 2, 4, 7, 8, 7, 0, [1, 3, 6], 5, [1, 3, 6], Rest(), [-1, 1, 3], [1, 3, 5],
        [0, 2, 4]
	], 1),
    \mix, 0.2,
    \modIndex, 0.2,
    \lfoSpeed, 0.5,
    \lfoDepth, 0.4,
    \inputLevel, Pgauss(0.8, 0.1, inf),
    \amp, 0.3
);
