/*
Mitchell Sigman (2011) Steal this Sound. Milwaukee, WI: Hal Leonard Books
pp. 10-11

Adapted for SuperCollider and elaborated by Nick Collins
http://www.sussex.ac.uk/Users/nc81/index.html
under GNU GPL 3 as per SuperCollider license

Minor modifications by Bruno Ruviaro, June 2015.
*/

SynthDef("trianglewavebells",{
	arg out = 0, pan = 0.0, freq = 440, amp = 1.0, gate = 1, att = 0.01, dec = 0.1, sus = 1, rel = 0.5, lforate = 10, lfowidth = 0.0, cutoff = 100, rq = 0.5;

	var osc1, osc2, vibrato, filter, env;
	vibrato = SinOsc.ar(lforate, Rand(0, 2.0));
	osc1 = Saw.ar(freq * (1.0 + (lfowidth * vibrato)), 0.75);
	osc2 = Mix(LFTri.ar((freq.cpsmidi + [11.9, 12.1]).midicps));
	filter = RHPF.ar((osc1 + (osc2 * 0.5)) * 0.5, cutoff, rq);
	env = EnvGen.ar(
		envelope: Env.adsr(att, dec, sus, rel, amp),
		gate: gate,
		doneAction: 2);
	Out.ar(out, Pan2.ar(filter * env, pan));
}).add;


loadRelative("utilities.scd");

~addSynthDemo.value("trianglewavebells",
	Pbind(
		\instrument, "trianglewavebells",
		\amp, Pwhite(0.1, 0.15),
		\legato, 1.1,
		\note, Pseq([0, 7, 3, 0, 8, 7, 8, 5, 7, 12, 5, 3, 12, 7, 15, [-19, -7], [-12, -5, 0, 3, 7]], inf),
		\dur, Pwrand([0.6, 1.2], [0.9, 0.1], inf),
		\lfowidth, Pn(Pseries(0.0, 0.005, 16), inf),
		\lforate, Pn(Pseries(1, 0.5, 16), inf),
		\rq, Pn(Pseries(0.9, -0.01, 16),inf),
		\cutoff, Pn(Pseries(60, 20, 16),inf)
	).play
);