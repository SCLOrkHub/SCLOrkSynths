SynthDef("kick1", {arg out = 0, amp = 0.3, sinFreq = 60, glissf = 0.9, att = 0.01, rel = 0.45, pan = 0;
	var gliss = XLine.kr(sinFreq, sinFreq*glissf, rel);
	var snd = SinOsc.ar(gliss);
	var env = Env.perc(att, rel).kr(doneAction: 2);
	snd = snd * env * amp;
	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Bruno Tucunduva Ruviaro",
	category: \drums,
	tags: [\percussion, \kick]
)
).add;