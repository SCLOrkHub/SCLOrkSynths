/*
Retrieved from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/clap_oto309.scd

*/

SynthDef("clapOto309", {
	arg out = 0, amp = 0.1, pan = 0;
	var env1, env2, snd, noise1, noise2;

	env1 = Env.new(
		levels: [0, 1, 0, 1, 0, 1, 0, 1, 0],
		times: [0.001, 0.013, 0, 0.01, 0, 0.01, 0, 0.03],
		curve: [0, -3, 0, -3, 0, -3, 0, -4]
	).ar;
	env2 = Env.new(
		levels: [0, 1, 0],
		times: [0.02, 0.3],
		curve: [0, -4]
	).ar(doneAction: 2);

	noise1 = WhiteNoise.ar(env1);
	noise1 = HPF.ar(noise1, 600);
	noise1 = BPF.ar(noise1, 2000, 3);

	noise2 = WhiteNoise.ar(env2);
	noise2 = HPF.ar(noise2, 1000);
	noise2 = BPF.ar(noise2, 1200, 0.7, 0.7);

	snd = noise1 + noise2;
	snd = snd * 2;
	snd = snd.softclip * amp;

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "08091500Acid309 by otophilia",
	category: \drums,
	tags: [\clap, \percussion]
	)
).add;