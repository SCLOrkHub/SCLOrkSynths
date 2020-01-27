/*
By Eric Sluyter
Retrieved from https://sccode.org/1-4YY and
https://sound.stackexchange.com/questions/35138/help-me-make-a-patch-for-this-bass-stab-pluck

Slightly reformatted by Bruno Ruviaro November 2019.

from Eric:
"You could definitely use any number of hardware synths or plugins to do the same thing. General method I used, create a "pluck" sound with Karplus-Strong synthesis, and combine with a triangle wave, sine wave, and sub sine (sine wave at 1/2 the frequency). I also added a "click" at the beginning to give a little more punch. Then used enveloped resonant low pass filters to give it that synthy twang, and applied a little distortion to give it some color."
*/

SynthDef("noQuarter", {
	arg
	// Standard Arguments
	out = 0, freq = 440, amp = 0.1, pan = 0, att = 0, rel = 1, curve = -4;

	var subfreq = freq / 2;

	// Envelopes
	var subenv = Env.perc(attackTime: att, releaseTime: rel, level: amp, curve: curve).kr(doneAction: 2);
	var env = Env.perc(att, rel/2, amp, curve).kr;

	// Component synthesis
	var pluck = Pluck.ar(
		in: PinkNoise.ar,
		trig: 1,
		maxdelaytime: 0.2,
		delaytime: subfreq.reciprocal
	) * subenv * 2;
	var tri = VarSaw.ar(freq) * env;
	var sin = SinOsc.ar(freq) * env;
	var sub = (SinOsc.ar([subfreq, subfreq - 2, subfreq + 2]).sum * subenv).tanh;
	var click = RLPF.ar(
		in: Impulse.ar(0),
		freq: [2000, 8000],
		rq: 1
	).sum * 1000;

	// Initial signal
	var snd = pluck + tri + sub + click;

	// Resonant LPFs
	snd = RLPF.ar(
		in: snd,
		freq: XLine.ar(freq * 100, freq * 10, 0.15)
	);
	snd = snd + (MoogFF.ar(in: snd, freq:  freq * 20, gain: 2.5) * 0.1);

	// EQ resulting signal
	snd = BPeakEQ.ar(snd, 400, 0.5, -9);
	snd = BPeakEQ.ar(snd, 2000, 0.5, 6);
	snd = BHiShelf.ar(snd, 8000, 1, 3);
	snd = BPeakEQ.ar(snd, 200, 1, 3);

	// Apply another envelope to dampen a bit more
	snd = snd * XLine.kr(1, 0.6, 0.1);

	// Tanh distortion / limiting
	snd = (snd * 1).tanh;

	// Another round of signal coloring, using another RLPF
	// and sine components
	snd = snd +
	RLPF.ar(
		in: snd,
		freq: XLine.ar(freq * 100, freq * 10, 0.15)
	) + sin + sub;

	// Another round of tanh distortion / limiting
	snd = (snd / 2.3).tanh;

	// Another resonant LPF
	snd = MoogFF.ar(
		in: snd,
		freq: XLine.ar(freq*150, freq*30, 0.1),
		gain:  0.1
	);

	snd = Pan2.ar(snd, pan);
	Out.ar(out, snd);
},
metadata: (
	credit: "by Eric Sluyter",
	category: \bass,
	tags: [\pitched, \bass, \karplus]
	)
).add;