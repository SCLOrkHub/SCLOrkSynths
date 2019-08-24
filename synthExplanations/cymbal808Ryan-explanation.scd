

// BinaryOpUGen('==', a, b) compares two signals.
// While the two signals are not at same value,
// output is zero. When they happen to be the same,
// output is 1.
(
{
    var a = DC.ar(0.7);
	var b = SinOsc.ar(1).round(0.1);
    x = BinaryOpUGen('==', a, b);
	[a, b, x];
}.plot(1);
)

// The sum (mix) of 6 LFPulses results in a complex wave
// with an output range between 0 and +6.
(
{
	var freqs = [205.35, 304.41, 369.64, 522.71, 540.54, 812.21];
	var snd = Mix.ar(LFPulse.ar(freq: freqs * 4.09));
	snd;
}.plot;
)


// Here's a single BinaryOpUGen at work
// (just the first one from the original code)
// Whenever complex wave is equal to 6, BinaryOpUGen
// sends out a 1 (otherwise always zero).
(
{
	var freqs = [205.35, 304.41, 369.64, 522.71, 540.54, 812.21];
	var snd = Mix.ar(LFPulse.ar(freq: freqs * 4.09));
	snd = BinaryOpUGen('==', snd, 6.0);
	snd;
}.plot;
)

// Here are all the BinaryOpUGens from the original,
// including their scaling.
// When 0.6 shows up in the plot, it means the original
// signal had reached 6.0 at that time.
// When 0.2 shows up in the plot, it means the original
// signal had reached 2.0 at that time.
// When 0.9 shows up in the plot, it means the original
// signal had reached 1.0 at that time.
(
{
	var freqs = [205.35, 304.41, 369.64, 522.71, 540.54, 812.21];
	var snd = Mix.ar(LFPulse.ar(freq: freqs * 4.09));

	snd =
	(BinaryOpUGen('==', snd, 6.0) * 0.6)
	+
	(BinaryOpUGen('==', snd, 2.0) * 0.2)
	+
	(BinaryOpUGen('==', snd, 1.0) * 0.9);

	snd;
}.plot;
)

// Listen to how this sounds if played through speakers:
(
{
	var freqs = [205.35, 304.41, 369.64, 522.71, 540.54, 812.21];
	var snd = Mix.ar(LFPulse.ar(freq: freqs * 4.09));

	snd =
	(BinaryOpUGen('==', snd, 6.0) * 0.6)
	+
	(BinaryOpUGen('==', snd, 2.0) * 0.2)
	+
	(BinaryOpUGen('==', snd, 1.0) * 0.9);

	snd * 0.1; // careful, really loud
}.scope;
)

FreqScope.new;



// Here's the variable pulseEnv from the original:
// just a line ramping down from 1 to 0.6:
(
Env.new(
		levels: [1.0, 0.6],
		times: 0.25,
		curve: -0.5
	).plot;
)

// Apply pulseEnv to the noisy snd from above:

(
{
	var freqs = [205.35, 304.41, 369.64, 522.71, 540.54, 812.21];
	var snd = Mix.ar(LFPulse.ar(freq: freqs * 4.09));
	var pulseEnv = Env.new(
		levels: [1.0, 0.6],
		times: 0.25,
		curve: -0.5
	).kr;

	snd =
	(BinaryOpUGen('==', snd, 6.0) * 0.6)
	+
	(BinaryOpUGen('==', snd, 2.0) * 0.2)
	+
	(BinaryOpUGen('==', snd, 1.0) * 0.9);

	snd * pulseEnv * 0.1; // careful, really loud
}.play;
)


// This is then mixed with another set of LFPulses
// but at the original freqs in the Array (note that above
// the freqs are multiplied by 4.09)

// Here's it first in isolation (reduced amp here):

(
{
	var freqs = [205.35, 304.41, 369.64, 522.71, 540.54, 812.21];
	Mix.ar(LFPulse.ar(freq: freqs, width: 0.55, mul: 0.1))
}.play;
)

// here's in context:
(
{
	var freqs = [205.35, 304.41, 369.64, 522.71, 540.54, 812.21];
	var snd = Mix.ar(LFPulse.ar(freq: freqs * 4.09));
	var pulseEnv = Env.new(
		levels: [1.0, 0.6],
		times: 0.25,
		curve: -0.5
	).kr;

	snd =
	(BinaryOpUGen('==', snd, 6.0) * 0.6)
	+
	(BinaryOpUGen('==', snd, 2.0) * 0.2)
	+
	(BinaryOpUGen('==', snd, 1.0) * 0.9);

	snd = snd * pulseEnv;

	snd = snd + Mix.ar(LFPulse.ar(freq: freqs, width: 0.55, mul: 0.9));

	snd * 0.1;
}.play;
)


// Now add the filters, one by one.
// This is where the magic happens
// (comment them out one by one one):
(
{
	var freqs = [205.35, 304.41, 369.64, 522.71, 540.54, 812.21];
	var snd = Mix.ar(LFPulse.ar(freq: freqs * 4.09));
	var pulseEnv = Env.new(
		levels: [1.0, 0.6],
		times: 0.25,
		curve: -0.5
	).kr;

	snd =
	(BinaryOpUGen('==', snd, 6.0) * 0.6)
	+
	(BinaryOpUGen('==', snd, 2.0) * 0.2)
	+
	(BinaryOpUGen('==', snd, 1.0) * 0.9);

	snd = snd * pulseEnv;

	snd = snd + Mix.ar(LFPulse.ar(freq: freqs, width: 0.55, mul: 0.9));

	// comment these out one by one, play again each time:
	// snd = RLPF.ar(in: snd, freq: 7000, rq: 0.6);
	// snd = RHPF.ar(in: snd, freq: 6800, rq: 1.5);
	// snd = RHPF.ar(in: snd, freq: 6800, rq: 1.5);
	// snd = RHPF.ar(in: snd, freq: 1200, rq: 1.5);

	snd * 0.1;
}.play;
)

