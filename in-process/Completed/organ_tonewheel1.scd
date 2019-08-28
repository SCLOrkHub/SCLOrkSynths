/* Retrieved from
http://sccode.org/1-5aD
*/

SynthDef(\organ_tonewheel1, {
	//additive tonewheel organ with more CPU usage

	arg freq = 440, amp = 0.7, atk = 0.001, sus = 0.2, rel = 0.01, pan = 0,
	bass = 1, quint = 1, fundamental = 1, oct = 1, nazard = 1, blockFlute = 1, tierce = 1, larigot = 1, sifflute = 1, //organ voices (drawbars) amplitudes
    vrate = 3, vdepth = 0.008, vdelay = 0.1, vonset = 0, vrateVariation = 0.1, vdepthVariation = 0.1; //vibrato arguments
	var sig, env, vibrato;

	vibrato = Vibrato.kr(DC.kr(freq), DC.kr(vrate), DC.kr(vdepth), DC.kr(vdelay), DC.kr(vonset), DC.kr(vrateVariation), DC.kr(vdepthVariation));
	env = EnvGen.ar(Env.linen(atk, sus, rel), doneAction: Done.freeSelf);
	sig = DynKlang.ar(`[[1/12,  1/7, 1, 12, 19, 24, 28, 31, 36].midiratio, ([DC.ar(bass) , DC.ar(quint), DC.ar(fundamental), DC.ar(oct), DC.ar(nazard), DC.ar(blockFlute), DC.ar(tierce), DC.ar(larigot), DC.ar(sifflute)].normalizeSum), nil], vibrato);

	sig = sig * env;
	Out.ar(0, Pan2.ar(sig, pan, amp));
//By Zé Craum
}).add;
