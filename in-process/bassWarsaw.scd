

SynthDef("bassWarsaw", { |freq = 440, gate = 1, amp = 0.5, slideTime = 0.17, ffreq = 1100, width = 0.15, detune = 1.005, preamp = 4|
	var sig, env;
	env = Env.adsr(0.01, 0.3, 0.4, 0.1);
	freq = Lag.kr(freq, slideTime);
	sig = Mix(VarSaw.ar([freq, freq * detune], 0, width, preamp)).distort;
	sig = sig * amp * EnvGen.kr(env, gate, doneAction: 2);
	sig = LPF.ar(sig, ffreq);
	Out.ar(0, sig ! 2)
}).add;