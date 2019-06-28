/* Retrieved from
http://sccode.org/1-5aD
*/

SynthDef(\sine_vintage, {
//Crude simulation of old sinusoidal generators - with vibrato and high noise floor
	|amp=0.2, freq=440, pan=0, atk = 0.001, sus = 2, rel = 0.01,
	vrate = 2, vdepth = 0.002, vdelay = 0.1, vonset = 0, vrateVariation = 0.1, vdepthVariation = 0.1 /*vibrato arguments*/,
	noiseAmp = 0.2|
	var env, sig, vibrato;
	env = EnvGen.kr(Env.linen(atk, sus, rel), doneAction:2);
	vibrato = Vibrato.kr(DC.kr(freq), DC.kr(vrate), DC.kr(vdepth), DC.kr(vdelay), DC.kr(vonset), DC.kr(vrateVariation), DC.kr(vdepthVariation));
	sig = SinOsc.ar(vibrato);
	sig = sig + PinkNoise.ar(noiseAmp);
	sig = sig * env;
	Out.ar(0, Pan2.ar(sig, pan, amp));
//By Zé Craum
}).add;
