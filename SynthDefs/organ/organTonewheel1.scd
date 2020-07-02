/* Retrieved from
http://sccode.org/1-5aD

Additive tonewheel organ with more CPU usage.

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("organTonewheel1", {

	arg
    //Standard Values
	out = 0, freq = 440, amp = 0.7, att = 0.001, rel = 0.01, pan = 0, curve = -4, gate = 1,
	//organ voices (drawbars) amplitudes
	bass = 1, quint = 1, fundamental = 1, oct = 1, nazard = 1, blockFlute = 1, tierce = 1, larigot = 1, sifflute = 1,
	//vibrato arguments
    vrate = 3, vdepth = 0.008, vdelay = 0.1, vonset = 0, vrateVariation = 0.1, vdepthVariation = 0.1;

	var snd, env, vibrato;

	vibrato = Vibrato.kr(
		            freq: freq,
		            rate: vrate,
		            depth: vdepth,
	            	delay: vdelay,
	             	onset: vonset,
	             	rateVariation: vrateVariation,
	              	depthVariation: vdepthVariation,
	            );

	env = Env.asr(
		attackTime: att,
		sustainLevel: amp,
		releaseTime: rel,
		curve: curve).ar(gate: gate);

	snd = DynKlang.ar(
		specificationsArrayRef: Ref.new([
			[1/12,  1/7, 1, 12, 19, 24, 28, 31, 36].midiratio,
			[bass, quint, fundamental, oct, nazard, blockFlute, tierce, larigot, sifflute].normalizeSum,
			    ]),
		freqscale: vibrato);

	// Output Stuff
	snd = snd * env;
	snd = Mix.ar(snd);
	snd = Limiter.ar(snd);

	DetectSilence.ar(in: snd, doneAction: 2);

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Zé Craum",
	category: \organ,
	tags: [\pitched]
	)
).add;
