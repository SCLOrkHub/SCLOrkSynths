/* Received from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/ping_mh.scd

Note from the author:

Your basic percussive synth instrument, a good default sound for testing patterns, etc.

Modified By Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef(\ping_mh,{

	arg freq = 440, amp = 0.2, dur = 1, att = 0.001, curve = -4, pan = 0, out = 0, rate = 4, depth = 0.03;

	var snd, lfo, env;

	lfo = LFNoise2.ar(rate).range(1 / (1 + depth), (1 + depth));

	env = Env.perc(attackTime: att, releaseTime: dur, level: amp, curve: curve).kr(doneAction:2);

	snd = SinOsc.ar(freq: [freq, freq * lfo], mul: env);

	Out.ar(out, Pan2.ar(snd, pan))
},
metadata: (
	credit: "Author Unknown",
	category: \misc,
	tags: [\percussive, \ping, \default, \simple, \stereo, \detuned, \tuned]
	)
).add;