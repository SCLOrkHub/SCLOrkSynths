/*
A SynthDef Draft by Josh Mitchell, 8/19.
*/

(
SynthDef("steelDrum", {
	arg freq = 440, amp = 0.1, out = 0, pan = 0, att = 0.01, dec = 1, curve = -8;

	var resFreqArray, resAmpArray, resDecArray, enva, envb, envc, snda, sndb, sndc, snd;

	resFreqArray = [2, 2.98, 4.75, 6.21, 9, 9.15, 11.87]; //Emphasises 5ths and 9ths
	resAmpArray = Array.rand(7, 0.05, 1.00);
	resDecArray = Array.rand(7, 0.25, 1.5);

	enva = Env.pairs([[0, 0], [att, 1], [(att + dec), 0]], curve).kr; //Env.pairs used to emulate the "bloom" of a note.
	envb = Env.pairs([[0, 0], [(att * 5), 0.2], [(att * 6), 0.75], [((att * 6) + dec), 0]], curve).kr;
	envc = Env.pairs([[0, 0], [(att * 5), 0.1], [(att * 10), 0.5], [((att * 10) + (dec / 2)), 0]], curve).kr;

	snda = LFPar.ar(freq: freq, mul: enva); //Will possibly use SinOsc instead of LFPar?
	sndb = LFPar.ar(freq: freq * 2.015, mul: envb);
	sndc = DynKlank.ar(
		specificationsArrayRef:
		    Ref.new([
		    	resFreqArray * freq,
		    	resAmpArray * amp,
			    resDecArray * dec
		    ]),
		input:
		LPF.ar(CombN.ar(PinkNoise.ar(1), 1/freq, 1/freq, -1, envc), freq * 12) //Creates a metalic sound to give DynKlank
	);

	snd = Mix.ar([snda, sndb, sndc]) * amp;
	snd = Limiter.ar(snd); //Just in case I mess up while writing the SynthDef

	DetectSilence.ar(in: snd, amp: 0.0001, time: 0.5, doneAction: 2);
	Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Josh Mitchell",
	category: \misc,
	tags: [\pitched]
	)
).add
)

(
Pbind(
	\instrument, "steelDrum",
	\ctranspose, -8,
    \strum, 0.075,
	\curve, -6,
	\beatFreq, 9,
	\dur, Pwhite(0.25, 0.3, inf),
	\note, Pseq([Pseq([0, 11, 7], 4), Pseq([3, 14, 10], 2), 2, 6, 7, 6, [0, 7, 11]], 1),
	\amp, Pseq([Pseq([0.7, 0.3, 0.7, 0.7, 0.3, 0.3], 3), 0.7, 0.3, 0.7, 0.3, 0.5], 1) * 0.5,
).play;
)

FreqScope.new;