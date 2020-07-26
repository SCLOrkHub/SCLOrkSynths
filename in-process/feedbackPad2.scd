/*
By Josh Mitchell July 2020.
*/

(
SynthDef(\feedbackPad2, {
	arg
	// Standard Values
	out = 0, amp = 1, gate = 1, freq = 100, pan = 0,
	// Controls for ampEnv
	att = 0.5, dec = 0.1, sus = 1, rel = 1.5, crv = 0,
	// Controls for fbEnv
	fmStartStop = 0, fmAtt = 1, fmPeak = 5, fmDec = 0.5,
	fmSus = 3, fmRel = 1,
	// Confrols for delEnv
	del = 0.1, selfFM = 10;

	var snd, fbIn, polarity, fbOut, ampEnv, fmEnv;

	// Set up the Envelopes
	ampEnv = Env.adsr(
		attackTime: att,
		decayTime: dec,
		sustainLevel: sus,
		releaseTime: rel,
		peakLevel: amp,
		curve: crv).ar(gate: gate);

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
	polarity = Schmidt.ar(fbIn, lo: -0.1, hi: 0.1) ;
	polarity = (polarity * 2) - 1;

	// The Sound
	snd = LFTri.ar(
		freq: freq + (fbIn * fmEnv),
		mul: polarity
	);

	// Delay the feedback
	fbOut = DelayC.ar(
		in: snd,
		maxdelaytime: del,
		delaytime: del,
		mul: 1);

	// Send the feedback
	LocalOut.ar(fbOut);

	// Output Stuff
	snd = Mix.ar(snd) * ampEnv;

	snd = Limiter.ar(snd);

    DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Josh Mitchell",
	category: \pads,
	tags: [\pitched]
	)
).add;
)

(
Pbindef( \feedbackPad2,
	\instrument, "feedbackPad2",
	\dur, 3,
	\ctranspose, 12,
	\legato, 0.55,
	\del, Pwhite(0.05, 0.1),
	\degree, Pseq([[-7, 0, 2, 4], [-5, -1, 2, 4], [-6, -2, 1, 4], [-7, -3, 0, 4]], 2)
).play;
)
