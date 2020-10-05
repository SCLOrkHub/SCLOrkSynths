/* Retrieved from
http://sccode.org/1-5aD
*/

SynthDef("sawSynth", { arg freq = 440, amp = 0.1, att = 0.1, rel = 2, lofreq = 1000, hifreq = 3000, pan = 0;
    var env, snd;
    env = Env.perc(
		attackTime: att,
		releaseTime: rel,
		level: amp
	).kr(doneAction: 2);
    snd = Saw.ar(freq: freq * [0.99, 1, 1.001, 1.008], mul: env);
	snd = LPF.ar(
		in: snd,
		freq: LFNoise2.kr(1).range(lofreq, hifreq)
	);
    snd = Mix.ar(snd);
	snd = Pan2.ar(snd, pan);
    Out.ar(0, snd);
// Basic saw synth
//By Bruno Ruviaro
//http://sccode.org/1-54H
}).add;
