/* Retrieved from
http://sccode.org/1-5aD

Harpsichord based on Pluck Ugen
Original by Zé Craum

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef(\harpsichord2, {
	arg
	//Standard Values
	out = 0, amp = 0.1, freq = 440, pan = 0, att = 0, rel = 0,
	//Pluck arguments (blend goes from 0 to 1)
	trig = 1, decaytime = 7, coef = 0.1, blend = 0.6;

	var env, exciter, root, octave, snd;

	//Why is this not used, Josh?
	env = Env.linen(attackTime: att, sustainTime: decaytime, releaseTime: rel).kr(doneAction: Done.freeSelf);

	exciter = PinkNoise.ar(amp); //Can use white noise here, but Pink is more realistic

    root = Pluck.ar(  //fundamental
	        in: exciter,
	        trig: trig,
	        maxdelaytime: 0.06, //only change this if freq goes below 20hz
	        delaytime: 1 / freq,
	        decaytime: decaytime,
	        coef: coef,
	        mul: blend
        );

	octave = Pluck.ar(  //octave up
	        in: exciter,
	        trig: trig,
	        maxdelaytime: 0.06, //only change this if freq goes below 20hz
	        delaytime: 1 / (2 * freq),
	        decaytime: decaytime,
	        coef: coef,
	        mul: (1 - blend)
        );

	snd = Mix.ar(root + octave);

    DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Zé Craum",
	category: \keyboards,
	tags: [\pitched]
	)
).add;