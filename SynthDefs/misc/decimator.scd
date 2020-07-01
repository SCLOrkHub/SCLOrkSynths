/*
This is a synthDef that's inspired by (and tries to replicate) the Decimator quark.

The decimator quark allows you to change the sample rate and bit depth of a signal,
independently of the sample rate and bit depth supercollider is currently running at.
These changes are done in this SynthDef through Latch.ar (a sample-and-hold) and .round,
respectively.

I've also added a pair of low pass filters at the beginning and end of these sections,
as a very basic simulation of an analog-to-digital-to-analog converter. The filters can
be switched on or off (listen to the demo), and they're currently set to half of the new
sample rate (the nyquist frequency). This is because, looking at the frequency domain,
sounds above the nyquist frequency get mirrored around it. Therefore, filtering out the
stuff above the nyquist frequency makes the resulting sound a bit cleaner.

Funnily enough, because of the weird things that happen above the nyquist frequency, my
sample rate clock is only able to go up to the nyquist frequency related to supercollider's
sampling rate without itself being aliased. I set a limit on my decimator's sample rate
because of this, but you can remove it if you want.

Lastly, the preamp control pushes the input signal above a hard clipping threshold to
simulate a signal that's too loud going into an adc. If you don't want this effect, set
the preamp control to 1.

By Josh Mitchell June 2020
*/

SynthDef("decimator", {
    arg
	//Standard Values
	out = 0, pan = 0, freq = 440, amp = 0.1, gate = 1,
	att = 0.001, dec = 0.1, sus = 0.9, rel = 1, crv = -2,
        //Other controls, filterswitch is 0 or 1
	preamp = 1, bitdepth = 16, samplerate = 10000, filterswitch = 0, filtermult = 0.5;

	var rate, env, snd, clock, remainder;

	//Set up the sample rate (Weird things happen above half of supercollider's sample rate)
    rate = samplerate.clip(20, SampleRate.ir/2);

	//Simple adsr envelope
	env = Env.adsr(
		attackTime: att,
		decayTime: dec,
		sustainLevel: sus,
		releaseTime: rel,
		curve: crv).ar(gate: gate, doneAction: 2);

	// Fix the input signal range
	snd = SinOsc.ar(freq: freq, mul: 0.5 * preamp, add: 0.5);
	snd = snd * env;

	//Input filtering to simulate a very cheap adc
	snd = Select.ar(
		which: filterswitch,
		array: [snd, LPF.ar(in: snd, freq: rate * filtermult)]);

	//Sampe Rate Reduction
	clock = LFPulse.ar(freq: rate, width: 0.001) - 0.5;
	snd = Latch.ar(snd, clock);

	//Bit Depth Reduction
	remainder = 2.pow(bitdepth).mod(1);
	snd = Clip.ar(
		in: snd,
		lo: 0,
		hi: 1);
	snd = XFade2.ar(
		inA: snd.round(1/(2.pow(bitdepth).floor)),
		inB: snd.round(1/(2.pow(bitdepth).ceil)),
		pan: (remainder * 2) - 1);

	//Output filtering to simulate a very cheap dac (and other output stuff)
	snd = Mix.ar(((snd * 2) - 1)) * amp;
	snd = Select.ar(
		which: filterswitch,
		array: [snd, LPF.ar(in: snd, freq: rate * filtermult)]);
	snd = LeakDC.ar(snd);
	snd = Limiter.ar(snd);

	Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Josh Mitchell",
	category: \misc,
	tags: [\pitched, \noisy]
	)
).add;
