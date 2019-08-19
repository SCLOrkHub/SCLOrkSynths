/*
Retrieved from acid_oto309.scd

Envelopes from original changed to ADSR, filterRange changed from midi to hz.

Slightly modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("acid_oto309", {
	arg out = 0, gate = 1, freq = 440, amp = 0.1, pan = 0, att = 0.001, dec = 0.5, sus = 0.1, rel = 0.5, curve = -4, lagTime = 0.12, filterRange = 2500, width = 0.51, rq = 0.3;

	var env1, env2, snd, pitch;

	pitch = Lag.kr(freq, lagTime * (1 - Trig.kr(in: gate, dur: 0.001)) * gate);

	env1 = Env.adsr(att, dec, sus, rel, 1, [0, curve, curve, curve]).kr(gate: gate);

	env2 = Env.adsr(att, dec * 2, sus / 2, rel * 2, filterRange, [-1 * curve, curve, curve, curve]).kr(gate: gate, doneAction: 2);

	snd = LFPulse.ar(freq: pitch, width: width).range(-1, 1);

	snd = RLPF.ar(snd, (pitch + env2), rq);

	snd = snd * env1 * amp;

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "from 08091500Acid309 by_otophilia",
	category: \bass,
	tags: [\pitched, \acid, \phat, \subtractive]
	)
).add;