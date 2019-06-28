/* Retrieved from
http://sccode.org/1-5aD
*/

SynthDef(\violin, {
	| midinote=60, gate=1, amp=0.8 |
	var env = EnvGen.kr(Env.asr(0.1, 1, 0.1), gate, doneAction:2);
	var sig = VarSaw.ar(
		midinote.midicps,
		width:LFNoise2.kr(1).range(0.2, 0.8)*SinOsc.kr(5, Rand(0.0, 1.0)).range(0.7,0.8))*0.25;
	sig = sig * env * amp;
	Out.ar(0, sig!2);
//It is also used for simulating Farfisa organ and flutes
//by nicolaariutti
//http://sccode.org/1-5as
}).add;
