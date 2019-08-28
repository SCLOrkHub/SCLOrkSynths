/* Retrieved from
http://sccode.org/1-5aD
*/

SynthDef(\organ_tonewheel2, {
	//subtractive tonewheel organ with cheap CPU usage
	arg freq = 440, amp = 0.9, atk = 0.001, sus = 0.4, rel = 0.1, tune = 0.29, tuneRate = 6.0, rq = 1;
	var sig, env, vibrato;
	env = EnvGen.ar(Env.linen(atk, sus, rel, 0.5), doneAction: Done.freeSelf);
	vibrato = SinOsc.ar(tuneRate).range(freq, freq * (tune.midiratio));
	sig = LFPulse.ar(freq, 0, 0.5, 0.2) + LFPulse.ar(freq + vibrato, 0, 0.18);
	sig = RLPF.ar(sig /*+ PinkNoise.ar(20/freq) */, ((28.midiratio) * (freq)) , rq) ;

	sig = sig * env;
	sig = sig * amp;
	sig = LeakDC.ar(sig);
	Out.ar(0, sig!2);
//By Zé Craum
}).add;
