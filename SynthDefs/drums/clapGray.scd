/*
By Josh Mitchell, August 2019
SCLOrk - Santa Clara Laptop Orchestra
Santa Clara University

Inspired by
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/clap_oto309.scd

Some of the modifications from oto309:
-Instead of Env.new, the Synthdef now sends env1 through a delay line
-Light reverb added for a more realistic sound
-GrayNoise instead of WhiteNoise
*/

SynthDef("clapGray", {
	arg
	//Standard Values
	out = 0, amp = 0.1, pan = 0, att = 0.001, rel = 0.25, curve = -4,
	//Other Controls
	spreadRate = 75, minDelay = 0.025, maxDelay = 0.05, decay = 0.15, rq = 0.4,
	//Controls from 0 - 1
	blend = 0.7, reverb = 0.1, size = 0.25, damp = 1;

	var env1, env2, snd, noise1, noise2, spread;

	//Multiple Shorter Claps
	spread = LFNoise1.kr(spreadRate).range(minDelay, maxDelay);

	env1 = Env.perc(attackTime: att / 10, releaseTime: rel / 8, curve: [0, curve]).kr;
	env1 = CombC.ar(in: env1, maxdelaytime: maxDelay, delaytime: spread, decaytime: decay);

	noise1 = GrayNoise.ar(env1); //Play with frequencies here:
	noise1 = RHPF.ar(in: noise1, freq: 1000, rq: rq);
	noise1 = BPF.ar(in: noise1, freq: 2000, rq: 3);

	//One Longer Clap
	env2 = Env.perc(attackTime: att, releaseTime: rel, curve: [0, curve]).kr;

	noise2 = GrayNoise.ar(env2); //Play with frequencies here:
	noise2 = RHPF.ar(in: noise2, freq: 1200, rq: rq);
	noise2 = BPF.ar(in: noise2, freq: 1400, rq: 0.7);

	//Mixing and light Reverb
	snd = Mix.ar((blend * noise1) + ((1 - blend) * noise2));
	snd = (snd * 2).softclip;
	snd = FreeVerb.ar(in: snd, mix: reverb, room: size, damp: damp, mul: amp);

	DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Josh Mitchell, 2019",
	category: \drums,
	tags: [\clap, \percussion]
	)
).add;