SynthDef("pluck", {arg amp = 0.1, freq = 440, decay = 5, coef = 0.1, pan = 0;
	var env, snd;
	env = EnvGen.kr(Env.linen(0, decay, 0), doneAction: 2);
	snd = Pluck.ar(
		in: WhiteNoise.ar(amp),
		trig: Impulse.kr(0),
		maxdelaytime: 0.1,
		delaytime: freq.reciprocal,
		decaytime: decay,
		coef: coef);
	snd = Pan2.ar(snd, pan);
	Out.ar(0, [snd, snd]);
}).add;