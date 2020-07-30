/*
Here's a continuation of what I did with feedbackPad1. The core of the sound is a triangle
this time, and the feedback from it is used in different ways. While feedbackPad1 uses
phase modulation, feedbackPad2 uses frequency modulation. These two methods are pretty
similar, and which one I used boils down to which one's easier to use for that particular
UGen.

On top of the little bit of delayed self-FM this triangle wave receives, it also has
its polarity modulated by a squared-off version of the same delayed feedback. Polarity is
always either 1 or -1 when it reaches the mul argument of LFTri, which produces the sort
of arpeggio-sounding motion you hear at the output. The delay time, del, seems to affect
how fast this moves, with smaller delay times corresponding to faster wobbles. When the
polFlip switch is 0, a positive value on the feedback wave causes a polarity of 1, and a
negative value causes a polarity of -1. When polFlip is 1, the polarity of the feedback is
flipped, meaning this relationship is reversed. It doesn't usually seem to cause a huge
difference in the final sound. Finally, thresh is the threshold of the Schmitt trigger
that squares off the feedback for polarity. It changes the wobble pattern a bit.

There's also a low pass filter inside the feedback loop, and the output from that is what
gets sent to the output of the SynthDef. When I wrote it, I accidentally flipped the hi
and lo filter frequencies, so that the filter starts open, and closes as the note gets
louder. This sounded cooler than what I intended, so I left it the way it was.

By Josh Mitchell July 2020.
*/

SynthDef(\feedbackPad2, {
	arg
	// Standard Values
	out = 0, amp = 0.1, gate = 1, freq = 100, pan = 0,
	// Controls for ampEnv
	att = 1.5, dec = 0.1, sus = 1, rel = 1.75, crv = 0,
	// Controls for fbEnv
	fmStartStop = 0, fmAtt = 1, fmPeak = 5, fmDec = 0.5, fmSus = 2, fmRel = 1,
	// Other Controls (thresh goes from 0 to 1, polFlip is 0 or 1)
	thresh = 0.0075, polFlip = 1, del = 0.1, rq = 0.9, filterLo = 1500, filterHi = 5000;

	var snd, fbIn, polarity, fbOut, ampEnv, fmEnv;

	// Set up the Envelopes
	ampEnv = Env.adsr(
		attackTime: att,
		decayTime: dec,
		sustainLevel: sus,
		releaseTime: rel,
		peakLevel: amp,
		curve: crv).ar(gate: gate, doneAction: 2);

	fmEnv = Env.adsr(
		attackTime: fmAtt,
		decayTime: fmDec,
		sustainLevel: fmSus,
		releaseTime: fmRel,
		peakLevel: fmPeak,
		curve: \lin,
		bias: fmStartStop).ar(gate: gate);

	// Receive the feedback
	fbIn = LocalIn.ar;
	polarity = Schmidt.ar(
		in: fbIn,
		lo: -1 * thresh,
		hi: thresh) ;
	polarity = (polarity * 2) - 1;
	polarity = polarity * ((polFlip * -2) + 1);

	// Make The Sound
	snd = LFTri.ar(
		freq: Clip.ar(
			in: freq + (fbIn * fmEnv),
			lo: 30,
			hi: SampleRate.ir/2),
		mul: polarity
	);

	// Filter the Sound
	snd = RLPF.ar(
		in: snd,
		freq: LinExp.ar(
			in: ampEnv,
			srclo: 0, srchi: amp,
			dstlo: filterHi, dsthi: filterLo),
		rq: rq);

	// Delay the feedback
	fbOut = DelayC.ar(
		in: snd,
		maxdelaytime: del,
		delaytime: del,
		mul: 1);

	// Feedback the Sound
	LocalOut.ar(fbOut);

	// Output Stuff
	snd = Mix.ar(snd) * ampEnv;
	snd = Limiter.ar(snd);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Josh Mitchell",
	category: \pads,
	tags: [\pitched]
	)
).add;