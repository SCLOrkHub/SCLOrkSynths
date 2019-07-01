
SynthDef("trig_demo", { |freq = 440, gate = 1, t_trig = 1|
    var env, sig;
	env = Decay2.kr(t_trig, 0.01, 0.1);
    sig = SinOsc.ar(freq, 0, env);
	sig = sig * Linen.kr(gate, 0.01, 0.1, 0.1, doneAction: 2);
    Out.ar(0, sig ! 2)
}).add;
