//from http://sccode.org/1-5aW
(
SynthDef("ikedaBass", { arg out = 0, freq = 52.8, att = 0, dec = 0.1, sus = 0.8, rel = 0.01, gate = 1, pan = 0, amp = 1;
	var env, snd;
	env = Env.adsr(
		attackTime: att,
		decayTime: dec,
		sustainLevel: sus,
		releaseTime: rel,
		curve: -5
	).kr(doneAction: 2, gate: gate);
	snd = SinOsc.ar(
		freq: 0,
		phase: (
			Sweep.ar(trig: gate, rate: 2pi * [52.8, 740]) + (pi/3)
		).wrap(-pi, pi),
	mul: [2, 0.05]).mean.tanh;
	snd = snd * env;
	snd = Pan2.ar(
		in: snd,
		pos: pan,
		level: amp.curvelin(0, 1, 0, 1, log(10))
	);
	Out.ar(out, snd);
}).add;
)
// 740 / 52.8

// 52.8 * 14.01515

// Synth("ikedaBass")

(
Pbind(
	\instrument, "ikedaBass",
	\dur, Pseq([1, 0.75, 0.75, 1, 0.5], inf) * 0.5,
	\legato, Pseq([0.75, 0.5, 0.5, 0.4, 0.6], inf),
	\amp, 1
).play;
)


/*
original:

SynthDef(\IkedaBass, { arg out = 0, t_trig = 0, pan = 0, level = 1;
	var env, sin, sig;
	env = EnvGen.ar(Env([0, 0.5, 0.4, 0], [0, 0.2, 0.01], -5), t_trig, doneAction: 0);
	sin = SinOsc.ar(0, (Sweep.ar(t_trig, 2pi * [52.8, 740]) + (pi/3)).wrap(-pi, pi), [2, 0.05]).mean.tanh;
	sig = sin * env;
	Out.ar(out, Pan2.ar(sig, pan, level.curvelin(0, 1, 0, 1, log(10))));
}).add;

*/
