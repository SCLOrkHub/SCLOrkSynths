/* Recieved from 
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/clap_oto309.scd
*/

SynthDef("clap_oto309", {	
	arg out=0, amp = 0.1, pan=0;
	var env1, env2, son, noise1, noise2;
	
	env1 = EnvGen.ar(Env.new([0, 1, 0, 1, 0, 1, 0, 1, 0], [0.001, 0.013, 0, 0.01, 0, 0.01, 0, 0.03], [0, -3, 0, -3, 0, -3, 0, -4]));
	env2 = EnvGen.ar(Env.new([0, 1, 0], [0.02, 0.3], [0, -4]), doneAction:2);
	
	noise1 = WhiteNoise.ar(env1);
	noise1 = HPF.ar(noise1, 600);
	noise1 = BPF.ar(noise1, 2000, 3);
	
	noise2 = WhiteNoise.ar(env2);
	noise2 = HPF.ar(noise2, 1000);
	noise2 = BPF.ar(noise2, 1200, 0.7, 0.7);
	
	son = noise1 + noise2;
	son = son * 2;
	son = son.softclip * amp;
	
	Out.ar(out, Pan2.ar(son, pan));
},
metadata: (
	credit: "from 08091500Acid309 by_otophilia",
	tags: [\clap, \percussion]
	)
)
