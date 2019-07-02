SynthDef("blip1", {arg out = 0, freq = 25, numharm = 10, att = 0.01, rel = 1, amp = 0.1, pan = 0;
	var snd, env;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd = Blip.ar(
		freq: freq * [1, 1.01],
		numharm: numharm,
		mul: env
	);
	snd = LeakDC.ar(snd);
	snd = Mix.ar(snd);
	snd = Pan2.ar(snd, pan);
	Out.ar(out, snd);
},

metadata: (
	credit: "unknown",
	category: \pads,
	tags: [\pitched]
)
).add;




