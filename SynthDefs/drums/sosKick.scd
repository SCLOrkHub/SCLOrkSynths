/* Retrieved from
http://sccode.org/1-5aD

DrumSynths SC Example - SOS Drums by Renick Bell, renick_at_gmail.com
recipes from Gordon Reid in his Sound on Sound articles
SOSkick -------
http://www.soundonsound.com/sos/jan02/articles/synthsecrets0102.asp
increase mod_freq and mod_index for interesting electronic percussion

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("sosKick", {
	arg
    //Standard Values
	out = 0, pan = 0, amp = 1, curve = -4, drumAmp = 1, beaterAmp = 0.02,
	//drum Controls
	drumFreq = 50, drumHarmonic = 2, drumSweep = 0.02, drumAtt = 0.005, drumRel = 0.4,
	drumFilter = 1000, modIndex = 6.5, modFreq = 5,
	//beater Controls
	beaterFreq = 500, beaterHarmonic = 12, beaterSweep = 0.03, beaterAtt = 0.01, beaterRel = 0.3;

	var drumEnv, drumContour, drum, beaterContour, beaterEnv, beater, snd;

	drumEnv = Env.perc(attackTime: drumAtt, releaseTime: drumRel, level: drumAmp, curve: curve).kr;

	drumContour = Line.kr(start: drumFreq * drumHarmonic, end: drumFreq, dur: drumSweep);

	drum = PMOsc.ar(
		        carfreq: drumContour,
				modfreq: modFreq,
				pmindex: modIndex);

	drum = LPF.ar(in: drum, freq: drumFilter, mul: drumEnv);

	beaterEnv = Env.perc(attackTime: beaterAtt, releaseTime: beaterRel, level: beaterAmp, curve: curve).kr;

	beaterContour = Line.kr(start: beaterFreq * beaterHarmonic, end: beaterFreq, dur: beaterSweep);

	beater = HPF.ar(in: WhiteNoise.ar, freq: beaterFreq);

	beater = LPF.ar(in: beater, freq: beaterContour, mul: beaterEnv);

	snd = Mix.ar(drum + beater) * amp;

    DetectSilence.ar(in: snd, doneAction: 2);

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Renick Bell",
	category: \drums,
	tags: [\pitched, \kick, \sos]
	)
).add;	