// =========================
// extra demos for \glockenspiel
// =========================

(
// made by Diya Menon
// demo
Pbindef(\dmglockenspiel,
    \instrument, "glockenspiel",
    \midinote, Pseq([
        [65, 68, 72, 75],
        72, 72, 72, 70, 72, 70, 68,
        [61, 65, 70, 73, 77],
        73, 73, 73, 72, 72, 70, 68], 2),
    \amp, Pseq([0.015, 0.005, 0.005, 0.0075, 0.0075, 0.01, 0.01, 0.02], 4) * 3,
    \dur, Pseq([0.3, 0.3, 0.3, 0.15, 0.15, 0.3, 0.15, 0.15], 4),
    \rel, 3,
    \exciterRel, 0.03,
    \att, 0.0005,
).play;
)
