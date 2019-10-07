/*
A sub Bass based on octave-down guitar/bass effects from the 80s or so.
In particular, this version is based on the famous Boss oc2 pedal.

Josh Mitchell, 8/19.
*/

SynthDef(\subBass1, {
    arg
	//Blend goes from 0 to 1
	out = 0, amp = 0.5, pan = 0, freq = 440, att = 0.001, rel = 0.15, curve = -8, blend = 0.5;

    var env, in, ina, synca, octa, inb, syncb, octb, octave, snd;

    //A slightly rounded percussive envelope
	env = Env.perc(att, rel, amp, [curve, -1 * curve]).kr(doneAction: 2);

	//Input wave - To use SinOsc.ar, replace "iphase: 2" with "phase: 3pi/2"
	in = LFPar.ar(freq: freq * 2, iphase: 2);

	//Mirroring the wave around the x-axis
	ina = in.range(0, 1);
	inb = ina * -1;

	//Two square waves exactly out of phase and an octave below the input wave
	synca = LFPulse.ar(freq: freq, iphase: 0);
	syncb = LFPulse.ar(freq: freq, iphase: 0.5);

	//This smoothly swaps between outputting the input wave and its mirror
	octa = ina * synca;
	octb = inb * syncb;
	octave = Mix.ar([octa, octb]);

	//Mixer stage, volume adjustments, envelope, and output
	snd = Mix.ar([octave * blend * 0.5, in * (1 - blend) * 0.25]);
	snd = LeakDC.ar(snd);
	snd = Limiter.ar(in: snd, level: 1);
	snd = snd * env;

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Josh Mitchell, 2019",
	category: \bass,
	tags: [\pitched, \sub]
	)
).add;