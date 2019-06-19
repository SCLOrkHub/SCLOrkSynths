(
SynthDef("blips1", {arg out = 0, freq = 25, numharm = 10, att = 0.01, rel = 1, amp = 0.1, pan = 0;
	var snd, env;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd = Blip.ar(
		freq: freq * [1, 1.01],
		numharm: numharm,
		mul: env
	);
	snd = LeakDC.ar(snd);
	snd = Mix.ar(snd);
	snd = Pan2.ar(snd, pan);
	Out.ar(out, snd);
}).add;
)

(
Pbind(
	\instrument, "blips1",
	\degree, Pwhite(0, 10),
	\dur, Pn(Pseries(0.16, -0.01, 6), inf),
	\ctranspose, Pstutter(6, Pseq([0, -12], inf)),
	\amp, Pwhite(0.3, 0.5),
	\numharm, Pseq([3, 5, 7, 10, 14, 25], inf),
	\att, 0.01,
	\rel, Pstutter(6, Pseq([0.1, 0.5, 1, 3], inf)),
	\pan, Pwhite(-1, 1.0)
).play;
)


