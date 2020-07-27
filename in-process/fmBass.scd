/*
In Process

By Josh Mitchell July 2020
*/
(
SynthDef(\fmBass, {
	arg
	//Standard Values
	out = 0, pan = 0, amp = 0.1, freq = 150, att = 0.0001, rel = 2, crv = -3,
	// Detune Controls (spread goes from 0 to 1)
	attFraction = 0.1, relFraction = 0.7, modIndex = 1500, modRatio = 1.2, subAmp = 0.75;

	var scale, mAtt, mRel, modulatorEnv, modulator, carrierEnv, carrier, snd;

	// Scale the att/rel for the Modulator
	scale = (attFraction + relFraction);
	scale = Select.kr(
		which: InRange.kr(
			in: scale,
			lo: 1,
			hi: inf),
		array: [
			DC.kr([attFraction, relFraction]),
			DC.kr([attFraction/scale, relFraction/scale])
	]);
	scale = scale * (att + rel);

	mAtt = scale[0];
	mRel = scale[1];

	// Modulator
	modulatorEnv = Env.perc(
		attackTime: mAtt,
		releaseTime: mRel,
		level: modIndex,
		curve: crv).ar;
	modulator = SinOsc.ar(
		freq: freq * modRatio,
		mul: modulatorEnv);

	// Carrier
	carrierEnv = Env.perc(
		attackTime: att,
		releaseTime: rel,
		curve: crv).ar(doneAction: 2);
	carrier = SinOsc.ar(
		freq: freq + modulator,
		mul: carrierEnv);

    // Add a Sub
	snd = carrier + SinOsc.ar(
		freq: freq/2,
		mul: carrierEnv * subAmp);

	// Output Stuff
	snd = snd * amp;
	snd = Limiter.ar(snd);

	Out.ar(out, Pan2.ar(snd));
},
metadata: (
	credit: "Josh Mitchell",
	category: \bass,
	tags: [\pitched, \fm]
	)
).add;
)

Synth(\fmBass);


