/* Retrieved from
http://sccode.org/1-5aD

By Nick Collins, from Mitchell Sigman (2011) Steal this Sound
http://www.sussex.ac.uk/Users/nc81/index.html
*/

(
SynthDef(\everythingrhodes, {
	arg out = 0, freq = 440, amp = 0.1, gate = 1, att = 0.001, dec = 1, sus = 0.8, rel = 3, lforate = 4.85, lfowidth = 0.5, cutoff = 2000, rq = 0.5, pan = 0.0, mix = 0.7, harmonic = 2.pow(33.5/12);

    //Electric Piano
	var snd, env;

	env = Env.adsr(att, dec, sus, rel).kr(gate: gate, doneAction: 2);

	snd = Pulse.ar(
		freq: freq * [1, harmonic], //Original used 33.5.midiratio here, which is just below the 7th harmonic.
		        width: [0.2, 0.1], //Play with these.
		        mul: [mix, (1 - mix)]
            );
	snd  = BLowPass4.ar(
		        in: snd,
		        freq: (cutoff * (env.squared)) + (200 + freq),
		        rq: rq
		    );
    snd = Mix.ar(snd) * env * amp;

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Nick Collins, from Mitchell Sigman, 2011. http://www.sussex.ac.uk/Users/nc81/index.html",
	category: \keyboards,
	tags: [\rhodes, \piano, \pitched]
	)
).add
);

(
Pbind(
	\instrument, "everythingrhodes",
    \ctranspose, 0,
    \legato, Pseq([0.9, 0.5, 0.5, 0.9, 0.5, 0.5, 0.5, 0.5, 0.9, 0.9, 1], inf),
	\dur, Pseq([3/4, 1, 1/4, 1/16, 3/16, Pn(1/4, 4), 1/2, 1], inf),
    \degree, Pseq([[0, 2, 4], [0, 2, 6], 7, 7, 8, 7, 6, 4, [1, 4, 6], [1, 4, 6], [0, 4, 7]], 1),
	\amp, 1,
).play;
)