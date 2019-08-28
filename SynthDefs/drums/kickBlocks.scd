/*
This SynthDef combines three kick SynthDefs by Nathan Ho that use very similar building blocks.
It should be very easy to add more of the same blocks for even more layers!

Originals use Hasher.ar(Sweep.ar) as a quick way to generate deterministic white noise,
to get exactly the same kick each time for a precise digital sampler effect.
WhiteNoise.ar should work too.

Some of the attacks are so fast that Env:kr doesn't correctly handle them.

Modified and combined into one SynthDef by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("kickBlocks", {
	arg
	//Standard Values
	out = 0, pan = 2, amp = 0.4, curve = -4,
	//tone1 arguments
	t1freq = 400, t1harmonic = 2, t1glide = 0.01,
	t1att = 0.0005, t1rel = 0.01, t1curve = -4, t1del = 0, t1amp = 1,
	//tone2 arguments
	t2freq = 50, t2harmonic = 3.44, t2glide = 0.01,
	t2att = 0.0001, t2rel = 0.3, t2curve = \lin, t2del = 0.005, t2amp = 1,
	//hit1 arguments
	h1freq = 100, h1harmonic = 8, h1glide = 0.01, h1rq = 0.6,
	h1att = 0.001, h1rel = 0.02, h1curve = -4, h1del = 0.001, h1amp = 1,
	//hit2 arguments
	h2freq = 1320, h2harmonic = 1, h2glide = 0,
	h2att = 0.003, h2rel = 0.03, h2curve = -4, h2del = 0, h2amp = 0.5,
	//click arguments
	cfreq = 6100, crq = 1, camp = 1.41;

    var snd, noise, tone1, tone2, hit1, hit2, click;

	noise = Hasher.ar(Sweep.ar); //deterministic white noise

    tone1 = SinOsc.ar(
		freq: XLine.ar(start: t1freq * t1harmonic, end: t1freq, dur: t1glide),
		mul: Env.perc(attackTime: t1att, releaseTime: t1rel, level: t1amp, curve: t1curve).delay(t1del).ar);

	tone2 = SinOsc.ar(
		freq: XLine.ar(start: t2freq * t2harmonic, end: t2freq, dur: t2glide),
		mul: Env.perc(attackTime: t2att, releaseTime: t2rel, level: t2amp, curve: t2curve).delay(t2del).ar);

    hit1 = BPF.ar(
		in: noise,
		freq: XLine.ar(start: h1freq * h1harmonic, end: h1freq, dur: h1glide),
		rq: h1rq,
		mul: Env.perc(attackTime: h1att, releaseTime: h1rel, level: h1amp, curve: h1curve).delay(h1del).ar);

	hit2 = HPF.ar(
		in: noise,
		freq: XLine.ar(start: h2freq * h2harmonic, end: h2freq, dur: h2glide),
		mul: Env.perc(attackTime: h2att, releaseTime: h2rel, level: h2amp, curve: h2curve).delay(h2del).ar);

	click = BPF.ar(
		in: Impulse.ar(0) * SampleRate.ir / 48000,
		freq:  cfreq,
		rq: crq,
		mul: camp);

	snd = Mix.ar(tone1 + tone2 + hit1 + hit2 + click).tanh * amp;

	DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "originals by Nathan Ho aka snapizz",
	category: \drums,
	tags: [\bass]
	)
).add;