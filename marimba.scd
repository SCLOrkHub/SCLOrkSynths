(
SynthDef("marimba1", {arg freq = 440, amp = 0.4;
	var snd, env;
	env = Env.linen(0.015, 1, 0.5, amp).kr(doneAction: 2);
	snd = BPF.ar(Saw.ar(0), freq, 0.02);
	snd = BLowShelf.ar(snd, 220, 0.81, 6);
	snd = snd * env;
	Out.ar(0, Splay.ar(snd));
}).add;
)

(
Pbind(
	\instrument, "marimba1",
	\degree, Pwhite(-10, 10),
	\dur, Pwhite(0.2, 0.3),
	\amp, Pwhite(0.1, 0.5)
).play;
)