/* Received from 
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/oneclap_thor.scd
*/

SynthDef(\oneclap_thor, {arg out=0, t_trig=1, amp=0.1, filterfreq=100, rq=0.1, pan=0;
var env, signal, attack,Ê noise, hpf1, hpf2;
	noise = WhiteNoise.ar(1)+SinOsc.ar([filterfreq/2,filterfreq/2+4 ], pi*0.5, XLine.kr(1,0.01,4));
	//noise = PinkNoise.ar(1)+SinOsc.ar([(filterfreq)*XLine.kr(1,0.01,3), (filterfreq+4)*XLine.kr(1,0.01,3) ], pi*0.5, XLine.kr(1,0.01,4));
	//signal = signal * SinOsc.ar(1,0.75);
	hpf1 = RLPF.ar(noise, filterfreq, rq);
	hpf2 = RHPF.ar(noise, filterfreq/2, rq/4);
	env = EnvGen.kr(Env.perc(0.003, 0.00035));
	signal = (hpf1+hpf2) * env;
	signal = CombC.ar(signal, 0.5, 0.03, 0.031)+CombC.ar(signal, 0.5, 0.03016, 0.06);
	//signal = Decay2.ar(signal, 0.5);
	signal = FreeVerb.ar(signal, 0.23, 0.15, 0.2);
	Out.ar(out, Pan2.ar(signal * amp, pan));
	DetectSilence.ar(signal, doneAction:2);
},
metadata: (
	credit: "published on the sc-users list 2009-01-08 by thor",
	tags: [\clap, \handclap]
	)
)
