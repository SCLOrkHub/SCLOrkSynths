/* Retrieved from
http://sccode.org/1-5aD

Subtractive tonewheel organ with cheap CPU usage.

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef(\organTonewheel3, {
	arg
	//Standard Values
	out = 0, pan = 0, freq = 440, amp = 0.45, att = 0.001, rel = 0.1, gate = 1,
	//Vibrato Controls
	vrate = 6, vdepth = 0.02, vdelay = 0.1, vonset = 0, vrateVariation = 0.1, vdepthVariation = 0.1,
	//Other controls (blend goes from 0 to 1)
	filterHarmonic = 5.04, rq = 1, blend = 0.83;

	var snd, env, vibrato;

	env = Env.asr(attackTime: att, sustainLevel: amp, releaseTime: rel).kr(gate: gate, doneAction: 2);

		vibrato = Vibrato.kr(
		            freq: freq,
		            rate: vrate,
		            depth: vdepth,
	            	delay: vdelay,
	             	onset: vonset,
	             	rateVariation: vrateVariation,
	              	depthVariation: vdepthVariation,
	            );

	snd = LFPulse.ar(freq: freq, width: 0.5, mul: 1 - blend) + LFPulse.ar(freq: freq + vibrato, width: 0.18, mul: blend);

	snd = BLowPass4.ar(in: snd, freq: filterHarmonic * freq, rq: rq, mul: env);

    snd = LeakDC.ar(snd);

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Zé Craum",
	category: \organ,
	tags: [\pitched]
	)
).add;