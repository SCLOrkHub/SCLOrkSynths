/*
This Synthdef is centered around a challenge I gave myself: use as little blue text
as possible. (Which I guess translates to using as few UGens as possible). It's a
fun thing to do and you should try it out.

Here, everything is being controlled by a single line with a slope of one/second.
(It gets multiplied into three lines, but I'll get into why that is later.) If you
take the sine of something that continually increases at a rate of 1 per second,
you get a sine wave with a period of 2pi (or a freq of 1/(2pi)). To scale the wave,
I multiplied the input line by (2pi * lfoRate) so that it's new frequency is lfoRate.
The .mod(1) in the LFOs resets the input line to 0 at the start of each LFO cycle,
like how 2pi radians is the same as 0 radians. This .mod(1) can also be used on its
own to make a sawtooth wave, which is what I did, once again multiplying the input
line by freq inside the .mod(1) to scale it to the frequencies you want.

The envelope starts off with an upwards slope determined by the attack time, then
gets clipped at 1. The next section that gets subtracted from this is 0 until the
input line goes above a threshold corresponding to the attack time plus the sustain
time (written as "hold" here to differentiate from the sus level in an adsr envelope),
after which it rises to 1 with a slopedetermined by the decay time, after which
doneAction: 2 kicks in. The final result of all this is a linear asr envelope with
set attack, sustain, and release times. To give the envelope a curve like lots of
other SynthDefs in this collection, I raised the envelope to a power determined by
crv. The sustain level stays at one because of this, but the attack and release slopes
get bent in (if the power is > 1, meaning negative crv values) or out (if the power is
a positive fraction, meaning positive crv values).

All this phase shift business that comes next is inspired by a doepfer synth module.
This module takes in a sawtooth wave and outputs a sum of phase shifted copies of that
wave, using an analog version of the math here. Essentially, the input saw gets turned
into a pulse wave with the same frequency as the saw, but a pulseWidth determined by
the LFOs. Adding this to the original saw wave creates a saw with the same frequency,
a new phase, and a DC offset that gets subtracted out. The musical effect of all this
is a subtle chorus-y pwm-y sort of modulation.

Now let's talk about the two other slightly delayed input lines. They create two
slightly delayed copies of the final sound, and I've averaged all three copies together
at the end of the SynthDef. This creates a very simple low-pass-like filter. It's not
a true LPF, but it does lower the high frequency content of the sound just enough for
my ears to handle. Next is .softclip sort of doing the job of a limiter to protect your
ears, and a line emulating Pan2.ar. Pan2 is an equal power panner, so the sin and cos
are there to match that effect.

By Josh Mitchell, July 2020
*/

SynthDef(\line, {
	arg
	// Standard values
	out = 0, freq = 1000, pan = 0, amp = 0.1, att = 0.001, hold = 0.25, rel = 2, crv = -2,
	// lfo controls
	lfoARate = 5, lfoADepth = 0.25, phaseACenter = 0.35,
	lfoBRate = 2.7, lfoBDepth = 0.5, phaseBCenter = 0.5,
	// Other Controls (pSwitch is 0 or 1)
	pSwitch = 0, filterDelay1 = 0.00025, filterDelay2 = 0.00015;

	var input, lfoA, lfoB, phaseShiftA, phaseShiftB, env, saw,
	polarity, phaseA, phaseB, phase, snd;

	// Makes three lines with a slope of 1/second
	input = Line.ar(
		start: 0 ,
		end: att + hold + rel,
		dur: att + hold + rel,
		doneAction: 2);
	input = input - [0, filterDelay1, filterDelay2];

	// Make two sine LFOs with freq "lfoRate" and amplitude "lfoDepth"
	lfoA = sin(2pi * (lfoARate * input).mod(1)) * lfoADepth;
	lfoB = sin(2pi * (lfoBRate * input).mod(1)) * lfoBDepth;

	// Use the LFOs to determine a phase parameter from 0 to 1 cycles
	phaseShiftA = (phaseACenter + lfoA).wrap(0, 1);
	phaseShiftB = (phaseBCenter + lfoB).wrap(0, 1);

	// Make an asr envelope with a fixed sustain time
	env = (input/att).clip(0, 1);
	env = env - ((input - (att + hold))/rel).clip(0, 1);
	env = env.pow(exp(-1 * crv));

	// Make a sawtooth wave with freq "freq"
	saw = (input * freq).mod(1);
	polarity = 1 - (2 * pSwitch);

	// Make a pulse wave from the sawtooth wave
	phaseA = sign(sign(phaseShiftA - saw) + 0.5);
	phaseA = (phaseA - 1)/2 - phaseShiftA + 0.5;
	// Add it to the saw to get a phase-shifted saw
	phaseA = saw + phaseA;

	// Rinse and repeat
	phaseB = sign(sign(phaseShiftB - saw) + 0.5);
	phaseB = (phaseB - 1)/2 - phaseShiftB + 0.5;
	phaseB = saw + phaseB;

	// Add it all together
	snd = ((polarity * (saw - 0.5)) + phaseA + phaseB)/2;
	snd = snd * env;

	// Filter the sound a tiny bit
	snd = (snd[0] + snd[1] + snd[2])/3 * amp;

	// Output Stuff
	snd = snd.softclip;
	snd = [snd * cos((pan + 1) * pi/4), snd * sin((pan + 1) * pi/4)];

	Out.ar(out, snd);
},
metadata: (
	credit: "by Josh Mitchell",
	category: \pads,
	tags: [\pitched]
)
).add;