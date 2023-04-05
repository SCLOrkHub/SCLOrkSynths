/*
This is an attempt at making an electric guitar sound using Pluck.ar, as well as a couple
delay-based comb filters which roughly simulate some of the effects of changing pickup
placement and where on the string it's plucked. It still sounds a lot like Pluck and not
very much like a guitar, so I stuck some distortion on it to hide my mistakes a bit. That's
how guitar pedals work, right? (jk I think effects pedals are instruments in their own right)

Starting with the pick, I used Hasher.ar to provide the same initial noise for each pick,
but replacing that line with WhiteNoise.ar works fine. This then goes through the first
comb filter, which mutes certain frequencies based on pickPos. This is the pick position
from the bridge at 0 to the fret of the note being played at 1.

Next up is Pluck.ar, which makes the string sound, as well as a way of "muting" that string.
This is just a simple sustain-release envelope with a user-determined sustain time and a very
short release time, controlling a low pass filter for a slightly more natural-sounding cutoff.
I found it helpful in the demo, because two notes can't be played on the same string at once.
Setting a note to mute just before the next on plays seems convincing enough.

After this comes the pickup section. This guitar has only one pickup, and you can add more
if you like. First is another comb filter to mimic how pickup placement cuts some frequencies
and emphasizes others. Instead of pickupPos going from the bridge at 0 to the fretted note at
1, it goes to the nut of the guitar at 1, meaning openStringFreq plays a very small role in
the timbre of a note. Next is a resonant HPF and a steeper resonant LPF to mimic the frequency
response of a generalized pickup.

Finally, there's the distortion I mentioned above. It's got an HPF before the distortion and
an LPF after it, as is generally common in a lot of guitar distortion pedals.

By Josh Mitchell August 2020
*/

SynthDef(\distortedGuitar, {
	arg
	//Standard Values
	out = 0, pan = 0, amp = 0.1, freq = 220, rel = 4, crv = -3,
	// String and Plucking Hand Controls
	coef = 0.75, openStringFreq = 110, pickPos = 0.5, muteSus = 0.5,
	// Pickup Controls
	pickupPos = 0.17, pickupResfreq = 8000, pickupResrq = 0.5, pickupHPF = 250, pickupHPFrq = 0.8,
	// Distortion Controls
	preDistHPF = 600, postDistLPF = 2000, gain = 75;

	var mute, snd;

	// The Pick
	snd = Hasher.ar(Sweep.ar(Impulse.ar(0)));
	snd = snd - DelayN.ar(
		in: snd,
		maxdelaytime: pickPos.clip(0, 1)/freq,
		delaytime: pickPos.clip(0, 1)/freq);

	// The String
	snd = Pluck.ar(
		in: snd,
		trig: Impulse.ar(0),
		maxdelaytime: 1/freq,
		delaytime: 1/freq,
		decaytime: rel,
		coef: coef.clip(-1, 1));
	snd = LeakDC.ar(snd);

	// An Envelope for Muting the String
	mute = Env.new(
		levels: [1, 1, 0, 0],
		times: [muteSus, 0.075, 0.025]).ar(doneAction: 2);

	// Mute the String
	snd = snd * mute;
	snd = HPF.ar(
		in: snd,
		freq: LinExp.ar(
			in: mute,
			srclo: 0, srchi: 1,
			dstlo: 100, dsthi: 20));
	snd = LPF.ar(
		in: snd,
		freq: LinExp.ar(
			in: mute,
			srclo: 0, srchi: 1,
			dstlo: 20, dsthi: 10000));

	// The Pickup
	snd = snd - DelayN.ar(
		in: snd,
		maxdelaytime: pickupPos.clip(0, 1)/openStringFreq,
		delaytime: pickupPos.clip(0, 1)/openStringFreq);
	snd = RHPF.ar(
		in: snd,
		freq: pickupHPF,
		rq: pickupHPFrq);
	snd = BLowPass4.ar(
		in: snd,
		freq: pickupResfreq,
		rq: pickupResrq);

	snd = LeakDC.ar(snd);

	// The Distortion
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

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Josh Mitchell",
	category: \guitar,
	tags: [\pitched]
	)
).add;
