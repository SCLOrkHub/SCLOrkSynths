/*
Original author unknown, original used SinOsc.ar instead of Pulse.ar

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("trig_demo", {
	arg out = 0, pan = 0, freq = 440, gate = 1, t_trig = 1, att = 0.01, sus = 1, rel = 0.25;

    var env, snd;

	env = Decay2.kr(in: t_trig, attackTime: att, decayTime: rel);

	env = env * Linen.kr(gate: gate, attackTime: att, susLevel: sus, releaseTime: rel, doneAction: 2);

    snd = Pulse.ar(freq: freq, mul: env);

	Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Unknown",
	category: \misc,
	tags: [\pitched]
	)
).add;