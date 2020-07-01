/*
moreHarmonics does exactly what it says: it gives an input more harmonics.

It uses a few methods for doing so (but not every possible method):
-two methods for saturation (.softclip and .tanh, which is more distorted),
-two methods for wavefolding, one smooth (SinOsc.ar) and one sharp (.fold),
-a way of wrapping waves around from 1 to -1, like the sides in pacman (.wrap),
-and a sort of square-wave-ifier using a Schmitt trigger.

You can mix between them with blend, select, and focus. Blend goes from 0 to 1,
and determines the amount of square-wave-ification. Select goes from 0 to 4, and
chooses between the other 5 methods in the order I listed them. Focus blends in
adjacent methods from that list.

Preamp sets the gain of the sine wave going into all this stuff, and determines
the timbre of the sound. Threshold is the threshold of the Schmitt trigger.

By Josh Mitchell June 2020.
*/

SynthDef("moreHarmonics", {
    arg
	// Standard Values
	out = 0, pan = 0, freq = 160, amp = 1, gate = 1,
	att = 0.05, dec = 0.1, sus = 0.6, rel = 0.7, crv = -2,
	// Other controls
	preamp = 15, blend = 0, select = 2, focus = 0, threshold = 0.1;

	var env, snd, thresh;

	// Envelope:
	env = Env.adsr(
		attackTime: att,
		decayTime: dec,
		sustainLevel: sus,
		releaseTime: rel,
		curve: crv).ar(gate: gate, doneAction: 2);
	env = env * preamp;

	// The sound being sent through everything:
	snd = SinOsc.ar(freq: freq, mul: env);

	// The list of tricks:
	snd = [
		snd.softclip,
		snd.tanh,
		SinOsc.ar(freq: 0, phase: (snd * pi/2).mod(2pi)),
		snd.fold(-1, 1),
		snd.wrap(-1, 1)
	];

	// Schmitt trigger
	thresh = threshold.clip(0, 0.9999);
	snd = (Schmidt.ar(snd, -1 * thresh, thresh) * blend) + (snd * (1 - blend));

	// Mixing it all together
	snd = SelectXFocus.ar(
		which: select.clip(0, 4),
		array: snd,
		focus: 1 - focus.clip(0, 1).sqrt,
		wrap: false);

	// Output Stuff:
	snd = Mix.ar(snd) * amp;
	snd = Limiter.ar(snd);

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Josh Mitchell",
	category: \misc,
	tags: [\pitched]
	)
).add;