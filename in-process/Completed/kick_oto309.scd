/* Received from 
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/kick_oto309.scd
*/

SynthDef("kick_oto309", {	
	arg out=0, amp=0.1, pan=0;
	var env0, env1, env1m, son;
	
	env0 =  EnvGen.ar(Env.new([0.5, 1, 0.5, 0], [0.005, 0.06, 0.26], [-4, -2, -4]), doneAction:2);
	env1 = EnvGen.ar(Env.new([110, 59, 29], [0.005, 0.29], [-4, -5]));
	env1m = env1.midicps;
	
	son = LFPulse.ar(env1m, 0, 0.5, 1, -0.5);
	son = son + WhiteNoise.ar(1);
	son = LPF.ar(son, env1m*1.5, env0);
	son = son + SinOsc.ar(env1m, 0.5, env0);
	
	son = son * 1.2;
	son = son.clip2(1);
	
	Out.ar(out, Pan2.ar(son * amp));
},
metadata: (
	credit: "from 08091500Acid309 by_otophilia",
	tags: [\kick, \drum, \percussion]
	)
)
