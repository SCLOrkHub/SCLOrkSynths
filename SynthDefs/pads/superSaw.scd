/*
This SynthDef is loosely based on the famous "supersaw" from the Roland JP-80x0
synths. The supersaw sound is very common in 2000s-or-so EDM, and in the case of
the Roland supersaw, it's built around 7 detuned saw waves with (as far as I know)
randomly determined phases. Just like in most other supersaws, you can choose how
detuned the saws are, where abs(freq - (detuneRatio * freq)) is the max detuning
in hertz. Here, detuneRatio = 1 gives no detuning.

This SynthDef isn't an exact copy of the Roland supersaw, but it is arguably a lot
more flexible, a superdupersaw, if you will. First of all, it allows you to select
any number of saws from 1 to 100, not just 7, using numOscs. Second, it lets you
determine the stereo spread of these saws with the spread control, and third, it
replaces Roland's blend control between a fundamental saw and its six detuned copies
with a detuneFade control. When detuneFade is 0, all copies have the same volume,
and as it gets higher the most detuned saws fade out more and more, for a more
natural sound (in my opinion).

This SynthDef also has the same envelope filter as midSideSaw.scd, that makes the
sound just a bit grittier. The .softclip after the filter is to vaguely emulate
certain filter circuits that, by nature of their design, distort a signal a tiny
bit as they filter it. If you don't want this, just set the preamp to below 1 but
above 0, as the distortion kicks in at around preamp = 1.

By Josh Mitchell August 2020
*/

SynthDef(\superSaw, {
	arg
	//Standard Values
	out = 0, pan = 0, gate = 1, amp = 0.5, freq = 40,
	att = 0.1, dec = 0.2, sus = 0.9, rel = 5, crv = 0,
	// Detune Controls (spread goes from 0 to 1)
	detuneRatio = 1.025, numberOscs = 100, spread = 1, detuneFade = 0.25,
	// Filter Controls (preamp > 0)
	filterLo = 80, filterHi = 8000, rq = 0.8, preamp = 2,
	fAtt = 3, fDec = 3, fSus = 0.8, fRel = 5;

	var detuneHz, stepSize, faArray, freqArray, ampArray, phaseArray, env, fEnv, snd;

	// Scale detuneRatio and numberOscs
	detuneHz = (detuneRatio - 1) * freq;
	stepSize = (2 * detuneHz)/(numberOscs - 1);

	// An Array used for freqArray and ampArray
	faArray = Array.fill2D(100, 2, {
		arg i, j;
		if (j == 1)
		{ (numberOscs - i).tanh.clip(0, 1).sign }
		{ ((stepSize * i) + (freq - detuneHz)).clip(20, 20000) }
	});
	faArray = faArray.scramble.flop;

	// Generate the Frequencies of all the Saws
	freqArray = faArray[0];

	// Generate the Amplitudes of all the Saws
	ampArray = abs(freq - freqArray);
	ampArray = (detuneHz - ampArray)/detuneHz;
	ampArray = ampArray.pow(detuneFade) * 0.1;
	ampArray = ampArray * faArray[1];

	// Generate the Phases of all the Saws
	phaseArray = {TRand.ar(
		lo: 0.000,
		hi: 2.000,
		trig: Impulse.ar(0))}.dup(100);

	// Envelopes for Volume and LPF
	env = Env.adsr(
		attackTime: att,
		decayTime: dec,
		sustainLevel: sus,
		releaseTime: rel,
		curve: crv).ar(doneAction: 2, gate: gate);
	fEnv = Env.adsr(
		attackTime: fAtt,
		decayTime: fDec,
		sustainLevel: fSus,
		releaseTime: fRel,
		curve: crv).ar(gate: gate);

	// Make the Saws
	snd = LFSaw.ar(
		freq: freqArray,
		iphase: phaseArray,
		mul: ampArray);
	snd = HPF.ar(
		in: snd,
		freq: freqArray);

	//Mix the Saws down to Stereo
	snd = Splay.ar(inArray: snd, spread: spread);
	snd = Normalizer.ar(
		in: snd,
		level: 1,
		dur: 0.02);

	// Filter the Saws
	snd = RLPF.ar(
		in: snd,
		freq: LinExp.ar(
			in: fEnv,
			srclo: 0, srchi: 1,
			dstlo: filterLo, dsthi: filterHi),
		rq: rq,
		mul: (preamp/2).clip(0.0001, inf));
	snd = snd.softclip;
	snd = snd/((preamp/2).clip(0.0001, inf).softclip);

	// Output Stuff
	snd = snd * amp * env;
	snd = Limiter.ar(snd);
	snd = Balance2.ar(
		left: snd[0],
		right: snd[1],
		pos: pan);

	Out.ar(out, snd);
},
metadata: (
	credit: "Josh Mitchell",
	category: \pads,
	tags: [\pitched]
	)
).add;
