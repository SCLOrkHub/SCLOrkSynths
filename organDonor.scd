/*
Mitchell Sigman (2011) Steal this Sound. Milwaukee, WI: Hal Leonard Books
pp. 12-13

Adapted for SuperCollider and elaborated by Nick Collins
http://www.sussex.ac.uk/Users/nc81/index.html
under GNU GPL 3 as per SuperCollider license

Minor SynthDef Smodifications by Bruno Ruviaro, June 2015.
*/

// Essentially, Pulse waveforms in multiple octaves; I've refined the patch to add freq*[1,2,3] which gives octave and octave + fifth over fundamental [Nick Collins]


SynthDef("organDonor",{
	arg out = 0, pan = 0.0, freq = 440, amp = 0.1, gate = 1, att = 0.01, dec = 0.5, sus = 1, rel = 0.5, lforate = 10, lfowidth = 0.01, cutoff = 100, rq = 0.5;

	var vibrato, pulse, filter, env;
	vibrato = SinOsc.ar(lforate, Rand(0, 2.0));
	// up octave, detune by 4 cents
	// 11.96.midiratio = 1.9953843530485
	// up octave and a half, detune up by 10 cents
	// 19.10.midiratio = 3.0139733629359
	freq = freq * [1, 1.9953843530485, 3.0139733629359];
	freq = freq * (1.0 + (lfowidth * vibrato));
	pulse = VarSaw.ar(
		freq: freq,
		iphase: Rand(0.0, 1.0) ! 3,
		width: Rand(0.3, 0.5) ! 3,
		mul: [1.0,0.7,0.3]);
	pulse = Mix(pulse);
	filter = RLPF.ar(pulse, cutoff, rq);
	env = EnvGen.ar(
		envelope: Env.adsr(att, dec, sus, rel, amp),
		gate: gate,
		doneAction: 2);
	Out.ar(out, Pan2.ar(filter * env, pan));
}).add;