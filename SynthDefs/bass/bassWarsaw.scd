/*
James Harkins
http://doc.sccode.org/Tutorials/A-Practical-Guide/PG_04_Words_to_Phrases.html

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("bassWarsaw", {
	arg
	//Standard Values:
	out = 0, freq = 440, gate = 1, amp = 0.5, pan = 0, att = 0.01, dec = 0.3, sus = 0.4, rel = 0.1,
	//Other Controls:
	slideTime = 0.17, cutoff = 1100, width = 0.15, detune = 1.005, preamp = 4;

	var snd, env;

	env = Env.adsr(att, dec, sus, rel).kr(gate: gate, doneAction: 2);
	freq = Lag.kr(freq, slideTime);
	snd = VarSaw.ar(freq: [freq, freq * detune], width: width, mul: preamp);
	snd = Mix(snd).distort;
	snd = snd * env;
	snd = LPF.ar(snd, cutoff, amp);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "James Harkins",
	category: \bass,
	tags: [\bass, \synth, \pitched]
	)
).add;