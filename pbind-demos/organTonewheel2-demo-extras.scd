(
// Made by Meha Gupta
// Inspired by Selfish by Madison Beer
Pbindef(\dmorganTonewheel2,
    \instrument, "\organTonewheel2",
    \midinote, Pseq([65, 67, 69, 71, 72, 74,
        [52, 57, 61, 76],
        [52, 57, 61, 71],
        [52, 57, 61, 73], 69,
        [53, 56, 61, 68],
        [53, 56, 61, 69],
        [53, 56, 61, 71], 68,
        [54, 57, 62, 66],
        [54, 57, 62, 68],
        [54, 57, 62, 69], 71,
        [53, 57, 62, 73]]),
	\amp, Pseq([0.05, 0.1, 0.15, 0.2, 0.25, 0.3, Pn(0.3, 13)]) * Pgeom(1, 0.97).max(0.4),
    \dur, Pseq([Pn(0.1, 6), Pn(0.8, 12), 1.6]),
    \rel, Pseq([Pn(0.2, 6), Pn(1.2, 3), 0.1, Pn(1.2, 3), 0.1, Pn(1.2, 5)]),
	\vibRate, Pgeom(10, 0.95).max(3),
	\blend, Pgeom(0.85, 0.96).max(0.2),
	\filterHarmonic, Pseries(15, -0.75, 20).max(2).trace, //5.04
).play;
)
