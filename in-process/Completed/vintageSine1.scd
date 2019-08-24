/* Retrieved from
http://sccode.org/1-5aD
Original by Zé Craum

Crude simulation of old sinusoidal generators - with vibrato and high noise floor

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef(\vintageSine, {
	arg
	//Standard Definitions
	amp = 0.2, freq = 440, pan = 0, att = 0.001, sus = 1, rel = 0.5, gate = 1, out = 0,
	//Noise Arguments (mainsDepth is 0 to 1)
	noiseAmp = 0.2, mainsDepth = 0.1, mainsHz = 50,
	//Vibrato Arguments
	vrate = 2, vdepth = 0.002, vdelay = 0.1, vonset = 0, vrateVariation = 0.1, vdepthVariation = 0.1;

	var noise, env, snd, vibrato;

	env = Env.asr(att, amp, rel, curve: \lin).kr(gate: gate, doneAction: 2);

	noise = PinkNoise.ar(noiseAmp);

	//noise = PinkNoise.ar(noiseAmp * LFPar.ar(mainsHz * 2).range((1 - mainsDepth), 1));
	//noise = noise + LFPar.ar(freq: mainsHz, mul: noiseAmp/8);

	vibrato = Vibrato.kr(
		            freq: DC.kr(freq),
		            rate: DC.kr(vrate),
	            	depth: DC.kr(vdepth),
	            	delay: DC.kr(vdelay),
	            	onset: DC.kr(vonset),
	            	rateVariation: DC.kr(vrateVariation),
	            	depthVariation: DC.kr(vdepthVariation)
	            );

	//vibrato = freq * LFNoise2.ar(vrate).range(1/(1 + vdepth), (1 + vdepth));

	snd = LFPar.ar(vibrato);
	snd = LPF.ar(snd, freq * 4);
	snd = (snd + noise) * env;

	Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Original by Zé Craum, http://sccode.org/1-5aD",
	category: \organ,
	tags: [\vintage, \pitched]
	)
).add