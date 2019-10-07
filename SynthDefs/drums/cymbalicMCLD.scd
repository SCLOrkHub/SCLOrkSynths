/*
Recieved from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/cymbalic_mcld.scd

Based on the example at
http://www.mcld.co.uk/cymbalsynthesis/
published 2008 by Dan Stowell
Synth(\cymbalic_mcld)

Modified by Bruno Ruviaro and Josh Mitchell 8/19
*/

SynthDef(\cymbalicMCLD, {

	arg
	//Standard Values
	out = 0, pan = 0, amp = 0.5, att = 0.001, rel = 0.5, curve = -4,
	//Filter Frequencies
	lodriverMax = 20000, lodriverMin = 10, hidriverMax = 10001, hidriverMin = 1, hiAtt = 1, hiRel = 3, loAtt = 0.5, loRel = 5;

	var lodriver, locutoffenv, hidriver, hicutoffenv, freqs, snd, thwack, env;

	locutoffenv = Env.perc(attackTime: loAtt, releaseTime: loRel, level: (lodriverMax - lodriverMin), curve: curve).kr;

	lodriver = LPF.ar(WhiteNoise.ar(0.1), (locutoffenv + lodriverMin));

	hicutoffenv = Env.perc(attackTime: hiAtt, releaseTime: hiRel, level: (hidriverMax - hidriverMin), curve: curve).kr;

	hidriver = HPF.ar(WhiteNoise.ar(0.1), (hidriverMax - hicutoffenv));
	hidriver = hidriver * Env.perc(attackTime: hiAtt, releaseTime: 2/3 * hiRel, level: 0.25).kr;

	thwack = Env.perc(attackTime: att, releaseTime: att).kr;

	// This bit will regenerate new freqs every time you evaluate the SynthDef!
	freqs = {exprand(300, 20000)}.dup(100);

	env = Env.new(levels: [0, amp, amp, 0], times: [att, (loRel + hiRel), rel]).kr(doneAction: 2);

	snd = Ringz.ar(in: lodriver + hidriver + thwack, freq: freqs).mean;
	snd = Mix.ar([(snd * 1), (lodriver * 2), thwack]);
	snd = snd * env;
	snd = Limiter.ar(snd, amp);

	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Dan Stowell",
	category: \drums,
	tags: [\percussion, \cymbal, \gong, \inharmonic, \additive, \subtractive]
	)
).add;