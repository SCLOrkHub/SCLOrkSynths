/* Received from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/snare_oto309.scd

from 08091500Acid309 by_otophilia

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("snareOto309", {
	arg
	//Standard Values
	out = 0, amp = 0.1, pan = 0, freq = 139, att = 0.05, dec = 0.03, rel = 0.1, curve = -4, preamp = 1.2,
	//Oscs Controls, blend ranges from 0 to 1
	filterHarmonic = 1.2, oscsHarmonic = 1.6, blend = 0.333, oscsAmp = 1,
	//Noise Controls
	noiseRatio = 0.4, noiseBottom = 200, noisePeak = 6900, rq = 0.6, noiseAmp = 1;

	var envOscs, envSweep, envNoise, oscs, noise, snd;

	//  E N V S
	envOscs = Env.new(
		            levels: [0.5, 1, 0.5, 0] * oscsAmp,
		            times: [(att * 0.1), dec, rel],
		            curve: [1, 0.5, 1] * curve).kr;

	envSweep = Env.new(
		            levels: [33.81, 1.88, 1] * freq,
		            times: [(att * 0.1), rel],
		            curve: [1, 1.25] * curve).kr;

	envNoise = Env.new(
		            levels: [1, noiseRatio, 0] * noiseAmp,
		            times: [att, (dec + rel)],
		            curve: [0.5, 0.5] * curve).kr(doneAction: 2);

	//  O S C S
	oscs = LFPulse.ar(
	            	freq: [envSweep, envSweep * oscsHarmonic],
	            	width: [0.5, 0.5],
	            	mul: [1 - blend, blend],
	            	add: [-0.5, -0.25]);

	oscs = LPF.ar(in: oscs, freq: envSweep * filterHarmonic, mul: envOscs * 1.5);

	oscs = oscs + SinOsc.ar(freq: envSweep, phase: pi/4, mul: envOscs);

	//  N O I S E
	noise = WhiteNoise.ar(1/3);

	noise = HPF.ar(in: noise, freq: noiseBottom);

	noise = noise + BPF.ar(in: noise, freq: noisePeak, rq: rq, mul: 3);

	noise = noise * envNoise;

	//  O U T P U T
	snd = Mix.ar(oscs + noise) * preamp;

	snd = snd.clip2(1) * amp;

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "original by otophilia",
	category: \drums,
	tags: [\snare, \drum, \percussion]
	)
).add;