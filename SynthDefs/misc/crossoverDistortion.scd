/*
Crossover distortion is a type of distortion present in class B amplifiers.
Here, the nonlinearity (a fancy word for distortion) is largest near the x axis,
as opposed to near the peaks of a waveform in regular distortion.
(wikipedia has lots more cool info if you're interested in this stuff)

This SynthDef combines crossover and regular distortion for a sputtery, gated,
almost metallic sound, something seen in a couple fuzz pedals.

For cleaner sounds, set preamp and nonlinearity low, and amp higher than normal.

By Josh Mitchell Jan 2020
*/

SynthDef("crossoverDistortion", {
    arg
	//Standard Values
	out = 0, pan = 0, freq = 160, amp = 1, att = 0.001, rel = 1, crv = -2,
    //Other controls, nonlinearity ranges from 0 to 1
	preamp = 1, nonlinearity = 0.75;

	var env, osc, snda, sndb, snd, nl;

	// Scales the nonlinearity control exponentially, making it more intuitive
	nl = 2.pow((nonlinearity.wrap(0, 1.0001)).range(-5, 5));

	// Simple envelope
	env = Env.perc(
		attackTime: att,
		releaseTime: rel,
		curve: crv).ar(doneAction: 2);

	// This is the signal going through the distortion section. Experiment here!
	osc = LFTri.ar(freq: freq, mul: env);

	// Split the signal into two sections to prep it for the distortion section
	snda = (Clip.ar(osc, 0, 1) * 2) - 1;
	sndb = (Clip.ar((-1 * osc), 0, 1) * 2) - 1;

	// Set the amplitude of the signal going into the transfer function
	snda = snda * preamp;
	sndb = sndb * preamp;

	// The transfer function:
	snda = 1/(1+(nl * snda * -1).exp);
	sndb = 1/(1+(nl * sndb * -1).exp);

	// Output stuff:
	snd = snda - sndb;
	snd = Mix.ar(snd) * amp;
	snd = Limiter.ar(snd);

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Josh Mitchell",
	category: \misc,
	tags: [\pitched, \noisy]
	)
).add;
