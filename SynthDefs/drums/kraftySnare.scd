/*
Original Author Unknown

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("kraftySnare", {
	arg amp = 1, freq = 2000, rq = 3, att = 0.01, dec = 0.3, curve = -6, pan = 0, out = 0;

	var snd, env;

	env = Env.perc(attackTime: att, releaseTime: dec, curve: curve).kr(doneAction: 2);

	snd = PinkNoise.ar(amp);

	snd = BPF.ar(snd, freq, rq, env * rq.reciprocal * 2);

	snd = Limiter.ar(snd);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Author Unknown",
	category: \drums,
	tags: [\unpitched, \snare]
	)
).add;