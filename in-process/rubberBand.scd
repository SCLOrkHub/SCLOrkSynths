/*
A for-fun little work in progress

By Josh Mitchell July 2020.
*/

SynthDef(\rubberBand, {
	arg
	// Standard Values
	out = 0, amp = 1, trig = 1, freq = 75, pan = 0, att = 0, rel = 1,
	// Impulse arguments (coef and onFraction go from 0 to 1)
	freqMultiple = 0.25, bendTime = 0.075, impulseStartFreq = 800,
	impulseStopFreq = 120, onFraction = 1, coef = 0.125;

	var impulse, freqline, snd;

	freqline = Line.ar(
		start: freq * freqMultiple,
		end: freq,
		dur: bendTime);

	impulse = SinOsc.ar(
		freq: Line.ar(
			start: impulseStartFreq,
			end: impulseStopFreq,
			dur: 1/freq * onFraction));

    snd = Pluck.ar(
	    in: impulse,
	    trig: trig,
	    maxdelaytime: 1/(freq * freqMultiple),
	    delaytime: 1/freqline,
	    decaytime: rel,
	    coef: coef,
		mul: amp);

    DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Josh Mitchell",
	category: \keyboards,
	tags: [\pitched]
	)
).add;