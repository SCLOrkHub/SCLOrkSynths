/* Retrieved from
http://sccode.org/1-5aD

Original by Nick Collins, from Mitchell Sigman (2011) Steal this Sound
http://www.sussex.ac.uk/Users/nc81/index.html

Subtractive tonewheel organ from Steal this Sound example.

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef(\organTonewheel4,{
	arg
	//Standard Values
	out = 0, pan = 0, freq = 440, amp = 0.1, gate = 1, att = 0.0, dec = 0.0, sus = 1, rel = 0.1,
	//Other controls (blend goes from 0 to 1)
	lforate = 4.85, lfodepth = 0.006, cutoff = 5000, rq = 0.25, parfreq = 500, parrq = 1, pardb = 3, blend = 0.6;

	var lfo, pulse, filter, env, snd;

	lfo = LFTri.kr(freq: lforate * [1, 1.01], iphase: Rand(0, 2.0) ! 2).range(1 / (1 + lfodepth), (1 + lfodepth));

	pulse = Pulse.ar(freq: freq * [1, 3] * lfo, width: [0.5, 0.51], mul: [(1 - blend), blend]);

	env = Env.adsr(attackTime: att, decayTime: dec, sustainLevel: sus * amp, releaseTime: rel).kr(gate: gate, doneAction: 2);

	filter = BLowPass4.ar(in: pulse, freq: cutoff, rq: rq);

	filter = BPeakEQ.ar(in: filter, freq: parfreq, rq: parrq, db: pardb);

	snd = Mix.ar(filter) * env;

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Nick Collins",
	category: \organ,
	tags: [\pitched]
	)
).add;