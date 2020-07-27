/*
In Process

This SynthDef is loosely based on the famous "supersaw" from the Roland JP-80x0
synths. The supersaw sound is very common in 2000s-or-so EDM, and in the case of
the Roland supersaw, is built around a model for 7 detuned saw waves with (as far
as I know) randomly determined phases.

This SynthDef isn't an exact copy of the Roland supersaw, but it is arguably a lot
more flexible. First of all, it allows you to select any number of saws from 1 to
81, not just 7. Second, it lets you determine the stereo spread of these saws with
the spread control, and third, it replaces Roland's blend control between a
fundamental saw and its six detuned copies with a detuneFade control. When
detuneFade is 0, all copies have the same volume, and as it gets higher the most
detuned saws fade out more and more, for a more natural sound (in my opinion).

This SynthDef also has the same envelope filter as midSideSaw.scd that makes the
sound just a bit classier. The .softclip after the filter is to vaguely emulate
certain analog filter circuits that, by nature of their design, distort a signal
a tiny bit as they filter it. (For reference, one that I like is in the korg MS20).
If you don't want this, just set the preamp low but not at O; around 0.1 should be
more than enough.

By Josh Mitchell July 2020
*/
(
SynthDef(\superSaw, {
	arg
	//Standard Values
	out = 0, pan = 0, amp = 0.5, freq = 40,
	att = 0.5, dec = 0.2, sus = 0.9, rel = 5, crv = 0,
	// Detune Controls (spread goes from 0 to 1)
	detuneRatio = 1.025, numberOscs = 21, spread = 1, detuneFade = 0.25,
	// Filter Controls (preamp > 0)
	filterLo = 80, filterHi = 8000, rq = 0.8, preamp = 7.5,
	fAtt = 5, fDec = 5, fSus = 0.8, fRel = 5;

	var detuneHz, stepSize, freqArray, ampArray, phaseArray, env, fEnv, snd;

	// Scale detuneRatio and numberOscs
	detuneHz = (detuneRatio - 1) * freq;
	stepSize = (2 * detuneHz)/(numberOscs - 1);

	// Generate the Freqs of all the Saws
	freqArray = Array.series(size: 81, start: 0, step: stepSize);
	freqArray = freqArray[0..20];
	freqArray = freqArray + (freq - detuneHz);
	freqArray = freqArray.scramble;

	ampArray = abs(freq - freqArray);
	ampArray = (detuneHz - ampArray)/detuneHz;
	ampArray = ampArray.pow(detuneFade) * 0.1;

	// Generate the Phases of all the Saws
	phaseArray = {TRand.ar(
		lo: 0.000,
		hi: 2.000,
		trig: Impulse.ar(0))}.dup(21);

	// Envelopes for Volume and LPF
	env = Env.adsr(
		attackTime: att,
		decayTime: dec,
		sustainLevel: sus,
		releaseTime: rel,
		curve: crv).ar(doneAction: 2);
	fEnv = Env.adsr(
		attackTime: fAtt,
		decayTime: fDec,
		sustainLevel: fSus,
		releaseTime: fRel,
		curve: crv).ar(doneAction: 2);

	// Make the Saws
	snd = LFSaw.ar(
		freq: freqArray,
		iphase: phaseArray,
		mul: ampArray * 1.01.pow(numberOscs));
	snd = HPF.ar(
		in: snd,
		freq: freqArray);

	//Mix the Saws down to Stereo
	snd = Splay.ar(inArray: snd, spread: spread);

	// Filter the Saws
	snd = RLPF.ar(
		in: snd,
		freq: LinExp.ar(
			in: fEnv,
			srclo: 0, srchi: 1,
			dstlo: filterLo, dsthi: filterHi),
		rq: rq,
		mul: preamp.clip(0.0001, inf));
	snd = snd.softclip;
	snd = snd/(preamp.clip(0.0001, inf).softclip);

	// Output Stuff
	snd = snd * amp * env;
	snd = Limiter.ar(snd);
	snd = XFade2.ar(
		inA: [snd[0], DC.ar(0)],
		inB: [DC.ar(0), snd[1]],
		pan: pan);

	Out.ar(out, snd);
},
metadata: (
	credit: "Josh Mitchell",
	category: \pads,
	tags: [\pitched]
	)
).add;
)

Synth(\superSaw);
FreqScope.new;

    ~detuneHz = (1.01 - 1) * 300;
	~stepSize = (2 * ~detuneHz)/(11 - 1);
    ~freqArray = Array.series(size: 81, start: 0, step: ~stepSize);
	~freqArray = ~freqArray[0..10];
	~freqArray = ~freqArray + (300 - ~detuneHz);
	~freqArray = ~freqArray.scramble;

	~ampArray = abs(300 - ~freqArray);
    ~ampArray = (~detuneHz - ~ampArray)/~detuneHz;
	~array = ~ampArray.pow(5);

