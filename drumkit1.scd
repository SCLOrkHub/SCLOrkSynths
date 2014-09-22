// Basic drum kit

SynthDef("hihat", {arg out = 0, amp = 0.5, att = 0.01, rel = 0.2, ffreq = 6000, pan = 0;
	var snd = WhiteNoise.ar(amp);
	var env = Env.perc(att, rel).kr(doneAction: 2);
	snd = HPF.ar(snd * env, ffreq);
	Out.ar(out, Pan2.ar(snd, pan));
}).add;

SynthDef("snare", {arg out = 0, amp = 0.1, sinfreq = 180, att = 0.01, rel = 0.2, ffreq = 2000, pan = 0;
	var snd1 = WhiteNoise.ar(amp);
	var snd2 = SinOsc.ar(sinfreq,0,amp);
	var env = EnvGen.kr(Env.perc(att, rel), doneAction: 2);
	var sum = HPF.ar(snd1 * env, ffreq)+(snd2*env);
	Out.ar(out, Pan2.ar(sum, pan));
}).add;

SynthDef("kick", {arg out = 0, amp = 0.3, sinfreq = 60, glissf = 0.9, att = 0.01, rel = 0.45, pan = 0;
	var gliss = XLine.kr(sinfreq, sinfreq*glissf, rel);
	var snd = SinOsc.ar(gliss);
	var env = EnvGen.kr(Env.perc(att, rel), doneAction: 2);
	snd = snd * env * amp;
	Out.ar(out, Pan2.ar(snd, pan));
}).add;



// Example
(
Ppar([
	Pbind(
		\instrument, "hihat",
		\dur, Pseq([Rest(1/4), 1/4], inf),
		\ffreq, 9000,
		\rel, 0.1,
		\amp, 0.2
	),
	Pbind(
		\instrument, "kick",
		\dur, 1/2,
		\amp, 0.9,
		\rel, 0.12,
		\glissf, 0.99
	),
		Pbind(
		\instrument, "snare",
		\dur, Pseq([Rest(1/2), 1/2], inf),
		\amp, 0.25,
		\rel, 0.1
	)
]).play;
)
