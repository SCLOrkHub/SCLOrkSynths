/* Retrieved from
http://sccode.org/1-5aD
*/

SynthDef(\sine_simple, {
//A really simple sinusoidal sine wave synth
	|amp=0.1, freq=440, pan=0, atk = 0.001, sus = 1, rel = 0.01|
	var env, sig;
	env = EnvGen.kr(Env.linen(atk, sus, rel), doneAction:2);
	sig = SinOsc.ar(freq);
	sig = sig * env;
	Out.ar(0, Pan2.ar(sig, pan, amp));
//By Zé Craum
}).add;
