// Extra Demos for \apadMH SynthDef


(
// made by Diya Menon
// inspired by Eastside
// demo
Pbindef(\dmapadMH2,
	\instrument, "apadMH",
	\midinote, Pseq([
		73, 73, 73, 73, 69, 71, 71, 71, 69, 69, 69, 69, 69, 64, 69, 69, 69, 69,
		[57, 61, 52, 69, 73, 64],
		[56, 59, 51, 68, 71, 63],
		[61, 64, 56, 73, 76, 68],
		[54, 57, 49, 66, 69, 61],
		[54, 57, 49, 66, 69, 61],
		[56, 59, 51, 68, 71, 63],
		[57, 61, 52, 69, 73, 64],
	]),
	\amp, Pseq([
		Pn([0.075], 18),
		0.081, 0.065, 0.075, 0.1, 0.065, 0.05, 0.1
	]),
	\dur, Pseq([
		Pn(0.17, 3), 0.34,
		Pseq([Pn(0.17, 4), 0.34], 2),
		Pn(0.17, 4),
		1.5, 0.75, 0.75, 1.5, 0.75, 0.75, 1.5]),
	\rel, Pgeom(0.01, 1.25),
	\reverbMix, 0
).play;
)

(
// by Bruno Ruviaro
Pbindef(\apadMH2,
	\instrument, "apadMH",
	\degree, Pwhite(-10, 15, inf),
	\amp, Pwhite(0.06, 0.2, inf),
	\mtranspose, Prand([
		0,
		[0, 4],
		0,
		[0, 5, 7]
	], inf),
	\dur, Prand([1, 2, 2.6], inf),
	\att, Pwhite(0.9, 1.5),
	\rel, 6, //Pn(Pgeom(0.01, 1.25), inf),
	\legato, 1,
	\vibratoRate, Pwhite(2.0, 4.0, inf),
	\vibratoDepth, Pwhite(0.005, 0.02, inf),
	\reverbMix, 0.2
).play;
)


