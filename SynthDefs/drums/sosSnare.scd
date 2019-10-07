/* Retrieved from
http://sccode.org/1-5aD

DrumSynths SC Example - SOS Drums by Renick Bell, renick_at_gmail.com
recipes from Gordon Reid in his Sound on Sound articles
SOSsnare -------
http://www.soundonsound.com/sos/Mar02/articles/synthsecrets0302.asp

Latch.ar(WhiteNoise.ar(0.1), Impulse.ar(nyquist * 2)) is added aliasing for effect

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("sosSnare", {
	arg
	//Standard Values
	out = 0, pan = 0, freq = 405, amp = 0.8, att = 0.005, rel = 0.1, curve = -4,
	//drumMode Controls
	drumModeAmp = 0.25, timbreIndex = 0.385, modHarmonic = 0.452,
	//snares controls
	snareAmp = 40, nyquist = 1700, snareRez = 1000, ffreq = 2000, rq = 0.1, bwr = 1;

	var drumMode, drumModeEnv, snares, snareEnv, snd;

	drumModeEnv = Env.perc(attackTime: att, releaseTime: rel, level: 0.5, curve: curve).kr;

	drumMode = SinOsc.ar(freq: freq * 0.53, mul: drumModeEnv);

	drumMode = drumMode + SinOsc.ar(freq: freq, mul: drumModeEnv);

	drumMode = drumMode + PMOsc.ar(
		            carfreq: Saw.ar(freq * 0.85),
					modfreq: freq * modHarmonic,
					pmindex: timbreIndex,
					mul: drumModeEnv * 10);

	drumMode = Mix.ar(drumMode) * drumModeAmp;

	snareEnv = Env.perc(attackTime: att, releaseTime: rel, curve: curve).kr;

	snares = Latch.ar(WhiteNoise.ar(0.1), Impulse.ar(nyquist * 2));

	snares = BRF.ar(in: snares, freq: 4 * ffreq, mul: 0.5, rq: rq);

	snares = BRF.ar(in: snares, freq: 2.5 * ffreq, mul: 0.5, rq: rq);

	snares = BRF.ar(in: snares, freq: 1.8 * ffreq, mul: 0.5, rq: rq);

	snares = BRF.ar(in: snares, freq: ffreq, mul: snareEnv, rq: rq);

	snares = Resonz.ar(in: snares, freq: snareRez, bwr: bwr, mul: snareAmp) ;

	snd = Mix.new(drumMode + snares) * amp;

	DetectSilence.ar(in: snd, doneAction: 2);

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Renick Bell",
	category: \drums,
	tags: [\pitched, \snare, \sos]
	)
).add;