/*
Original Author Unknown

Based on kik.scd and kick3.scd.

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("kik3", {
	arg
	//Standard Values
	amp = 1, out = 0, pan = 0, freq = 66,
	//Amplitude Controls
	att = 0.01, dec = 0.1, decaylevel = 0.8, rel = 0.3, envCurve = -4,
	//Timbre Controls
	sweeptime = 0.08, sweepCurve = \exp, harmonic = 6, preamp = 3;

	var snd, env, fenv;

	env = Env.new(levels: [0, amp, decaylevel * amp, 0], times: [att, dec, rel], curve: envCurve).kr(doneAction: 2);

	fenv = Env.new(levels: [freq * harmonic, freq], times: [sweeptime], curve: sweepCurve).kr;

	snd = SinOsc.ar(freq: fenv, mul: preamp).distort;

    snd = Normalizer.ar(in: snd, level: env);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Author Unknown",
	category: \drums,
	tags: [\unpitched, \bass]
	)
).add;