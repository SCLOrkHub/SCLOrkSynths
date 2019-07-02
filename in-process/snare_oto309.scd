/* Received from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/snare_oto309.scd
*/

SynthDef("snare_oto309", {	
	arg out=0, amp=0.1, pan=0;
	var env0, env1, env2, env1m, oscs, noise, son;
	
	env0 = EnvGen.ar(Env.new([0.5, 1, 0.5, 0], [0.005, 0.03, 0.10], [-4, -2, -4]));
	env1 = EnvGen.ar(Env.new([110, 60, 49], [0.005, 0.1], [-4, -5]));
	env1m = env1.midicps;
	env2 = EnvGen.ar(Env.new([1, 0.4, 0], [0.05, 0.13], [-2, -2]), doneAction:2);
	
	oscs = LFPulse.ar(env1m, 0, 0.5, 1, -0.5) + LFPulse.ar(env1m * 1.6, 0, 0.5, 0.5, -0.25);
	oscs = LPF.ar(oscs, env1m*1.2, env0);
	oscs = oscs + SinOsc.ar(env1m, 0.8, env0);
	
	noise = WhiteNoise.ar(0.2);
	noise = HPF.ar(noise, 200, 2);
	noise = BPF.ar(noise, 6900, 0.6, 3) + noise;
	noise = noise * env2;
	
	son = oscs + noise;
	son = son.clip2(1) * amp;
		
	Out.ar(out, Pan2.ar(son, pan));
},
metadata: (
	credit: "from 08091500Acid309 by_otophilia",
	tags: [\snare, \drum, \percussion]
	)
)
©
