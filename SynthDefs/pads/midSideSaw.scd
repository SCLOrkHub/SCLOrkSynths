/*
Here's a simple way to do mid/side processing in a SynthDef format. Mid/side
processing splits a stereo signal into two new pieces; instead of a left and
right channel, you now have a channel full of the same parts between the left
and right (mid), and a channel full of the different parts (sides). You can
then do whatever you want to these mid/side channels before converting them
back to left and right channels.

Mid/side processing is often used for subtle polishing in music production,
but you can get some interesting sounds if you're creative with it. I like
how it adds a sort of "mirrored" stereo image; to me it makes a sound seem
like it's wrapped a little bit closer around my ears.

Here the initial sound is a sort-of-chorused stereo saw, made with two saw
waves with vibrato LFOs that are perfectly out of phase with each other.
Then, there's an envelope filter on the mid and side channels, with a little
distortion after each.

Finally, I've added a balance control that pans from only sending the mid
at 0 to only sending the sides at 1. monoSwitch outputs only a mono channel
if it's set to 1, so that you can clearly hear what's in the mid channel and
what's in the side channel without any stereo shenanigans.

By Josh Mitchell July 2020.
*/

SynthDef(\midSideSaw, {
	arg
	// Standard Values
	out = 0, amp = 1, gate = 1, freq = 100, pan = 0, att = 0.25, rel = 3, crv = 0,
	// Filter and Distortion Controls
	filterLo = 100, filterHi = 2000, rq = 0.3, sidePreamp = 2, midPreamp = 1,
	// Chorus and Mid/Side Controls (balance is 0 to 1 and monoSwitch is 0 or 1)
	lfoFreq = 0.1, lfoDepth = 0.015, balance = 0.5, monoSwitch = 0;

	var env, lfo, leftIn, rightIn, mid, side, leftOut, rightOut, snd;

	// Envelope and LFO
	env = Env.perc(
		attackTime: att,
		releaseTime: rel,
		curve: crv).ar(doneAction: 2);

	lfo = SinOsc.ar(
		freq: lfoFreq,
		phase: [0, pi]);
	lfo = lfo.range(1 - lfoDepth, 1 + lfoDepth);

	//Stereo signal with beatings
	leftIn = LFSaw.ar(freq: freq * lfo[0]);
	rightIn = LFSaw.ar(freq: freq * lfo[1]);

	// L/R to M/S conversion
	mid = (leftIn + rightIn)/2;
	side = (leftIn - rightIn)/2;

	// FX on the M/S signal
	mid = RLPF.ar(
		in: mid,
		freq: LinExp.ar(
			in: env,
			srclo: 0, srchi: 1,
			dstlo: filterLo, dsthi: filterHi),
		rq: rq,
		mul: midPreamp);
	mid = mid.softclip/midPreamp.softclip;
	mid = mid * (1 - balance).clip(0, 1) * env;

	side = RLPF.ar(
		in: side,
		freq: LinExp.ar(
			in: env,
			srclo: 0, srchi: 1,
			dstlo: filterHi, dsthi: filterLo),
		rq: rq,
		mul: sidePreamp);
	side = side.softclip/sidePreamp.softclip;
	side = side * balance.clip(0, 1) * env;

	// Output Stuff and Converting Back to L/R
	leftOut = mid + side;
	rightOut = mid - side;
	snd = Select.ar(
		which: monoSwitch,
		array: [
			[leftOut, rightOut],
			Pan2.ar(leftOut, pan)]);
	snd = snd * amp;
	snd = Limiter.ar(snd);

	Out.ar(out, snd);
},
metadata: (
	credit: "Josh Mitchell",
	category: \pads,
	tags: [\pitched]
	)
).add;
