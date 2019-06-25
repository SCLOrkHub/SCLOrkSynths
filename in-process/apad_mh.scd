/*Retrieved from 
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/apad_mh.scd
*/

SynthDef(\apad_mh, {arg freq=880, amp=0.5, attack=0.4, decay=0.5, sustain=0.8, release=1.0, gate=1.0, out=0;
	var env,sig,mod1,mod2,mod3;
	env=EnvGen.kr(Env.adsr(attack,decay,sustain,release),gate,levelScale:amp,doneAction:2);
	mod1=SinOsc.kr(6).range(freq*0.99,freq*1.01);
	mod2=LFNoise2.kr(1).range(0.2,1);
	mod3=SinOsc.kr(rrand(4.0,6.0)).range(0.5,1);
	sig=SinOsc.ar([freq,mod1],0,env).distort;
	sig=sig*mod2*mod3;
	Out.ar(out,sig);
},
metadata:(
	credit: "A simple sustained sound with vibrato --Mike Hairston",
	tags: [\pad,\vibrato,\sustained]
	)
)
