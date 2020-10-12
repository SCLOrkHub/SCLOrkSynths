/*
This Double Bass SynthDef, (originally called "~bass") was made by Matias Monteagudo on
his Generative Jazz Project "MM – Coltrane’s Giant Steps," which can be found here:
https://patchstorage.com/mm-giant-steps-with-visuals/

First, a percussive envelope is defined in order to mimic the distinctive pluck of a double bass.
Frequency modualation synthesis is used such that the sine oscillators "op1", "op2", "op3", and "op4" are
operators with phase modulation. "op1", "op2", and "op3" share harmonic overtones while "op4" shares the fundamental
frequency. "op4" utilizes slight frequency deviation, which can be altered through the "freqDev" argument. This frequency deviation alters the level of precision in the intonation of each note, such that a value of zero would create perfect intonation on each note. The "mul" arguments for each operator linearly increase or decrease the amplitude for their
respective sine oscillators. Then, "op4" is passed through a delay line with multi-channel expansion. A high pass filter
removes frequencies below human perception. The array of channels is then spread across the stereo field,
and the "pan" and "sprd" argument can be used to alter this. A sub-bass is added which is correspondingly
panned, and the "subAmp" argument linearly increases or decreases its amplitude. Lastly, a limiter provides protection
in the event that extreme values are passed into the Synth.

Modifications Made:
- argument/variable names, formatting, and syntax were altered to better fit the SCLOrkSynth guidlines and conventions
- documentation was added in the form of comments outlining processes throughout the SynthDef
- a percussive envelope was substitutued over an ADSR envelope for the sake of optimization
- a sub-bass was added to build a deeper double bass sound
- the "pan", "sprd", "subAmp", and "freqDev" arguments were added and appropriatley substituted
- the "maxdelaytime" argument in the DelayN UGen was altered to 0.06 to fit the maximum of the established "delaytime" range
- constants in mul arguments throghout processes were multiplied together and reduced to simplify the SynthDef
- a limiter was added to provide protection against large amplitudes

By Matias Monteagudo, Prof. Composer, Salzburg Austria
Description by Suhel Keswani
SynthDef and Pattern modified by Suhel Keswani and Josh Mitchell, September 2020
*/

SynthDef("doubleBass", {
	arg
	// Standard Values
	out = 0, pan = 0, amp = 1.0, freq = 440, att = 0.01, rel = 1.0 , crv = -30, vel = 1.0,
	// Other Controls
	freqDev = 2, op1mul = 0.1, op2mul = 0.1, op3mul = 0.1, sprd = 0.5, subAmp = 0.1;

	var env, op1, op2, op3, op4, snd, sub;

	// Percussive Envelope
	env = Env.perc(
		attackTime: att,
		releaseTime: rel,
		curve: crv
	).ar(doneAction: 2);

	// Overtones
	op1 = SinOsc.ar(
		freq: freq * 4,
		mul: vel / 2 + op1mul);

	op2 = SinOsc.ar(
		freq: freq * 3,
		phase: op1,
		mul: vel / 2 + op2mul);

	op3 = SinOsc.ar(
		freq: freq * 2,
		phase: op2,
		mul: vel / 2 + op3mul);

	// Fundamental Frequency
	op4 = SinOsc.ar(
		freq: freq + NRand(-1 * freqDev, freqDev, 3),
		phase: op3,
		mul: vel);

	// Delay Line with Multi-Channel Expansion
	snd = {
		DelayN.ar(
			in: op4,
			maxdelaytime: 0.06,
			delaytime: Rand(0.03, 0.06)
		)} !8;

	// High Pass Filter
	snd = LeakDC.ar(snd);

	// Stereo Spread
	snd = Splay.ar(
		inArray: snd,
		spread: sprd,
		level: 0.6,
		center: pan);

	// Add a sub
	sub = SinOsc.ar(
		freq: freq/2,
		mul: env * subAmp);
	sub = Pan2.ar(sub, pan);
	snd = snd + sub;

	//Ouput Stuff
	snd = snd * env;
	snd = snd * amp;
	snd = Limiter.ar(snd);
	Out.ar(out, snd);
},
metadata: (
	credit: "Matias Monteagudo",
	category: \bass,
	tags: [\pitched, \bass]
)
).add;