/*
The work here is done through modal synthesis. The focus with modal synthesis is that any
object will vibrate at certain frequencies (modes), with certain amplitudes, and certain
decay times in a case where there's a damping force, for each of these modes. Here most of
the math for those modes is done in arrays, then plugged into DynKlank, along with a short
burst meant to simulate the object being hit.

The title of this synthdef says it's a marimba, but it can also be used to simulate a lot
of other idiophones, because it works on a very abstract model. Essentially, the harmonics
of the SynthDef have been determined by the harmonics of a vibrating beam (say, a long
rectangular prism), when it's hit by something. I find some of the math shortcuts pretty
funny; this particular beam is totally ignoring gravity, for example.

The decay coefficient (decaycoef) does a lot to determine the timbre, position simulates
the position on the beam in which it's hit (0.5 is the middle), and slope is the db/oct
slope of a filter with a constant slope across the audio range.

The solutions to the dynamic beam equation (look up Euler-Bernoulli beam theory if you're
interested) were given by Nathan Ho, as well as some of the methods I used for amparray.

By Josh Mitchell June 2020.
*/

SynthDef(\modalmarimba, {
	arg
	// Standard values
	out = 0, freq = 440, amp = 0.1, att = 0.001, dec = 0.1, rel = 0.5, pan = 0,
	// Other controls, position goes from 0 to 1
	decaycoef = 2, position = 0.414, slope = 3;

	var freqarray, amparray, decarray, mallet, snd;

	// Array of frequencies, determined by solutions to the dynamic beam equation
	freqarray = Array.fill(30, { arg i; i + 1.5});
        freqarray[0] = 1.50561873;
	    freqarray[1] = 2.49975267;
	    freqarray = freqarray/1.50561873; // Normalize to freqarray[0] = 1

	// Array of amplitudes
	amparray = Array.fill(30, { arg i;
		sin((i + 1) * position * pi) * // Models object being hit in a certain location
		(slope * (i + 1).log2).dbamp * // Models vibrations in object moving to the air
		(1 + exp(100 * (freqarray[i]-20000)))}); // Super steep LPF at 20000 hz

	// Array of Decay times
	decarray = Array.fill(30, { arg i;
		exp(-1 * i * decaycoef)}); // The decay times are dropping off exponentially

	// Hit the object
	mallet = Decay2.ar(
		in: Impulse.ar(0),
		attackTime: att,
		decayTime: dec);

	// Bank of resonators
	snd = DynKlank.ar(
		specificationsArrayRef: Ref.new([freqarray, amparray, decarray]),
		input: mallet,
		freqscale: freq,
		decayscale: rel);

	// Output stuff
	snd = Mix.ar(snd) * amp;
	snd = Limiter.ar(snd);
	DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "by Josh Mitchell",
	category: \percussion,
	tags: [\pitched, \modal]
)).add;