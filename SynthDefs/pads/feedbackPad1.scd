/*
A pad SynthDef that generates tons of dense harmonic content simply by feeding a
sine wave's output back into its phase input. It's almost exactly what SinOscFB does,
only with a user-controlled delay time between when the output of the sine wave is
measured and when that gets fed back into the phase argument.

Because there are only really three parameters to the sound besides its pitch (amplitude,
feedback, and delay time), each one is controlled by an adsr envelope. For the delay and
feedback envelopes, the adsr envelopes don't have to look "right-side-up" (the typical
rise - drop - sustain - drop more shape). You can think of it like this: the parameter
(delay or feedback) starts at a certain value "StartStop". As the note starts it moves to
a new value "Peak", and then a third value "Sus", over the attack and decay times,
respectively. As the note ends, the parameter then returns to its initial value over the
release time.

As the feedback amplitude approaches and goes beyond 1, the feedback causes chaotic
oscillation, which sounds sort of like adding some sort of noise until it overpowers
the original signal. If you're interested in creating musical chaos from really
simple initial rules like this feedback one, Supercollider has lots of Ugens for that!
Running    ChaosGen.allSubclasses;    provides a long list of them for you.

By Josh Mitchell July 2020.
*/

SynthDef(\feedbackPad1, {
	arg
	// Standard Values
	out = 0, amp = 1, gate = 1, freq = 75, pan = 0,
	// Controls for ampEnv
	att = 2, dec = 1, sus = 1, rel = 4, crv = 0,
	// Controls for fbEnv
	fbStartStop = 0, fbAtt = 3, fbPeak = 0.8, fbDec = 2, fbSus = 0.67, fbRel = 5,
	// Confrols for delEnv
	delStartStop = 0.55, delAtt = 1, delPeak = 0, delDec = 2, delSus = 0.25, delRel = 3.5;

	var snd, fbIn, fbOut, ampEnv, fbEnv, delEnv;

	// Set up the Envelopes
	ampEnv = Env.adsr(
		attackTime: att,
		decayTime: dec,
		sustainLevel: sus,
		releaseTime: rel,
		curve: crv).ar(gate: gate);

	fbEnv = Env.adsr(
		attackTime: fbAtt,
		decayTime: fbDec,
		sustainLevel: fbSus,
		releaseTime: fbRel,
		peakLevel: fbPeak,
		curve: \lin,
		bias: fbStartStop).ar(gate: gate);

	delEnv = Env.adsr(
		attackTime: delAtt,
		decayTime: delDec,
		sustainLevel: delSus,
		releaseTime: delRel,
		peakLevel: delPeak,
		curve: \lin,
		bias: delStartStop).ar(gate: gate);

	// Receive the feedback
	fbIn = LocalIn.ar;

	// The Sound (yup, that's all it is)
	snd = SinOsc.ar(
		freq: freq,
		phase: fbIn * pi);

	// Delay the feedback
	fbOut = DelayC.ar(
		in: snd,
		maxdelaytime: delStartStop.max(delPeak.max(delSus)),
		delaytime: delEnv,
		mul: fbEnv);

	// Send the feedback
	LocalOut.ar(fbOut);

	// Output Stuff
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
