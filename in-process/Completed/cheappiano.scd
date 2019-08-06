/* Recieved from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/cheappiano.scd

Modified by Josh Mithell and Bruno Ruviaro July 2019
*/
(
SynthDef(\cheappiano, { arg out = 0, freq = 440, amp = 0.1, att = 0.001, rel = 1, pan = 0, breakdown = 0;
	//var snd, in, n = 6, max = 0.04, min = 0.01, delay, pitch, detune, hammer;
	var hammer, snd, detune, delay;
	freq = freq.cpsmidi;
	hammer = Decay2.ar(Impulse.ar(0.001), (breakdown + 1) * 0.008, (breakdown + 1) * 0.04, LFNoise2.ar([2000, 4000].asSpec.map(amp), 0.25));
	snd = Mix.ar(Array.fill(3, { arg i;
			detune = #[-0.04, 0, 0.03].at(i);
			delay = (1 / (freq + detune).midicps);
			CombL.ar(hammer, delay, delay, 50 * amp)
		}) );

	snd = HPF.ar(snd, 50) * Env.perc(att, rel, amp * 4, -1).ar;
	Limiter.ar(snd);
	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "based on something posted 2008-06-17 by jeff, based on an old example by james mcc",
	tags: [\casio, \piano, \pitched]
	)
).add
);

(
SynthDef(\cheappiano, { arg
	//Standard values
	out = 0, freq = 440, amp = 0.1, att = 0.001, rel = 1, pan = 0,
	//These range from 0 to 1
	tone = 0.25, hipass = 0;

	var hammer, snd, delay, tonefreq;
	// Delay line times: freq, freq - 4 cents, freq + 3 cents. In the original this was done by converting freq to midi.
	delay = (1 / (freq * [2.pow(-0.04/12), 1, 2.pow(0.03/12)]));
	tonefreq = tone.linlin(0, 1, 1000, 5000);

	hammer = Decay2.ar(
		in: Impulse.ar(0.001),
		attackTime: 0.008,
		decayTime: 0.04,
		mul: LFNoise2.ar(freq: amp.linlin(0, 1, tonefreq, 2 * tonefreq), mul: 0.25)
	); //Try LFNoise1, LFNoise0, or even LFClipNoise above for a slightly grainier sound.
	snd = CombL.ar(hammer, delay, delay, 50 * amp);
	snd = HPF.ar(snd, hipass.linlin(0, 1, 50, 1000)) * Env.perc(att, rel, amp * 4, -1).ar;
	Limiter.ar(snd);
	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "based on something posted 2008-06-17 by jeff, based on an old example by james mcc",
	tags: [\casio, \piano, \pitched]
	)
).add
);

Synth(\cheappiano);

FreqScope.new;


(
Pbind(
    \instrument, \FMRhodes2,
    \scale, Scale.mixolydian,
    \ctranspose, -4,
    \legato, Pseq([0.9, 0.5, 0.5, 0.9, 0.9, 0.9, 0.9, 0.5, 1, 0.5, 1, 0.6, 0.3], inf),
    \dur, Pseq([1 + (1/3), 1/3, 1/3, 1/7, 6/7, 5/6, 1/6, 1/2, 2/6, 1/6, 2 + 1/2, 1, 1/2], inf),
    \degree, Pseq([
        [0, 2, 4], 2, 4, 7, 8, 7, 0, [1, 3, 6], 5, [1, 3, 6], Rest(), [-1, 1, 3], [1, 3, 5],
        [0, 2, 4], 2, 4, 8, 9, 7, 0, [1, 3, 6], 5, [1, 3, 6], Rest(), [-1, 1, 3], [1, 3, 5],
    ], inf),
	\amp, 0.5,
).play(TempoClock(1.5));
)

