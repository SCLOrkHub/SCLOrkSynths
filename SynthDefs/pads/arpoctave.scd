/*
The core of this is an octave arppegiator based around
modulo (.mod) and Select.ar, both of which are pretty fun.

The rest of the stuff is to make a nice ambient pad-type sound.

Notes:
    Try LFNoise2 with 2 rates for the chorus
    Try other waveforms for the arp and dry sections
    Try new foods
    Try controlling the filter cutoff with envarp
    Try all the things

Made by Josh Mitchell 2/20.
*/

SynthDef("arpoctave", {
	arg
	//Standard Controls:
	out = 0, amp = 0.1, freq = 220, pan = 0, gate = 1, att = 0.3, rel = 1, crv = 0,
	//Arp Controls: (mix goes from 0 to 1)
	arprate = 10, arpatt = 0.7, arprel = 0.6, arpmix = 0.35,
	//Chorus and Pitch Bend Controls:
	chorusrate = 0.5, chorusdepth = 0.015, div = 0.25, glide = 0.15,
	//Filter and Delay Controls:
	rq = 0.75, cutoff = 8000, delayt = 0.25, decay = 2, delamp = 0.5;

	var freqk, freqarp, chorus, bend, env, dry, envarp, arp, snd;

//LFOs and Envelopes for Amps, Freqs, and the Filter Cutoff:

	//Envelopes for the arp and dry signals (dry also controls the filter freq):
	env = Env.asr(
		        attackTime: att,
		        releaseTime: rel,
		        curve: crv).ar(gate: gate);
	envarp = Env.asr(
		        attackTime: arpatt,
		        releaseTime: arprel,
		        curve: crv).ar(gate: gate);

	//A chorus-ish sound made by two freq LFOs perfectly out of phase:
	chorus = SinOsc.ar(
		        freq: chorusrate,
		        phase: [0, pi]).range((1 - chorusdepth), (1 + chorusdepth));

	//A bit of portamento at the start of the dry signal:
	bend = Line.ar(start: div, end: 1, dur: glide);

//The Arp and Dry Signals:

	//This makes an aray of all octaves above and below the note being played:
	freqk = ((freq * 2.pow(2/3)).cpsmidi.mod(12) + 16).midicps;
	freqk = freqk * Array.fill(6, {arg i; 2.pow(i)}); // try 2 to 9 instead of 6

	//This randomly jumps between those octaves:
	freqarp = Select.kr(LFNoise0.ar(arprate).range(0, freqk.size), freqk);

	//Arp: Experiment with waveforms!
	arp = LFPulse.ar(freq: freqarp * chorus, mul: envarp);
	arp = Mix.ar(arp);

	//Dry: Experiment with waveforms!
	dry = LFTri.ar(freq: freq * chorus * bend, mul: env);
	dry = Mix.ar(dry);

//Output Stuff:

	//Mixer:
	snd = XFade2.ar(dry, arp, ((arpmix * 2) - 1), amp);

	//Low Pass Filter for mellowness:
	snd = RLPF.ar(
		        in: snd,
		        freq: LinExp.ar(
			                in: env,
			                dstlo: freq,
			                dsthi: cutoff),
                rq: rq);

	//Delay for Space:
	snd = snd + CombN.ar(
		            in: snd,
		            maxdelaytime: delayt,
		            delaytime: delayt,
		            decaytime: decay,
		            mul: delamp);

	//Don't hurt your ears and equipment!
	snd = Limiter.ar(LeakDC.ar(snd));

	DetectSilence.ar(in: snd, doneAction: 2);
	Out.ar(out, Pan2.ar(snd));
},
metadata: (
	credit: "Josh Mitchell",
	category: \pads,
	tags: [\pitched]
	)
).add;