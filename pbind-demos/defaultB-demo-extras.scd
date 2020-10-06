
(
// Made my Meha Gupta
// Inspired by All I Want by Olivia Rodrigo
Pbindef(\dmdefaultB,
    \instrument, "\defaultB",
    \midinote, Pseq([
        [51, 58, 63, 67],
        [48, 55, 58, 63],
        [43, 55, 58],
        Pn([44, 51, 56, 60], 4),
        [51, 58, 63, 67],
        [48, 55, 58, 63],
        [43, 55, 58],
        [44, 51, 56, 60]]),
    \amp, Pseq([
        0.3,
        0.28,
        0.25,
        0.18, 0.15, 0.13, 0.09,
        0.25,
        0.23,
        0.2,
        0.15
	]) / 5 * [1, 0.5],
	\ctranspose, Array.rand(20, 0.9, 1.105) + [0, 12],
	\dur, Pseq([Pn(0.8, 6), 1.8, 0.8, 0.81, 0.83, 0.84, 2]) * 1.1,
    \att, 0.1,
    \rel, Pseq([Pn(0.5, 10), 3]),
).play;
)

