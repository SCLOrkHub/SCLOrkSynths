/*
Isn't it weird how supercollider offers pink, brown, and even gray noise, but not blue or purple?

Don't worry, this SynthDef offers a rough fix to supercollider's most urgent problem!
It uses a technique borrowed from diy synth schematics found online,
of sending white noise through a bunch of parallel filters.

***I'm not sure if this is actually purple noise, but it sounds close to me!***

Purple noise is the opposite of brown noise, it increases in volume 6dB every octave.
This probably makes it good for cymbals.
Now you can grab the code below and explore with it!

Made by Josh Mitchell, 8/19.
*/

SynthDef("purpleNoise", {
	arg out = 0, pan = 0, amp = 0.1, gate = 1, att = 0.01, rel = 0.75, curve = -6;

	var noise, a, b, c, d, e, f, g, h, i, env, snd;

	noise = WhiteNoise.ar(1);

	a = HPF.ar(noise, 62,    1/9);
	b = HPF.ar(noise, 125,   2/9);
	c = HPF.ar(noise, 250,   3/9);
	d = HPF.ar(noise, 500,   4/9);
	e = HPF.ar(noise, 1000,  5/9);
	f = HPF.ar(noise, 2000,  6/9);
	g = HPF.ar(noise, 4000,  7/9);
	h = HPF.ar(noise, 8000,  8/9);
	i = HPF.ar(noise, 16000, 9/9);

	env = Env.perc(att, rel, amp, curve).kr(doneAction: 2);

	snd = Mix([a, b, c, d, e, f, g, h, i]) * env;

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Josh Mitchell",
	category: \bass,
	tags: [\noise, \unpitched, \cymbal]
	)
).add;