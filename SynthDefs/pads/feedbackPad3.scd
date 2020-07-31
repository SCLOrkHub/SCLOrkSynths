/*
There's an inherent delay that's large enough to matter any time you use LocalIn
and LocalOut for feedback, which I've forgotten about and then been reminded of
by unexpected noises quite a few times. Rather than get annoyed by this, I tried
gaining inspiration from it. For this SynthDef, I leaned into the discrete nature
of digital audio that causes those effects a bit more. This time,the feedback is
first downsampled by Latch.ar, at a frequency of sampleRate, then scaled and
rounded to a number of notes, all a specific number of semitones apart. This gets
put back into the frequency argument of the initial triangle wave, so that it's
generating an arpeggio from itself.   Whoa, that's deep.

The notes control is the number of notes in the arpeggio aside from the fundamental,
and if it's negative or not a whole number, it gets rounded into a positive whole
number. Interval is the equal distance between each note in semitones, but this
doesn't need to be a whole number.

After the feedback loop, the sound goes through some reverb to blend things together,
then a bit of filtering. First there's an HPF fixed at the fundamental frequency to
cut low frequency noise and slightly emphasise the fundamental. If you turn up the
resonance much more than where it's at, it can get ugly. Next, there's a few LPFs
that make a constant-enough dB/oct slope to take out some more high frequencies from
the sound.

By Josh Mitchell July 2020.
*/

SynthDef(\feedbackPad3, {
	arg
	// Standard Values
	out = 0, amp = 0.15, gate = 1, freq = 100, pan = 0,
	// Envelope Controls
	att = 3, dec = 1, sus = 1, rel = 5, crv = 0,
	// Reverb Controls (all go from 0 to 1)
	reverbMix = 0.75, roomSize = 0.9, damp = 0.5,
	// Other Controls (interval is in semitones)
	sampleRate = 20, notes = 6, interval = 7;

	var env, fbIn, snd;

	// Set up the Envelopes
	env = Env.adsr(
		attackTime: att,
		decayTime: dec,
		sustainLevel: sus,
		releaseTime: rel,
		curve: crv).ar(gate: gate);

	// Receive and Sample the feedback
	fbIn = Latch.ar(
		in: (LocalIn.ar + 1)/2,
		trig: Impulse.ar(
			freq: sampleRate));
	fbIn = (fbIn * notes.abs * env).round(1);
	fbIn = (fbIn * interval).midiratio;

	// Make The Sound
	snd = LFTri.ar(
		freq: freq * fbIn,
		mul: env);

	// Feedback the Sound
	LocalOut.ar(snd);

	// Reverb the Sound
	snd = FreeVerb.ar(
		in:  snd,
		mix: reverbMix,
		room: roomSize,
		damp: damp);

	//Filter the Sound
	snd = RHPF.ar(
		in: snd,
		freq: freq,
		rq: 0.5);
	snd = LPF.ar(
		in: snd,
		freq: [62, 125, 250, 500, 1000, 2000, 4000, 8000, 16000],
		mul: 1/9);

	// Output Stuff
	snd = Mix.ar(snd) * amp;
	snd = Limiter.ar(snd);

	DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Josh Mitchell",
	category: \pads,
	tags: [\pitched]
	)
).add;