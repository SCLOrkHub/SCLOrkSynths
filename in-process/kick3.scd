

SynthDef("kick3", {arg punch = 1, amp = 1;
	var freq = EnvGen.kr(Env([400, 66], [0.08], -3)),
	sig = Normalizer.ar(SinOsc.ar(freq, 0.5pi, punch).distort, 1) * amp
	* EnvGen.kr(Env([0, 1, 0.8, 0], [0.01, 0.1, 0.2]), doneAction: 2);
	Out.ar(0, sig ! 2);
}).add;
