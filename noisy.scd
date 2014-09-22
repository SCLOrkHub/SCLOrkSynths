SynthDef("noisy", {arg out = 0, freq = 440, amp = 0.2, pan = 0.5;
	var snd, env;
	env = Env.perc(0.02, 0.1).kr(doneAction: 2);
	snd = Mix(LFPulse.ar(
		freq: freq * [1, 5/2],
		iphase: 0.0,
		width: 0.5,
		mul: amp));
	snd = snd * env ;
	Out.ar(out, Pan2.ar(snd, pan));
}).add;



(
Pbind(
	\instrument, "noisy",
	\degree, Pseq([0, 1, 2, 3, 4, -10, -5], inf),
	\dur, Pwhite(0.09, 0.15),
	\amp, Pwhite(0.05, 0.2)
).play;
)

