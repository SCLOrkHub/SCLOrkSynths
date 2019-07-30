(
SynthDef(\cheapPiano2, {
	arg
	//Standard values
	out = 0, freq = 440, amp = 0.1, att = 0.001, rel = 1, pan = 0, resonantFreq = 4320,
	//These range from 0 to 1
	tone = 0.25, hipass = 0, resonance = 0.2;

	var hammer, snd, delay, noise;

	// Delay line times: freq, freq - 4 cents, freq + 3 cents. In the original this was done by converting freq to midi.
	delay = (1 / (freq * [2.pow(-0.04/12), 1, 2.pow(0.03/12)]));

	noise = LFPulse.ar(
		freq: [freq/2, freq/3, freq/2.5, freq/1.5],
		mul:SinOsc.ar(resonantFreq).range(((resonance - 1) * 0.25), 0.25)
	);
	hammer = Decay2.ar(
		in: Impulse.ar(0.001),
		attackTime: 0.1,
		decayTime: 0.04,
		mul: noise
	);

	snd = CombL.ar(hammer, delay, delay, 50 * amp);
	snd = Mix.ar(snd);
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

(
Pbind(
    \instrument, \cheapPiano2,
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