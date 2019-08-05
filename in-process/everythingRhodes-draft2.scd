/* Retrieved from
http://sccode.org/1-5aD

By Nick Collins, from Mitchell Sigman (2011) Steal this Sound
http://www.sussex.ac.uk/Users/nc81/index.html

Modified by Josh Mitchell and Bruno Ruviaro 8/19.
LFO added by Josh Mitchell 8/19
*/

(
SynthDef(\everythingrhodes, {
	arg
	//Standard Definitions
	out = 0, freq = 440, amp = 0.1, gate = 1, att = 0.001, dec = 1, sus = 0.8, rel = 3, pan = 0,
	//Other Controls
	cutoff = 2000, rq = 0.5, harmonic = 2.pow(33.5/12),
	//These Range from 0 to 1
	width = 0.2, mix = 0.7;

    //Electric Piano
	var snd, env, lfo;

	env = Env.adsr(att, dec, sus, rel).kr(gate: gate, doneAction: 2);

	snd = Pulse.ar(
	        	freq: freq * [1, harmonic], //Original used 33.5.midiratio here, which is just below the 7th harmonic.
	        	width: [width, width/2],
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
SynthDef(\everythingrhodes2, {
	arg
	//Standard Definitions
	out = 0, freq = 440, amp = 0.1, gate = 1, att = 0.001, dec = 1, sus = 0.8, rel = 3, pan = 0,
	//Other Controls
	cutoffharmonic = 15, rq = 0.03, harmonic = 2.pow(33.5/12), rate = 12.5,
	//These Range from 0 to 1
	depth = 1, width = 0.2, mix = 0.7;

    //Electric Piano
	var snd, env, lfo;

	env = Env.adsr(att, dec, sus, rel).kr(gate: gate, doneAction: 2);
	lfo = SinOsc.kr(freq: rate).range(width/10, width);

	snd = Pulse.ar(
	        	freq: freq * [1, harmonic], //Original used 33.5.midiratio here, which is just below the 7th harmonic.
	        	width: [(lfo * depth) + (width * (1 - depth)), (lfo/2 * depth) + (width/2 * (1 - depth))],
		        mul: [mix, (1 - mix)]
            );
	snd  = BLowPass4.ar(
		        in: snd,
		        freq: (cutoffharmonic * (env.squared)) * (freq),
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
    \ctranspose, -18,
    \legato, Pwhite(0.1, 0.8, inf),
	\dur, 3/4,
    \degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2, 1, 0], 1),
	\amp, 1,
).play;
)