

SynthDef("beating", {arg freq = 440, amp = 0.1, art = 1;
	var env, snd1, snd2;
	env = EnvGen.ar(Env.perc(0.01, art), doneAction: 2);
	snd1 = SinOsc.ar(freq);
	snd2 = SinOsc.ar(Line.kr(freq+15, freq, art));
	Out.ar(0, Pan2.ar(Mix([snd1, snd2]), 0, amp*env))
}).add;