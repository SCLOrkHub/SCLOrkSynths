/*
Wavefolding as in (input).fold(-1, 1),
but it's rounded out instead of a sharp switch at input amplitudes of 1.

It uses y=sin(x) as a transfer function, so I included a phase offset
(which makes a full loop around the circle as it goes from 0 to 1).
It adds subtle timbral changes, but not much.

By Josh Mitchell 2/20.
*/

SynthDef("waveFolder", {
    arg
	//Standard Values
	out = 0, pan = 0, freq = 160, amp = 1, att = 0.05, rel = 3, crv = -2,
    //Other controls, nonlinearity ranges from 0 to 1
	preamp = 10, phaseOffset = 0.125;

	var env, snd, offset;

	//Envelope: (another fold is introduced each time preamp passes an odd number)
	env = Env.perc(
		attackTime: att,
		releaseTime: rel,
		level: preamp * pi/2,
		curve: crv).ar(doneAction: 2);

	//Sets the phase offset of the folder and prevents clicking:
	offset = Line.ar(0, phaseOffset.mod(1) * 2pi, 0.001);

	//The sound being sent through the wavefolder:
	snd = SinOsc.ar(
		        freq: freq,
		        mul: env,
		        add:  offset);

	//The wavefolder itself:
	snd = SinOsc.ar(
	        	freq: 0,
	        	phase: snd.mod(2pi),
	        	add: SinOsc.ar(freq: 0, phase: offset, mul: -1));

	//Protect those ears!
	snd = Limiter.ar(Mix.ar(snd * amp));

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Josh Mitchell",
	category: \misc,
	tags: [\pitched, \noisy]
	)
).add;