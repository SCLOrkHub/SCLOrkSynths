/*
This is a snare drum using a shortcut for the resonant modes of a square-shaped membrane.

Get it? Square drum?

A common Problem in modal synthesis is how computationally expensive it is. Generating a
sound with 36 modes, for example (like below), takes a bank of 36 individual resonators.
Thanks to how simple Klank is to use, this doesn't look like a problem, but it can add
up fast. That's why this drum uses a square shape for the "drum head"; it can create more
higher-frequency modes with a smaller array than for a circle or other shape. This means
it's less computationally expensive for the same modes at the initial attack of the
virtual drum stick, at the cost of a tiny bit of accuracy to a physical snare drum.

decCoef determines some of the timbre of the head, and ampSlope is the constant slope
of a dB/oct filter.

A snare drum's snares themselves are really, really impractical to replicate in modal
synthesis. Because of this, I used PinkNoise and some filtering. The amplitude of this
pink noise is controlled by the amplitude of the drum head, similar to a real snare drum.
Next, I added some notches in the noise because real snares have notches in their
frequency spectrums. Rather than find new frequencies, I just reused some values from
freqArray.

The envelope follower sending the amplitude of the drum head to the snares is controlled
by followAtt and followRel, and because the snares rang out too much for my liking, I
added a noise gate controlled by snareGate (the amount of gating) and thresh, (the
threshold of the gate).

By Josh Mitchell July 2020.
*/

SynthDef(\squareDrum, {
	arg
	// Standard values
	out = 0, freq = 180, amp = 0.6, pan = 0,
	// Stick Controls
	att = 0.001, dec = 0.01,
	// Head Controls
	headAmp = 0.5, decCoef = 0.175, ampSlope = 3, rel = 0.2,
	// Snares Controls (thresh goes from 0 to 1)
	snaresAmp = 0.65, followAtt = 0.005, followRel = 0.075, thresh = 0.25,
	snareGate = 0.6, rq = 0.5;

	var freqarray, amparray, decarray, stick, head, snares, snd;

	// Setting up arrays for Klank
	freqarray = Array.fill(8, {
		arg i = 1;
		(
			Array.fill((i + 1), {
				arg j;
				(j + 1).pow(2)
			}) +
			(i + 1).pow(2)
		).sqrt

	});
	freqarray = freqarray.flatten/(2.sqrt);

	amparray = Array.fill(36, {
		arg i;
		if (freqarray[i] > 20000)
			{ 0 }
			{
		        (ampSlope * (freqarray[i]).log2).dbamp
		    }
	});
	amparray = amparray/amparray.max;

	decarray = Array.fill(36, {
		arg i;
		exp(-1 * i * decCoef)
	});
	decarray = decarray/decarray[0];

	// Drumstick
	stick = Decay2.ar(
		in: Impulse.ar(0),
		attackTime: att,
		decayTime: dec,
		mul: 0.005); // This keeps the volume at a sane level

	// Drum Head
	head = Klank.ar(
		specificationsArrayRef:
		    Ref.new([freqarray, amparray, decarray]),
		input: stick,
		freqscale: freq,
		decayscale: rel);

	// Snares
	snares = PinkNoise.ar(
		Amplitude.ar(
		    in: head,
		    attackTime: followAtt,
		    releaseTime: followRel));
	snares = CompanderD.ar(
		in: snares,
		thresh: thresh,
		slopeBelow: 1 + snareGate.clip(0, inf));
	snares = BRF.ar(
		in: snares,
		freq: freqarray[1..6],
		rq: rq);

	//Output Stuff
	snd = (head * headAmp) + (snares * snaresAmp);
	snd = Mix.ar(snd * amp);
	snd = Limiter.ar(snd);

	DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "by Josh Mitchell",
	category: \drums,
	tags: [\unpitched, \snare, \modal]
)
).add;
