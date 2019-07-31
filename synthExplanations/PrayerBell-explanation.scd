// PrayerBell is made of two main parts (variables): input and snd.
//
// input is made of mallet + sing.
// mallet is a single-sample impulse.
// sing is heavily filtered pink noise.
// mallet and sing are combined to form 'input'
//
// if sing_switch is 0, only one impulse will excite the filter
// if sing_switch is more than 0, bell will not decay (like singing bowls)
//
// input is the excitation input to the resonant filter bank DynKlank (snd).
// DynKlank has a bunch of freqs, amps, decays. First two freqs are longest.


// breakdown #1
(
{ arg sing_switch = 0.5;
	var sing =
	sing = LPF.ar(
		in: {PinkNoise.ar * Integrator.kr(sing_switch * 0.001, 0.999).linexp(0, 1, 0.01, 1)} ! 2,
		freq: 2434 * 1
	);
	sing = sing + Dust.ar(0.1);
}.play
)

// breakdown #2
(
{ arg sing_switch = 0.5;
	var sing =
	sing = LPF.ar(
		in: {PinkNoise.ar * Integrator.kr(sing_switch * 0.001, 0.999).linexp(0, 1, 0.01, 1)} ! 2,
		freq: 2434 * 1
	);
	sing = sing + Dust.ar(0.1);
	sing = LPF.ar(sing, 10000);
}.play
)


// breakdown #3
(
{ arg sing_switch = 0;
	var sing =
	sing = LPF.ar(
		in: {PinkNoise.ar * Integrator.kr(sing_switch * 0.001, 0.999).linexp(0, 1, 0.01, 1)} ! 2,
		freq: 2434 * 1
	);
	sing = sing + Dust.ar(0.1);
	sing = LPF.ar(sing, 10000);
	sing = sing * LFNoise1.kr(0.5).range(-45, -30).dbamp;
	// a very soft, inaudible signal, filtered pink noise with a randomized amp envelope up and down between 0.005 and 0.03
}.play
)


// breakdown #4 - the 'mallet' part
// outputs a single-sample trigger at the level of t_trig argument
(
{
	// Trig at work (basic example)
	var mallet = LPF.ar(
		in: Trig.ar(
			in: Impulse.ar(0.5),
			dur: 1, //SampleDur.ir is too short to see with poll
		),
		freq: 10000;
	).poll;
}.play;
)


// breakdown #5
// combining mallet and sing (it's just the 'excitation signal', which will be the input to a a DynKlank UGen)
(
{ arg sing_switch = 0;
	var mallet = LPF.ar(
		in: Trig.ar(
			in: Impulse.ar(0.5),
			dur: SampleDur.ir //is too short to see with poll
		),
		freq: 10000;
	);

	var sing =
	sing = LPF.ar(
		in: {PinkNoise.ar * Integrator.kr(sing_switch * 0.001, 0.999).linexp(0, 1, 0.01, 1)} ! 2,
		freq: 2434 * 1
	);
	sing = sing + Dust.ar(0.1);
	sing = LPF.ar(sing, 10000);
	sing = sing * LFNoise1.kr(0.5).range(-45, -30).dbamp;
	// a very soft, inaudible signal, filtered pink noise with a randomized amp envelope up and down between 0.005 and 0.03


	mallet + (sing_switch.clip(0, 1) * sing);

}.play
)


// breakdown #6
// combining input and DynKlank
// using only 3 filter freqs for a simple demo
(
{ arg sing_switch = 0;
	var snd, input, freqscale = 2, first;
	var mallet = LPF.ar(
		in: Trig.ar(
			in: Impulse.ar(0) * 0.1, // just one trigger, and soft
			dur: SampleDur.ir //is too short to see with poll
		),
		freq: 10000;
	);

	var sing =
	sing = LPF.ar(
		in: {PinkNoise.ar * Integrator.kr(sing_switch * 0.001, 0.999).linexp(0, 1, 0.01, 1)} ! 2,
		freq: 2434 * 1
	);
	sing = sing + Dust.ar(0.1);
	sing = LPF.ar(sing, 10000);
	sing = sing * LFNoise1.kr(0.5).range(-45, -30).dbamp;
	// a very soft, inaudible signal, filtered pink noise with a randomized amp envelope up and down between 0.005 and 0.03

	// if sing_switch is 0, only mallet hit excites DynKlank.
	// if sing_switch is >0, DynKlank will receive continuous input (singing bell)
	input = mallet + (sing_switch.clip(0, 1) * sing).poll;




	snd = DynKlank.ar(
		specificationsArrayRef: `[
			// Array of filter frequencies
			[
				// first freq here is oscillating within a narrow range
				// with a bit of downward glissando (Line.kr 20 Hz over 0.5 seconds);
				(first = LFNoise1.kr(0.5).range(2424, 2444)) + Line.kr(20, 0, 0.5),
				// second freq is like first, but with a random offset of 1-3 Hz
				// (thus lots of beating effect)
				first + LFNoise1.kr(0.5).range(1,3),
				// third freq is oscillating in a higher freq range (with similar gliss trick)
				LFNoise1.kr(1.5).range(5435, 5440) - Line.kr(35, 0, 1),
			],
			// Array of filter amplitudes
			[
				// amps oscillate randomly within given ranges
				LFNoise1.kr(1).range(-10, -5).dbamp,
				LFNoise1.kr(1).range(-20, -10).dbamp,
				LFNoise1.kr(1).range(-12, -6).dbamp,
			],
			// Array of filter decay times
			[
				20 * freqscale.pow(0.2), // higher freq = longer decay, lower freq = shorter decay
				20 * freqscale.pow(0.2),
				5 // from third onward notice how decay times are significantly shorter
			] * freqscale.reciprocal.pow(0.5) // a lower bell (lower main freq) will last longer than a higher bell
		],
		input: input,
		freqscale: freqscale,
		freqoffset: 0,
		decayscale: 1
	);
}.play
);










































sing = LPF.ar(
	LPF.ar(
		in:
		{
			PinkNoise.ar * Integrator.kr(sing_switch * 0.001, 0.999).linexp(0, 1, 0.01, 1) * amp
		} ! 2,
		freq: 2434 * freqscale
	)
	+ Dust.ar(0.1), 10000 * freqscale
) * LFNoise1.kr(0.5).range(-45, -30).dbamp;
input = mallet + (sing_switch.clip(0, 1) * sing);




FreqScope.new;

// used as an envelope
{ Integrator.ar(LFPulse.ar(3, 0.2, 0.0004), 0.999, FSinOsc.ar(700), 0) }.play


// scope

{ Integrator.ar(LFPulse.ar(1500 / 4, 0.2, 0.1), MouseX.kr(0.01, 0.999, 1)) }.scope