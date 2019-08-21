//from http://sccode.org/1-5aW
(
SynthDef("ikedaBass", {

	arg out = 0, freq = 0, att = 0, dec = 0.1, sus = 0.8, rel = 0.01, curve = -5, gate = 1, pan = 0, amp = 1;

	var env, snd;

	env = Env.adsr(
	    	attackTime: att,
	    	decayTime: dec,
	    	sustainLevel: sus,
	    	releaseTime: rel,
	    	curve: curve,
	    ).kr(gate: gate, doneAction: 2);

	env = env * amp.curvelin(inMin: 0, inMax: 1, outMin: 0, outMax: 1, curve: log(10));

	snd = SinOsc.ar(
		    freq: freq,
		    phase: (Sweep.ar(trig: gate, rate: 2pi * [52.8, 740]) + (pi/3)).wrap(-pi, pi),
	        mul: [2, 0.05]
	    ).mean.tanh;

	snd = snd * env;

	Out.ar(out, Pan2.ar(snd, pan));
}).add;
)
// 740 / 52.8

// 52.8 * 14.01515

// Synth("ikedaBass")

(
Pbind(
	\instrument, "ikedaBass",
	\dur, Pseq([1, 0.75, 0.75, 1, 0.5], inf) * 1.5,
	\legato, Pseq([0.75, 0.5, 0.5, 0.4, 0.6], inf),
	\freq, 0,
	\amp, 1
).play;
)
FreqScope.new;
Stethoscope.new;
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

