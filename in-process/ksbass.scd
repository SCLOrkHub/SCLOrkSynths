/*
This is a synthDef based on Karplus-Strong synthesis (just like Pluck.ar).

Karplus-Strong synthesis involves an initial impulse being sent through a delay,
which then, through a feedback loop, creates a sound with a frequency given by
1/(the delay time), which often sounds like a string pluck. There's usually a
filter in the feedback loop of the delay, which is the coef argument of Pluck.
It's pretty important to the string sound. However, it takes math to get the
pitch right when there's any filter in the feedback loop, and I don't really
like the typical Pluck.ar sound anyways.

So, I rebuilt a simpler version of Pluck! The biggest difference aside from the
filter being after the delay line, instead of in a feedback loop, is the initial
pulse I used. Using a sharp impulse produces a saw-like sound, but the initial
shape I made looks a bit like a trapezoid, for a less "buzzy" sound. The shape
of it varies with the impulse Att, Sus, Dec, and Hold parameters; if one is
bigger, that section of the shape lasts for a longer percentage of the waveform.

Stethoscope.new is helpful when playing around with the shape.

By Josh Mitchell June 2020
*/

SynthDef("ksbass", {
    arg
	// Standard Values
	out = 0, pan = 0, freq = 100, amp = 1, rel = 1.5,
        // Parameters for the impulse shape
	impulseAtt = 0.5, impulseSus = 1, impulseDec = 0.5, impulseHold = 1,
	// Filter parameters
	filtermin = 250, filtermax = 5000, rq = 0.35;

	var total, exciter, snd;

	// Rescale impulse values for the frequency of the note
	total = (impulseAtt + impulseSus + impulseDec + impulseHold) * freq;

	// Initial impulse
	exciter = Env.linen(
		attackTime: impulseAtt/total,
		sustainTime: impulseSus/total,
		releaseTime: impulseDec/total).ar;

	// Delay line
	snd = CombN.ar(
		in: exciter,
		maxdelaytime: 0.06,
		delaytime: 1/freq,
		decaytime: rel);

	// LPF
	snd = RLPF.ar(
		in: snd,
		freq: LinExp.ar(Amplitude.ar(in: snd), 0, 1, filtermin, filtermax),
		rq: rq);

	// Output stuff
	snd = Mix.ar(snd) * amp;
	snd = Limiter.ar(snd);

	DetectSilence.ar(in: snd, doneAction: 2);

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Josh Mitchell",
	category: \bass,
	tags: [\pitched, \bass]
	)
).add;

},
metadata: (
	credit: "Josh Mitchell",
	category: \bass,
	tags: [\pitched, \bass]
	)
).add;
