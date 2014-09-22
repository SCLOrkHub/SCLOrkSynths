SynthDef("harpsichord1", { arg out = 0, freq = 440, amp = 0.1, pan = 0;
    var env, snd;
	env = Env.perc(level: amp).kr(doneAction: 2);
	snd = Pulse.ar(freq, 0.25, 0.75);
	snd = snd * env;
	Out.ar(out, Pan2.ar(snd, pan));
}).add;

// add more harpsichord SynthDefs here...
// "harpsichord2", "harpsichord3", etc.

Synth("harpsichord1")
(
Pbind(
	\instrument, "harpsichord1",
	\scale, Scale.harmonicMinor,
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, [-7, -3, 0, 2, 4, 6], 7], 1),
	\amp, Pseq([Pn(0.1, 8), 0.06]),
	\dur, Pseq([0.3, Pn(0.1, 6), 1.3, 1]),
	\strum, 0.09
).play
)