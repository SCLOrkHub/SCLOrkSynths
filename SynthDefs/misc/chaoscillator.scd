/*
I made a fun sound that replaces parts of a triangle wave with noise!

The noise is made with Hasher.ar and nyquist aliasing to make it sound
less whispery and more clangy.

Start with the default values and watch the waveform in Stethoscope.ar
to see what each control does, or just randomize 'em all.

By Josh Mitchell 9/19.
*/

SynthDef("chaoscillator", {
    arg
	//Standard Values
	out = 0, pan = 0, freq = 40, amp = 0.5, gate = 1, att = 0.01, rel = 1.5, curve = -4,
    //Other controls
	chaosUpStart = 0, chaosUpEnd = 0.5, chaosUpTime = 1,
	chaosDownStart = 0, chaosDownEnd = 0, chaosDownTime = 1,
	cutoff = 20000, reHashesPerCycle = 1, hashRate = 1, nyquist = 5000;

	var env, chaosRise, chaosFall, noisefunction, noise, switcha, switchb, shapea, shapeb, snd;

	//Envelopes for the signal and amount of noise on each half of the waveform
	env = Env.perc(attackTime: att, releaseTime: rel, level: amp, curve: curve).kr;
	chaosRise = Line.kr(start:  chaosUpStart,  end:  chaosUpEnd,  dur:  chaosUpTime );
	chaosFall = Line.kr(start: chaosDownStart, end: chaosDownEnd, dur: chaosDownTime);

	//Switches to decide whether section a or b gets played:
	switcha = LFPulse.ar(freq: freq, iphase:  0 );
	switchb = LFPulse.ar(freq: freq, iphase: 0.5);

	//Creating repeating loops of noise with Hasher.ar:
	noisefunction = Impulse.ar(freq: freq * reHashesPerCycle, mul: 2, add: -1);
	noisefunction = Sweep.ar(trig: noisefunction);
	noise = Hasher.ar(in: noisefunction);
	noise = LPF.ar(in: noise, freq: nyquist);
	noise = Latch.ar(noise, Impulse.ar(nyquist * 2));
	noise = LPF.ar(in: noise, freq: nyquist);

	//Adjusting amplitudes for each section:
	noise = noise * LFTri.ar(freq: freq, iphase: 0);
	shapea = noise * switcha * chaosRise;
	shapeb = noise * switchb * chaosFall;

	//Mixing the two sections together to create a triangle-ish wave:
	shapea = LFSaw.ar(freq: freq, iphase: 1, mul:    switcha,   add: shapea);
	shapeb = LFSaw.ar(freq: freq, iphase: 1, mul: -1 * switchb, add: shapeb);

	//Output stuff:
	snd = Mix.ar(shapea + shapeb);
	snd = LeakDC.ar(snd);
	snd = LPF.ar(in: snd, freq: cutoff, mul: env);
	snd = FreeVerb.ar(in: snd, mix: 0.2, room: 0.7, damp: 1);

	DetectSilence.ar(in: snd, doneAction: 2);

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Josh Mitchell",
	category: \misc,
	tags: [\pitched, \noisy]
	)
).add;		