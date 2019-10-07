/* Retrieved from
http://sccode.org/1-5aD

Additive tonewheel organ with low CPU usage.

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("organTonewheel0", {

	arg
    // Standard Values
	out = 0, freq = 440, amp = 0.7, att = 0.001, rel = 0.01, pan = 0, curve = -4, gate = 1,
	//organ voices (drawbars) amplitudes
	bass = 1, quint = 1, fundamental = 1, oct = 1, nazard = 1, blockFlute = 1, tierce = 1, larigot = 1, sifflute = 1,
	 //vibrato arguments
    vrate = 3, vdepth = 0.008;

	var snd, env, vibrato;

	vibrato = SinOsc.kr(vrate).range((1 / (1 + vdepth)), (1 + vdepth));

	env = Env.asr(attackTime: att, sustainLevel: amp, releaseTime: rel, curve: curve).ar(gate: gate, doneAction: 2);

	vibrato = DynKlang.ar(
		specificationsArrayRef: Ref.new([
			        [1/12,  1/7, 1, 12, 19, 24, 28, 31, 36].midiratio,
			        [bass, quint, fundamental, oct, nazard, blockFlute, tierce, larigot, sifflute].normalizeSum
		      ]),
		freqscale: vibrato * freq);

	snd = vibrato * env;

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Zé Craum",
	category: \organ,
	tags: [\pitched]
	)
).add;