/*
A pad SynthDef that generates tons of dense harmonic content simply by feeding a
sine wave's output back into its phase input. It's almost exactly what SinOscFB does,
only with a user-controlled delay time between when the output of the sine wave is
measured and when that gets fed back into the phase argument. As the feedback amplitude
approaches and goes beyond 1, this causes chaotic oscillation, which sounds like adding
some sort of noise until it overpowers the original signal.

Because there are only really three parameters to the sound besides its pitch (amplitude,
feedback, and delay time), each one is controlled by an envelope.

At the moment, certain delay envelope settings don't work perfectly, which is why this
SynthDef is in in-process.

By Josh Mitchell July 2020.
*/

(
SynthDef(\feedbackPad1, {
	arg
	// Standard Values
	out = 0, amp = 1, gate = 1, freq = 75, pan = 0,
	// ampEnv
	att = 2, dec = 1, sus = 1, rel = 4, crv = 0,
	// fbEnv
	fbStartStop = 0, fbAtt = 3, fbPeak = 0.8, fbDec = 2, fbSus = 0.67, fbRel = 5,
	// delEnv
	delStartStop = 0.55, delAtt = 1, delPeak = 0, delDec = 2, delSus = 0.25, delRel = 3.5;

	var snd, fbIn, fbOut, ampEnv, fbEnv, delEnv;

	ampEnv = Env.adsr(
		attackTime: att,
		decayTime: dec,
		sustainLevel: sus,
		releaseTime: rel,
		curve: crv).ar(gate: gate, doneAction: 0);

	fbEnv = Env.adsr(
		attackTime: fbAtt,
		decayTime: fbDec,
		sustainLevel: fbSus,
		releaseTime: fbRel,
		peakLevel: fbPeak,
		curve: \lin,
		bias: fbStartStop).ar(gate: gate, doneAction: 0);

	delEnv = Env.adsr(
		attackTime: delAtt,
		decayTime: delDec,
		sustainLevel: delSus,
		releaseTime: delRel,
		peakLevel: delPeak,
		curve: \lin,
		bias: delStartStop).ar(gate: gate, doneAction: 0);

	fbIn = LocalIn.ar(
		numChannels: 1,
		default: 0);

	snd = SinOsc.ar(
		freq: freq,
		phase: fbIn * pi);

	fbOut = DelayC.ar(
		in: snd,
		maxdelaytime: delStartStop,
		delaytime: delEnv,
		mul: fbEnv);

	LocalOut.ar(fbOut);

	snd = Mix.ar(snd) * ampEnv * amp;
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
Pbindef( \feedbackPad1,
	\instrument, "feedbackPad1",
	\ctranspose, -28,
	\degree, Pseq([[3, 7], [5, 7], [4, 8], [0, 4, 9]], 1),
	\dur, 14,
	\legato, 0.7,
).play;
)
