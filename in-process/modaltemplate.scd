/*
A somewhat messy template I've made for myself for working with modal
synthesis. A huge majority of the information in here comes from Nathan Ho,
especially here: https://nathan.ho.name/posts/exploring-modal-synthesis/
The freqarray formula I'm using right now comes from the Mutable Instruments
Elements module, and I learned it through Nathan Ho's site above.
*/

SynthDef(\modaltemplate, {
	arg
	// Standard values
	out = 0, freq = 220, amp = 0.1, att = 0.001, rel = 0.7, pan = 0, crv = -8,
	// Other controls
	stretch = 1.001, deck = 0.5, decm = 2e-8, decf = 0, position = 0.414;

	var exciter, freqarray, amparray, decarray, snd;

	freqarray = Array.fill(16, {
		arg i;
		(i + 1) * (1 + (i * stretch))
	});

	amparray = Array.fill(16, {
		arg i;
		sin((i + 1) * position * pi) * 2.pow(i/16) * 0.5
	});

	decarray = Array.fill(16, {
		arg i;
		1/(deck + (decm * freqarray[i] * freqarray[i]) + (decf * freq * freq))
	});

	exciter = SinOsc.ar(
		freq: Line.ar(SampleRate.ir/2, 0, att),
		mul: 0.1);

	snd = DynKlank.ar(
		specificationsArrayRef:
		    Ref.new([freqarray, amparray, decarray]),
		input: exciter,
		freqscale: freq,
		decayscale: rel
	);

	DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "by Josh Mitchell",
	category: \misc,
	tags: [\pitched, \modal]
)
).add;

//Synth(\modaltemplate);

//FreqScope.new;
//Stethoscope.new;