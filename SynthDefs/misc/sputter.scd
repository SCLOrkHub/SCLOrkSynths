/*
This SynthDef started with an idea for a "1-bit resonator." One method for creating a
regular resonator is to send a sound through a very short delay and add that back to
the original, with some amounnt of feedback. In my one bit version, that sound was to
be a single square wave from 0 to 1, (hence one bit) that got combined with a delay
line that had no feedback, using logic gates for a one bit, 1-or-0 output.

I decided I wanted volume control, so I added an envelope, and shifted from using logic
gates to using math that works kinda like those logic gates, but that responds to and
outputs a continuous range of numbers, not just a 1 or 0. I have five options that you
can select between, by setting the method control to 0, 1, 2, 3, or 4 (values in between
and outside get rounded). Each one gives a slightly different sound.

I also added some pulse width modulation on the initial square wave, with controls for
rate, depth, and the default center pulse width value. Turning pwmRate up past 20hz starts
to make some cool noises.

Next I decided to make the SynthDef stereo. Now each delay line has a different frequency
(1/delay time) that both ramp from resStartFreq. I also added a stereo width contrl from
0 (the sounds get mixed down to mono) to 1 (the sounds are hard-panned opposite to each
other). If you use negative numbers for stereoWidth, the left and right channels get
swapped.

After all this I decided that the SynthDef was missing a sputtery end to all its notes.
Really old videogames have unique note decays because of their relatively low bit depths.
Sometimes when the volume of a note decays to between on and off, it'll get rounded weird,
and "sputter" a bit because the note fluctuates between getting rounded up and rounded
down to silence. At least, that's my understanding. I replicated and amplified this effect
using Schmidt.ar and a bit of noise, which combine to replicate the process I described.
You can control the threshold of the gate that's deciding when to round up or down with
gateThresh; this alters the release time of the note. You can also turn it off by setting
the gateSwitch to 0.

By Josh Mitchell August 2020
*/

SynthDef(\sputter, {
	arg
	//Standard Values
	out = 0, pan = 0, amp = 0.05, freq = 330, att = 0.005, rel = 3.5, crv = -6,
	// Modulation Controls
	pw = 0.5, noiseDepth = 0.05, pwmRate = 12, pwmDepth = 0.15,
	// Resonator controls
	resStartFreq = 2000, resFreqL = 500, resFreqR = 5000, resAtt = 0.5,
	// Other Controls (all go from 0 to 1, except for method from 0 to 4)
	method = 0, gateSwitch = 1, gateThresh = 0.5, stereoWidth = 0.75;

	var env, envNoise, resControl, pwm, snd, res;

	// Make an Envelope
	env = Env.perc(
		attackTime: att,
		releaseTime: rel,
		curve: crv
	).ar;

	// Add a Little Noise to the Envelope
	envNoise = [
		LFClipNoise.ar(
			freq: freq).range(0, noiseDepth),
		LFClipNoise.ar(
			freq: freq).range(0, noiseDepth)
	];
	envNoise = Schmidt.ar(
		in: env,
		lo: 0.0001,
		hi: 0.0001
	) * envNoise;
	env = env + envNoise;

	// Make an LFO for the Pulse Width
	pwm = LFTri.ar(
		freq: pwmRate,
		mul: pwmDepth
	);
	pwm = (pwm + pw).clip(0, 1);

	// Make a Square Wave
	snd = LFPulse.ar(
		freq: freq,
		width: pwm,
		mul: env
	);
	// Make a Noise Gate
	snd = snd * Schmidt.ar(
		in: snd,
		lo: gateThresh * gateSwitch,
		hi: gateThresh
	);

	//Make a Resonator for the Square
	resControl = Line.ar(
		start: resStartFreq,
		end: [resFreqL, resFreqR],
		dur: resAtt
	);
	res = DelayC.ar(
		in: snd,
		maxdelaytime: [
			(1/resStartFreq).max(1/resFreqL),
			(1/resStartFreq).max(1/resFreqR)],
		delaytime: 1/resControl
	);

	// Choose how to Combine the Square and Resonator
	snd = Select.ar(
		which: method.clip(0, 4).round(1),
		array: [
			(snd + res).clip(0, 1),         // kinda like "snd or res"
			(snd + res).wrap(0, 1),         // kinda like "snd or res"
			snd * res,                      // kinda like "snd and res"
			(1 - snd) * res,                // kinda like "not-snd and res"
			((1 - snd) * res) + ((1 - res) * snd) // like "snd xor res"
	]);
	snd = LeakDC.ar(snd);

	// Set the Stereo Width
	snd = XFade2.ar(
		inA: [snd[1], snd[0]],
		inB: [snd[0], snd[1]],
		pan: stereoWidth
	);

	// Output Stuff
	snd = HPF.ar(
		in: snd,
		freq: freq/2
	);
	snd = snd * amp;
	snd = Limiter.ar(snd);

	DetectSilence.ar(in: Mix.ar(snd), doneAction: 2);

	// Stereo Version of Pan2.ar
	snd = Balance2.ar(
		left: snd[0],
		right: snd[1],
		pos: pan
	);

	Out.ar(out, snd);
},
metadata: (
	credit: "Josh Mitchell",
	category: \misc,
	tags: [\pitched, \stereo]
	)
).add;