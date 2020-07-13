/*
In Process snare drum using a shortcut for the resonant modes of a square-shaped membrane.
get it? square drum?
*/

(
SynthDef(\squareDrum, {
	arg
	// Standard values
	out = 0, freq = 180, amp = 1, att = 0.001, hold = 0, dec = 0.01, rel = 0.3, pan = 0, rq = 0.5,
	// Other controls
	stretch = 1.0001, decaycoef = 0.2, position = 0.414, slope = 3, headAmp = 0.5, rattleAmp = 0.5,
	followerAtt = 0.005, followerRel = 0.05, thresh = 0.25, tighten = 0.5;

	var exciter, freqarray, amparray, decarray, head, rattle, snd;

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
		(slope * (freqarray[i]).log2).dbamp *
		(1 + exp(100 * (freqarray[i]-20000)))
	});

	decarray = Array.fill(36, {
		arg i;
		exp(-1 * i * decaycoef)
	});
	decarray = decarray/decarray[0];

	exciter = Decay2.ar(
		in: Impulse.ar(0),
		attackTime: att,
		decayTime: dec);

	head = DynKlank.ar(
		specificationsArrayRef:
		    Ref.new([freqarray, amparray, decarray]),
		input: exciter,
		freqscale: freq,
		decayscale: rel
	);

	rattle = Amplitude.ar(
		in: head,
		attackTime: followerAtt,
		releaseTime: followerRel);
	rattle = PinkNoise.ar(rattle);

	rattle = CompanderD.ar(
		in: rattle,
		thresh: thresh,
		slopeBelow: 1 + tighten);

	rattle = BRF.ar(
		in: rattle,
		freq: freqarray[1..6],
		rq: rq);

	snd = (head * headAmp) + (rattle * rattleAmp);
	snd = Mix.ar(snd * 0.005);

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

Synth(\squareDrum);

