/*
Trying to create a simple mid-sides converter (is that the right phrase?) in
SynthDef format. It makes some nice stereo sounds so far.

By Josh Mitchell July 2020.
*/

(
SynthDef(\midSidesSaw, {
	arg
	// Standard Values
	out = 0, amp = 1, gate = 1, freq = 100, pan = 0, att = 0.01, rel = 3, crv = 0,
	// fbEnv
	filterLo = 100, filterHi = 2000, rq = 0.3, msBalance = 0.5, beatHz = 1;

	var env, leftIn, rightIn, mid, sides, leftOut, rightOut, snd;

	// Envelope
	env = Env.perc(
		attackTime: att,
		releaseTime: rel,
		curve: crv).ar(doneAction: 2);

	//Stereo signal with beatings
	leftIn = LFSaw.ar(freq: freq + beatHz);
	rightIn = LFSaw.ar(freq: freq - beatHz);

	// L/R to M/S conversion
	mid = [leftIn, rightIn].mean;
	sides = [leftIn, -1 * rightIn].mean;

	// FX on the M/S signal
	mid = RLPF.ar(
		in: mid,
		freq: LinExp.ar(
			in: env,
			srclo: 0, srchi: 1,
			dstlo: filterLo, dsthi: filterHi),
		rq: rq);
	mid = mid * (1 - MouseX.kr(0, 1)) * env;

	sides = RLPF.ar(
		in: sides,
		freq: LinExp.ar(
			in: env,
			srclo: 0, srchi: 1,
			dstlo: filterHi, dsthi: filterLo),
		rq: rq);
	sides = sides * MouseX.kr(0, 1) * env;

	// Output Stuff and Converting Back to L/R
	leftOut = mid + sides;
	rightOut = mid - sides;
	snd = [leftOut, rightOut] * amp;
	snd = Limiter.ar(snd);

	Out.ar(out, snd);
},
metadata: (
	credit: "Josh Mitchell",
	category: \pads,
	tags: [\pitched]
	)
).add;
)

(
Pbindef( \midSidesSaw,
	\instrument, "midSidesSaw",
	\ctranspose, -12,
	\degree, Pseq([3, 5, 4, 4], inf),
	\dur, 2,
	\legato, 0.7,
).play;
)
Stethoscope.new