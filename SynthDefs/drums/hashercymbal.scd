/*
Here's yet another cymbal synthdef. This one's kind of cool in that it uses a
hash function to generate a really small chunk of sampled noise, which repeats
with a frequency set by looprate. Then, this just gets sampled at a lower rate
than supercollider's internal sample rate (see the decimator SynthDef for more
on that), and sent through a high pass filter with a fairly smooth slope across
most of the audible range of the sound.

The samplerate control seems to affect the pitch of the signal more directly than
the looprate control, but they do interact a lot, so it's probably easiest to just
play around with both of these controls.

The timbre control just alters the values the hash function sees, causing a slight
change in timbre. If it's changed continually during a note, you can get some
interesting noises.

By Josh Mitchell June 2020
*/

SynthDef("hashercymbal", {
    arg
	//Standard Values
	out = 0, pan = 0, amp = 0.1, att = 0.001, rel = 0.25, crv = -6,
    //Other controls
	timbre = 0, looprate = 10000, samplerate = 18500;

	var env, snd;

	// Envelope
	env = Env.perc(
		attackTime: att,
		releaseTime: rel,
		level: amp,
		curve: crv).ar(doneAction: 2);

	// Generating a loop of the same scrambled values to use as a noise source
	snd = Impulse.ar(freq: looprate, mul: 2, add: -1);
	snd = Sweep.ar(snd) + timbre;
	snd = Hasher.ar(in: snd);

	// Aliasing the noise and filtering out low frequencies
	snd = Latch.ar(
		in: snd,
		trig: Impulse.ar(
			freq: samplerate.clip(20, SampleRate.ir/2),
			mul: 2,
			add: -1));
	snd = HPF.ar(
		in: snd,
		freq: [62, 125, 250, 500, 1000, 2000, 4000, 8000, 16000],
		mul: [1/9, 2/9, 3/9, 4/9, 5/9, 6/9, 7/9, 8/9, 9/9]);

	// Output stuff
	snd = Mix.ar(snd) * env;
	snd = Limiter.ar(snd);

	Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Josh Mitchell",
	category: \drums,
	tags: [\unpitched, \cymbal, \noisy]
	)
).add;