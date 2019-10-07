/* Retrieved from
http://sccode.org/1-5aD

DrumSynths SC Example - SOS Drums by Renick Bell, renick_at_gmail.com
recipes from Gordon Reid in his Sound on Sound articles
SOShats -------
http://www.soundonsound.com/sos/Jun02/articles/synthsecrets0602.asp

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("sosHats", {
	arg
	//Standard Values
	out = 0, pan = 0, freq = 6000, amp = 0.8, curve = -4, rootIndex = 238.5, rq = 1,
	//Initial envelopes
	initAtt = 0.005, initRel = 0.1, initAmp = 1, initStart = 15000, initEnd = 9000,
	//Body envelopes
	bodyAtt = 0.005, bodyRel = 0.1, bodyAmp = 1, bodyStart = 9000, bodyEnd = 12000;

	var root, initialEnv, initialSweep, initial, bodyEnv, bodySweep, body, snd;

	root = Pulse.ar(freq: freq, width: 0.5, mul: 1);

	root = PMOsc.ar(
		            carfreq: root,
					modfreq: freq * [1.34, 2.405, 3.09, 1.309],
					pmindex: rootIndex * [1, 0.22, 0.014, 0.0038]);

	root = Mix.new(root);

	initialEnv = Env.perc(attackTime: initAtt, releaseTime: initRel, curve: curve).kr;

	initialSweep = Line.kr(start: initStart, end: initEnd, dur: initRel);

	initial = BPF.ar(in: root, freq: initialSweep, rq: rq, mul: initialEnv * initAmp);

	bodyEnv = Env.perc(attackTime: bodyAtt, releaseTime: bodyRel, curve: curve / 2).kr;

	bodySweep = Line.kr(start: bodyStart, end: bodyEnd, dur: bodyRel);

	body = HPF.ar(in: root, freq: bodySweep, mul: bodyEnv * bodyAmp);

	snd = Mix.ar([initial, body]) * amp;

    DetectSilence.ar(in: snd, doneAction: 2);

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Renick Bell",
	category: \drums,
	tags: [\pitched, \cymbal, \sos]
	)
).add;