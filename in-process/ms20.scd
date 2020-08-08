/*
In progress. I don't have the filters right and that's like, the most important part, man.

By Josh Mitchell July 2020.
*/
(
SynthDef(\ms20, {
	arg
	// Standard Values
	out = 0, amp = 0.1, gate = 1, freq = 100, pan = 0,
	// Controls for env2 (the main one)
	hold = 0, att = 0.005, dec = 0.3, sus = 0.5, rel = 0.2, hpfEnvDepth = 80, lpfEnvDepth = 200,
	// Controls for env1
	delay1 = 0.01, att1 = 0.5, rel1 = 2, pitchEnvRatio = 1,
	// Controls for modGen
	modRate = 18, modShape = 0.5, vibrato = 5, hpfModDepth = 10, lpfModDepth = 10,
	// Controls for oscillators
	waveform1 = 2, pw = 0.5, waveform2 = 3, pitch2 = 7, oscBlend = 0.5,
	// Controls for filters
	preamp = 1, hpfFreq = 200, lpfFreq = 900, hpfPeak = 2.5, lpfPeak = 2.5;

	var modGen, env1, env2, osc1Control, osc1, shiftOsc2, osc2Control, osc2,
	snd, lpfControl, lpfRes, hpfControl, hpfRes;

// Modulation and Envelopes
	// The LFO controls Pitch and Filter Cutoff by Default
	modGen = VarSaw.ar(
		freq: modRate,
		width: modShape
	);

	// env1 Controls Pitch by Default
	env1 = Env.asr(
		attackTime: att1,
		sustainLevel: 1,
		releaseTime: rel1,
		curve: -3).delay(delay1).ar(gate: gate);
	env1 = env1;
	env1 = env1 * (1 - pitchEnvRatio.clip(0, 1));
	env1 = env1 + pitchEnvRatio.clip(0, 1);

	// env2 Controls Amplitude and Filter Cutoff by Default
	env2 = Env.adsr(
		attackTime: att,
		decayTime: dec,
		sustainLevel: sus,
		releaseTime: rel,
		curve: -3).delay(hold).ar(gate: gate, doneAction: 2);

// Oscilators
	// Oscilator 1 Pitch Input
	osc1Control = freq;// + LFNoise2.ar(0.05).range(-0.01, 0.01);
	osc1Control = osc1Control + (modGen * vibrato);
	osc1Control = osc1Control * env1;

	// Oscilator 1
	osc1 = Select.ar(
		which: waveform1.clip(0, 3),
		array: [
			LFTri.ar(freq: osc1Control),
			LFSaw.ar(freq: osc1Control),
			LFPulse.ar(freq: osc1Control, width: pw),
			WhiteNoise.ar
	]);

	// Oscilator 2 Pitch Input
	osc2Control = freq;// + LFNoise2.ar(0.05).range(-0.01, 0.01);
	osc2Control = osc2Control + (modGen * vibrato);
	osc2Control = osc2Control * env1 * pitch2.midiratio;

	// Oscillator 2
	osc2 = Select.ar(
		which: waveform2.clip(0, 3),
		array: [
			LFSaw.ar(freq: osc2Control),
			LFPulse.ar(freq: osc2Control),
			Impulse.ar(freq: osc2Control);
			LFPulse.ar(freq: osc1Control).bitXor(LFPulse.ar(freq: osc2Control))
	]);

	// Oscilator Blend
	snd = XFade2.ar(
		inA: osc1,
		inB: osc2,
		pan: oscBlend,
		level: preamp.clip(0, 1));

// High Pass Filter
	// HPF Cutoff Input
	hpfControl = hpfFreq + (modGen * hpfModDepth);
	hpfControl = hpfControl + ((env2 - sus) * hpfEnvDepth);

	// HPF Input
	snd = HPF.ar(
		in: snd,
		freq: hpfControl);
	snd = (snd * 0.75).softclip * 1.5;

	// Resonance Nonlinearity
	hpfRes = snd * hpfPeak;
	hpfRes = (hpfRes * 5).distort;

	// Resonance for HPF
	hpfRes = HPF.ar(
		in: hpfRes,
		freq: hpfControl);
	hpfRes = (hpfRes * 0.75).softclip * 1.5;
	hpfRes = LPF.ar(
		in: hpfRes,
		freq: hpfControl);
	hpfRes = (hpfRes * 0.75).softclip * 1.5;

	// HPF Output
	snd = snd + hpfRes;

// Low Pass Filter
	// LPF Cutoff Input
	lpfControl = lpfFreq + (modGen * lpfModDepth);
	lpfControl = lpfControl + ((env2 - sus) * lpfEnvDepth);

	// LPF Input
	snd = LPF.ar(
		in: snd,
		freq: lpfControl);
	snd = (snd * 0.75).softclip * 1.5;
	snd = snd + LocalIn.ar; // Resonance gets fed back to here
	snd = LPF.ar(
		in: snd,
		freq: lpfControl);
	snd = (snd * 0.75).softclip * 1.5;

	// Resonance Nonlinearity
	lpfRes = (snd * 5).distort;
	lpfRes = lpfRes * lpfPeak;

	// Resonance for LPF
	lpfRes = HPF.ar(
		in: lpfRes,
		freq: lpfControl);
	lpfRes = (lpfRes * 0.75).softclip * 1.5;
	LocalOut.ar(lpfRes);

// Output Stuff
	// Noisy VCA
	snd = snd + (PinkNoise.ar(2).tanh * 0.001);
	snd = snd * env2;

	snd = Mix.ar(snd) * amp;
	snd = Limiter.ar(snd);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Josh Mitchell",
	category: \keyboards,
	tags: [\pitched]
	)
).add;
)

Stethoscope.new;
FreqScope.new;

(
PmonoArtic( \ms20,
	\instrument, "ms20",
	\freq, Prand([100, 150, 120, 200], inf) * 1,
	\dur, Pseq([0.175], inf),
	\legato, Prand([0.5, 1.5], inf),
).play;
)
