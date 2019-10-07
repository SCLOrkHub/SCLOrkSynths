/* Retrieved from
//from http://sccode.org/1-5aW

Useable as a sub bass or bass drum.

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("ikedaBass", {

	arg out = 0, freq = 0, att = 0, dec = 0.1, sus = 0.8, rel = 0.01, curve = -5, gate = 1, pan = 0, amp = 1, harmonic = 14.015, iphase = pi/3;

	var env, snd;

	env = Env.adsr(
	    	attackTime: att,
	    	decayTime: dec,
	    	sustainLevel: sus,
	    	releaseTime: rel,
	    	curve: curve,
	    ).kr(gate: gate, doneAction: 2);

	env = env * amp.curvelin(inMin: 0, inMax: 1, outMin: 0, outMax: 1, curve: log(10));

	snd = SinOsc.ar(
		    //Any value for freq here gets added to the freq of the note (n + 0 = n)
		    freq: 0,
		    //Phase sweeps around a circle at (rate / 2pi) to make a sine wave.
		    phase: (Sweep.ar(trig: gate, rate: 2pi * [freq, freq * harmonic]) + iphase).wrap(-pi, pi),
	        mul: [1, 0.01]
	    );

	snd = Mix.ar(snd).tanh;

	snd = LeakDC.ar(snd);

	snd = snd * env;

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "meunier.fabien, possibly by Batuhan Bozkurt",
	category: \bass,
	tags: [\pitched]
	)
).add;