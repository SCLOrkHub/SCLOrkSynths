/*
An in-progress attempt at making guitar noises

By Josh Mitchell August 2020
*/
(
SynthDef(\pluckGuitar, {
	arg
	//Standard Values
	out = 0, pan = 0, amp = 0.1, freq = 220, rel = 4, crv = -3,
	// Other Controls
	coef = 0.5, notchDepth = 1, openString = 110, pup1Pos = 0.25, pup2Pos = 0.125,
	pickPos = 0.5, clampSus = 0.5, clampRel = 0.07, pup1Peak = 8000, pup2Peak = 6000,
	pup1Peakrq = 0.5, pup2rq = 0.5, pup1Mid = 1000, pup1Midrq = 2, pup1MiddB = 12,
	pup1Min = 250, pup1Minrq = 0.8, pup2Min = 330, pup2Minrq = 0.67, preDistHPF = 600,
	postDistLPF = 2000, gain = 75;

	var input, clamp, pluck, snd, pup1, pup2;

	input = WhiteNoise.ar;
	input = input - DelayN.ar(
		        in: input,
		        maxdelaytime: 1,
		        delaytime: (pickPos/freq),
		        mul: notchDepth);

	clamp = Env.new(
		levels: [1, 1, 0],
		times: [clampSus, clampRel]).ar(doneAction: 2);

	pluck = Pluck.ar(
		in: input,
		trig: Impulse.ar(0),
		maxdelaytime: 1/freq,
		delaytime: 1/freq,
		decaytime: rel,
		coef: coef.clip(-1, 1));
	pluck = LeakDC.ar(pluck);

	pup1 = pluck - DelayN.ar(
		        in: pluck,
		        maxdelaytime: 1,
		        delaytime: pup1Pos/openString,
		        mul: notchDepth);
	pup1 = RHPF.ar(
		in: pup1,
		freq: pup1Min,
		rq: pup1Minrq);
	pup1 = BLowPass4.ar(
		in: pup1,
		freq: pup1Peak,
		rq: pup1Peakrq);

	pup2 = pluck - DelayN.ar(
		        in: pluck,
		        maxdelaytime: 1,
		        delaytime: pup2Pos/openString,
		        mul: notchDepth);
	pup2 = RHPF.ar(
		in: pup2,
		freq: pup2Min,
		rq: pup2Minrq);
	pup2 = BLowPass4.ar(
		in: pup2,
		freq: pup2Peak,
		rq: pup2rq);

	snd = (pup1 + pup2)/2;
	snd = LeakDC.ar(snd);

	snd = snd * (clamp + 1)/2;
	snd = LPF.ar(
		in: snd,
		freq: LinExp.ar(
			in: clamp,
			srclo: 0, srchi: 1,
			dstlo: 20, dsthi: 10000));
	snd = HPF.ar(
		in: snd,
		freq: preDistHPF);
	snd = snd * gain;
	snd = snd.tanh;
	snd = LPF.ar(
		in: snd,
		freq: postDistLPF);

	// Output Stuff
	snd = snd * amp;
	snd = Limiter.ar(snd);

	DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, Pan2.ar(snd));
},
metadata: (
	credit: "Josh Mitchell",
	category: \inProcess,
	tags: [\pitched]
	)
).add;
)

(
Pbindef( \pluckGuitar,
	\instrument, "pluckGuitar",
	\ctranspose, -24,
	\amp, Pseq([Pseq([
		    0.1, 0.1, 0.1, 0.1, 0.1, 0, 0.1, 0.1,
		    0.1, 0.1, 0, 0.1, 0.1, 0, 0.1, 0.1],
	    4), 0.1]),
	\dur, 0.175,
	\strum, Pseq([1, -1], inf) * Pwhite(0.015, 0.03),
	\degree, Pstutter(8, Pseq([0, 3, 5, 4], 3) + [0, 4, 7]),
	\pup1Pos, Pstutter(8, Pwhite(0.01, 0.99)),
	\pup2Pos, Pstutter(8, Pwhite(0.01, 0.99)),
	\pickPos, Pwhite(0.2, 0.8),
	\clampSus, Pseq([Pseq([
		    0.15, 0.15, 0.15, 0.15, 0.25, 0, 0.15, 0.15,
		    0.15, 0.3, 0, 0.15, 0.2, 0, 0.15, 0.15],
	    4), 10])
).play;
)