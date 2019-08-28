/* Retrieved from
http://sccode.org/1-5aD
*/

SynthDef(\organ_tonewheel3, {
	//subtractive tonewheel organ with more CPU usage
	arg freq = 440, amp = 0.9, atk = 0.001, sus = 0.4, rel = 0.1, vrate = 6, vdepth = 0.02, vdelay = 0.1, vonset = 0, vrateVariation = 0.1, vdepthVariation = 0.1, rq =1;
	var sig, env, vibrato;
	env = EnvGen.ar(Env.linen(atk, sus, rel, 0.5), doneAction: Done.freeSelf);
	vibrato = Vibrato.kr(DC.kr(freq), DC.kr(vrate), DC.kr(vdepth), DC.kr(vdelay), DC.kr(vonset), DC.kr(vrateVariation), DC.kr(vdepthVariation));
	sig = LFPulse.ar(freq, 0, 0.5, 0.2) + LFPulse.ar(freq + vibrato, 0, 0.18);
	sig = BLowPass4.ar(sig, ((28.midiratio) * (freq)) , rq) ;

	sig = sig * env;
	sig = sig * amp;
	sig = LeakDC.ar(sig);
	Out.ar(0, sig!2);

//By Zé Craum
}).add;
