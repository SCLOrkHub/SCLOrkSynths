/*
A somewhat messy template I've made for myself for working with modal
synthesis. A huge majority of the information in here comes from Nathan Ho,
especially here: https://nathan.ho.name/posts/exploring-modal-synthesis/
*/

(
SynthDef(\modaltemplate, {
	arg
	// Standard values
	out = 0, freq = 440, amp = 0.1, att = 0.001, hold = 0, dec = 0.1, rel = 5, pan = 0, crv = 0,
	// Other controls
	stretch = 1.0001, decaycoef = 2, position = 0.414, slope = 0.5, decayscale = 0;

	var exciter, freqarray, amparray, decarray, snd;

	freqarray = Array.fill(50, {
		arg i;
		(i + 1) * sqrt(1 + ((i + 1).pow(2) * stretch))
	});
	freqarray = freqarray/freqarray[0];

	amparray = Array.fill(50, {
		arg i;
		sin((i + 1) * position * pi) *
		(3 * (i + 1).log2).dbamp *
		(1 + exp(100 * (freqarray[i]-20000)))
	});

	decarray = Array.fill(50, {
		arg i;
		exp(-1 * i * decaycoef) + decayscale
	});
	decarray = decarray/decarray[0];

	exciter = Env.linen(
		attackTime: att,
		sustainTime: hold,
		releaseTime: dec,
		curve: crv).ar;

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
)

//Synth(\modaltemplate);

//FreqScope.new;
//Stethoscope.new;
