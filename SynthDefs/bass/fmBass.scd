/*
A lot of what's in here comes from the great Eli Fieldsteel's tutorials on how to
write an FM-based SynthDef (https://www.youtube.com/watch?v=UoXMUQIqFk4), so I'll
just describe the things I added beyond very a very basic sine wave FM synth.

First, the modulator and carrier are controlled by seperate envelopes, which allows
for a sort of envelope-filter-type sound as the modulation index is increased and
decreased. The attack and release times of this envelope can be shorter than the
carrier envelope. This allows, for example, a burst of high frequencies at the start
of a note paired with a long low frequency fade. When attFraction + relFraction is
less than or equal to one, they act as fractions of the total note time, and when
their sum is larger than 1, they get scaled down to add up to the total note time.

Next, the modulator is SinOscFB, and not SinOsc. This way, you can still get glassy,
clean sine wave FM sounds when the modFB is set to 0, but a little bit more grit from
the added frequencies as modFB is turned up. Lastly, I added a sub sine wave an
octave below the fundamental to ground the note a bit more to the fundamental. The
volume of this is controlled by subAmp, which is a fraction of the fundamental's
amplitude.

By Josh Mitchell July 2020
*/

SynthDef(\fmBass, {
	arg
	//Standard Values
	out = 0, pan = 0, amp = 0.1, freq = 150, att = 0.0005, rel = 1, crv = -3,
	// Other Controls
	attFraction = 0.05, relFraction = 0.7, modIndex = 500, modRatio = 1.51,
	subAmp = 0.75, modFB = 0.4;

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
	modulator = SinOscFB.ar(
		freq: freq * modRatio,
		feedback: modFB,
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
