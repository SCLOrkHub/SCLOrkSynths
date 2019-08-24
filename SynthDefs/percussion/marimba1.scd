SynthDef("marimba1", {arg freq = 440, amp = 0.4, pan = 0;
	var snd, env;
	env = Env.linen(
		attackTime: 0.015,
		sustainTime: 1,
		releaseTime: 0.5,
		level: amp
	).kr(doneAction: 2);
	snd = BPF.ar(
		in: Saw.ar(0),
		freq: freq,
		rq: 0.02
	);
	snd = BLowShelf.ar(
		in: snd,
		freq: 220,
		rs: 0.81,
		db: 6
	);
	snd = snd * env;
	Out.ar(0, Pan2.ar(snd, pan));
},
metadata: (
	credit: "unknown",
	category: \keyboards,
	tags: [\percussion, \marimba, \pitched, \keyboard]
)
).add;