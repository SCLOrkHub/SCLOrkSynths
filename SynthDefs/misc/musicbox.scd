/*
This SynthDef is a haunted music box, done with modal synthesis. If you're interested,
check out modalmarimba.scd. Essentially, everything in the "Modal Stuff" section is
modeling a physical beam that's clamped at one end and hit at the other (just like the
tines in a real music box!)

The decay coefficient (decaycoef) does a lot to determine the timbre, position simulates
the position on the beam in which it's hit (0.5 is the middle), and slope is the db/oct
slope of a filter with a constant slope across the audio range.

The solutions to the dynamic beam equation (look up Euler-Bernoulli beam theory if you're
interested) are from Nathan Ho, as well as some of the methods I used for amparray.

Other Stuff: After the modal synthesis portion, There's a high pass filter to help the
music box sound more empty and haunted, an expander to alter the curve of the note
decay a bit, and freeverb, because a) it's metallic sounding, and b) reverb is spooky.

By Josh Mitchell June 2020.
*/

SynthDef(\musicbox, {
	arg
	// Standard values
	out = 0, freq = 1000, amp = 0.1, att = 0, dec = 1, rel = 3, pan = 0,
	// Other controls
	decaycoef = 0.25, slope = 3, filterfreq = 4000, expratio = 2,
	// These controls go from 0 to 1
	position = 0.1, thresh = 0.75, mix = 0.1, size = 0.6, revdamp = 0;

	var freqarray, amparray, decarray, exciter, snd;

// Modal Stuff:
	// Array of frequencies, determined by solutions to the dynamic beam equation
	freqarray = Array.fill(30, { arg i; i + 0.5});
        freqarray[0] = 0.59686416;
	    freqarray[1] = 1.49417561;
	    freqarray[2] = 2.50024695;
	    freqarray = freqarray/0.59686416; // Normalize to freqarray[0] = 1

	// Array of amplitudes
	amparray = Array.fill(30, { arg i;
		sin((i + 1) * position * pi) * // Models object being hit in a certain location
		(slope * (i + 1).log2).dbamp * // Models vibrations in object moving to the air
		(1 + exp(100 * (freqarray[i]-20000)))}); // Super steep LPF at 20000 hz

	// Array of Decay times
	decarray = Array.fill(30, { arg i;
		exp(-1 * i * decaycoef)}); // The decay times are dropping off exponentially

	// Hit the object
	exciter = Decay2.ar(
		in: Impulse.ar(0),
		attackTime: att,
		decayTime: dec);

	// Bank of resonators
	snd = DynKlank.ar(
		specificationsArrayRef: Ref.new([freqarray, amparray, decarray]),
		input: exciter,
		freqscale: freq,
		decayscale: rel);

// Other stuff:
	snd = Mix.ar(snd);
	// High pass filter to make it more lofi
	snd = HPF.ar(
		in: snd,
		freq: filterfreq);
	// Expander to cheaply alter the overall decay curve
	snd = CompanderD.ar(
		in: snd,
		thresh: thresh,
		slopeBelow: 1,
		slopeAbove: expratio);
	// Reverb for a more haunted, metalic sound
	snd = FreeVerb.ar(
		in: snd,
		mix: mix,
		room: size,
		damp: revdamp);
	snd = Limiter.ar(snd * amp);

	DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "by Josh Mitchell",
	category: \misc,
	tags: [\pitched, \modal]
)).add;