// ===========================
// extra demos for \sawSynth
// ===========================


(
// Made by Bruno Ruviaro
// Demo
Pbindef(\sawSynthL,
	\instrument, "sawSynth",
    \midinote, Pseq([34, 36, 36.7, 32.4, 40.12], inf),
	\ctranspose, Pstutter(5, Prand([0, 0, 0, 0, 3, -1], inf)),
    \amp, Pseq([0.125, 0.2, 0.25, 0.3, 0.4], inf),
	\dur, Pwhite(0.14, 0.15, inf), //Pseq([0.5, 0.15, 0.5, 0.25, 1], inf),
    \legato, 0.5,
	\rel, Pwrand([0.1, 0.01], [0.9, 0.1], inf),
	\hifreq, Pwhite(2000, 9000, inf)
).play;
)

(
// Made by Diya Menon
// Demo
Pbindef(\dmsawSynth,
    \instrument, "sawSynth",
    \midinote, Pseq([
        [52, 67, 71], 66, 67, 71,
        [40, 67, 71], 66, 67, 71,
        [76, 67, 71], 66, 67, 71,
        69, 67, 66
    ]),
    \amp, Pseq([
        Pseq([0.125, 0.2, 0.25, 0.3], 3),
        0.32, 0.3, 0.28
    ]),
    \dur, 0.6,
    \legato, 0.5,
    \rel, Pseq([
        Pseq([3, 1.5, 1.5, 1.5], 3),
        0.5, 0.5, 1
    ])
).play;
)
