/*
Wavefolding is really fun. It's been a kinda big part of the history of west
coast synthesis, and you can make some nice, strange, alien tube noises with
it. It's very simple, too; it's pretty much just turning a waveform back
around when it hits a positive or negative edge.

This means it's simple enough to overdo a bit. I'm certainly guilty of that.
A saturating wavefolder can help fix that, though! All the "saturating" part
means is that you can set a limit so that the wave makes small turns back and
forth at the positive and negative edges of the wavefolder, instead of making
big turns across the entire area between these two edges.

Preamp affects the timbre of the sound, and limit is the limit I mentioned
above. Positive and negative values give slightly different results, and 0
turns the wavefolder into a regular old distortion like guitarists use.

I learned about saturating wavefolders at this helpful site:
https://ccrma.stanford.edu/~jatin/ComplexNonlinearities/Wavefolder.html

By Josh Mitchell June 2020.
*/

SynthDef("saturatingWavefolder", {
    arg
	// Standard Values
	out = 0, pan = 0, freq = 160, amp = 1, att = 0.001, rel = 0.7, crv = -2,
	// Other controls
	preamp = 20, limit = -0.2;

	var env, in, snd;

	// Envelope:
	env = Env.perc(
		attackTime: att,
		releaseTime: rel,
		level: preamp * pi/2,
		curve: crv).ar;

	// The sound being sent through everything:
	in = SinOsc.ar(freq: freq, mul: env);

	// The wavefolder:
	snd = SinOsc.ar(freq: 0, phase: in.mod(2pi)) * limit;
	snd = snd + in.tanh;

	// Output Stuff:
	snd = snd * 1/(1 + abs(limit)); //fix the volume
	snd = Mix.ar(snd) * amp;
	snd = Limiter.ar(snd);

	DetectSilence.ar(in: snd, doneAction: 2);

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Josh Mitchell",
	category: \misc,
	tags: [\pitched]
	)
).add;
