(
SynthDef("blips1", {arg out = 0, freq = 25, numharm = 10, att = 0.01, rel = 1, amp = 0.1, pan = 0.5;
	var snd, env;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd = LeakDC.ar(Mix(Blip.ar([freq, freq*1.01], numharm, env)));
	Out.ar(out, Pan2.ar(snd, pan));
}).add;
)


(
Pbind(
	\instrument, "blips1",
	\degree, Pwhite(0, 10),
	\dur, 0.2,
	\amp, Pwhite(0.01, 0.05),
	\numharm, Pwhite(10, 20),
	\att, 0.01,
	\rel, Pwhite(0.5, 0.8),
	\pan, Pwhite(-1, 1.0)
).play;
)


