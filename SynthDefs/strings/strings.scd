/* Retrieved from
http://sccode.org/1-5aD

Original from SC Examples Folder some small pieces, Julian Rohrhuber, 2007

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef(\strings, {
	arg
	//Standard Definitions
	out = 0, freq = 440, amp = 1, gate = 1, pan = 0, freqLag = 0.2, att = 0.001, dec = 0.1, sus = 0.75, rel = 0.3,
	//Other Controls (mix ranges from 0 - 1)
	rq = 0.001, combHarmonic = 4, sawHarmonic = 1.5, mix = 0.33;

	var env, snd, combFreq;

	combFreq = 1 / (Lag.kr(in: freq, lagTime: freqLag / 2) * combHarmonic);

	env = Env.adsr(att, dec, sus, rel, amp).kr(gate: gate, doneAction: 2);

	snd = SyncSaw.ar(syncFreq: freq * WhiteNoise.kr().range(1/1.025, 1.025), sawFreq: freq * sawHarmonic, mul: 8);
	snd = (snd * (1 - mix)) + PinkNoise.ar(180 * mix);
	snd = CombL.ar(snd, combFreq, combFreq, -1); //Try positive 1 for decay time as well.
	snd = Resonz.ar(snd, Lag.kr(in: freq, lagTime: freqLag), rq).abs;
	snd = snd * env;
	snd = Limiter.ar(snd, amp);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Original from Julian Rohrhuber, 2007",
	category: \strings,
	tags: [\pitched]
	)
).add;