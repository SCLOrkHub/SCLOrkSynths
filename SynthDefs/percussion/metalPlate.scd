/*
This SynthDef is a modal model for a rectangular plate held fixed at all edges,
or "clamped." I think it sounds very metallic in general, so it'd probably make
a nice strange cymbal.

The timbre of the plate is mostly determined by ratio and decCoef. A higher value
for decCoef makes the decay times of longer notes shorter, so you don't hear them
as well beyond the initial attack of the note. Meanwhile, ratio controlls the
relative shape of the rectangular plate, from narrow near 0 to square at 1. It's
called ratio because it's the ratio of the short side to the long one. Values of
ratio greater than 1 are probably okay, but they could be very out of tune or have
mangled low notes. Changing ratio from note to note gives an FM-like effect.

Where on the plate it's hit is determined by xpos and ypos, using the same 1d
"position" argument in two different dimensions. As far as I can tell, xpos is
along the short side and ypos is along the long side.

Finally, I added thumpDec to control the decay time of a harmonic we percieve to
be below the fundamental "pitch" of the plate, for a bit of controllable
percussive emphasis. Finally, there's a cheaply done filter with a roughly
constant, positive db/oct slope to emphasise higher harmonics a bit more, which
helps highlight some of the metallic parts of the SynthDef.

By Josh Mitchell August 2020.
*/

SynthDef(\metalPlate, {
	arg
	// Standard values
	out = 0, freq = 3000, amp = 0.5, rel = 2, pan = 0, crv = 0,
	// Other controls (ratio goes from >0 to 1)
	ratio = 1, decCoef = 0.31, xpos = 0.5, ypos = 0.5, thumpDec = 0.75;

	var exciter, freqArray, ampArray, decArray, snd;

	// Frequencies
	freqArray = Array.fill2D(16, 16, {
		arg i, j;
		(i + 1).pow(2) + (ratio * (j + 1)).pow(2)
	});
	freqArray = freqArray/(freqArray[0][1]);
	freqArray = freqArray * freq;

	// Amplitudes
	ampArray = Array.fill2D(16, 16, {
		arg i, j;
		((1 - ((freqArray[i][j] - 19000)/1000).tanh)/2) *
		sin(((i + 1) * pi) * xpos) *
		sin(((j + 1) * pi) * ypos)
	});

	// Decay Times
	decArray = Array.fill2D(16, 16, {
		arg i, j;
		(
			if (j == 0)
		        { thumpDec }
		        { 1 }
		) *
		exp(-1 * (i + j) * decCoef)
	});

	// Hit the plate
	exciter = Impulse.ar(0);

	// The Plate
	snd = Klank.ar(
		specificationsArrayRef:
		    Ref.new([freqArray.flatten, ampArray.flatten, decArray.flatten]),
		input: exciter,
		decayscale: rel);

	// Output Stuff
	snd = HPF.ar(
		in: snd,
		freq: [freq, freq * 2, freq * 4, freq * 8, freq * 16, freq * 32, freq * 64]);
	snd = Mix.ar(snd/7) * amp;
	snd = Limiter.ar(snd);

	DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "by Josh Mitchell",
	category: \percussion,
	tags: [\pitched, \modal]
)
).add;