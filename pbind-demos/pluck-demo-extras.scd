// ===========================
// extra demos for pluck
// ===========================


(
// Made by Meha Gupta
// Inspired by Happy by Julia Michaels
Pbindef(\dmpluck,
    \instrument, "pluck",
    \midinote, Pseq([
        Pseq([
        [57, 69, 73, 76],
        [57, 69, 73, 76],
        [57, 71, 73, 80],
        [52, 78, 76, 80],
        [52, 78, 76, 80],
        [59, 71, 75],
        [59, 71, 75]], 2),
        64]),
    \amp, Pseq([0.2, 0.1, 0.2, 0.2, 0.1, 0.1, 0.1], inf) * 0.5,
    \dur, Pseq([Pn(Pseq([0.25, 0.75, 1, 0.5, 0.5, 0.5, 0.5]), 2), 1]),
    \decay, Pseq([1, 3, 3, 2, 2, 3, 3, 1, 3, 3, 2, 2, 3, 3, 4]),
).play;
)
