/*
Phasers are cool, here's a supercollider one:

By Josh Mitchell 11/19.
*/

SynthDef("phazer", {
    arg
	//Standard Values
	out = 0, pan = 0, freq = 440, amp = 0.5, gate = 1,
	att = 1, dec = 3, sus = 0, rel = 1.5, crv = -4,
    //Other controls
    rq = 0.5, rate = 1, minfreq = 100, maxfreq = 16000,
	drylevel = 1.5, fmdepth = 1.5, fmfreq = 432;

	var env, lfo, input, snd;

	env = Env.adsr(
		    attackTime: att,
	    	decayTime: dec,
    		sustainLevel: sus,
		    releaseTime: rel,
	    	curve: crv
	    ).ar(doneAction: 2);

	//Controls the all pass freq; try an envelope here as well!
	lfo = LinExp.ar(LFTri.ar(rate), -1, 1, minfreq, maxfreq/8);
	//lfo = LinExp.ar(env, 0, 1, minfreq, maxfreq/8);

	//The input sound (Dense frequency content is better)
	input = LFSaw.ar(freq: SinOsc.ar(fmfreq).range(1, fmdepth) * freq, mul: env * amp);

	//All pass filter + dry sound = P H A Z E R
	snd = BAllPass.ar(input, [1, 2, 4, 8] * lfo, rq);
	snd = Mix.ar(snd);
	snd = snd + (input * -1 * drylevel);
	snd = Mix.ar(snd);

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Josh Mitchell",
	category: \misc,
	tags: [\pitched, \effects]
	)
).add;