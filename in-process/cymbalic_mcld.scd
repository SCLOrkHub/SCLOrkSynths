/*
Recieved from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/cymbalic_mcld.scd

Based on the example at
http://www.mcld.co.uk/cymbalsynthesis/
published 2008 by Dan Stowell
Synth(\cymbalic_mcld)
*/
SynthDef(\cymbalic_mcld, { |out=0, pan=0, amp=0.1|
	var lodriver, locutoffenv, hidriver, hicutoffenv, freqs, res, thwack;
	
	locutoffenv = EnvGen.ar(Env.perc(0.5, 5)) * 20000 + 10;
	lodriver = LPF.ar(WhiteNoise.ar(0.1), locutoffenv);
	
	hicutoffenv = 10001 - (EnvGen.ar(Env.perc(1, 3)) * 10000);
	hidriver = HPF.ar(WhiteNoise.ar(0.1), hicutoffenv);
	hidriver = hidriver * EnvGen.ar(Env.perc(1, 2, 0.25));
	
	thwack = EnvGen.ar(Env.perc(0.001,0.001,1));
	
	// This bit will regenerate new freqs every time you evaluate the SynthDef!
	freqs  = {exprand(300, 20000)}.dup(100);
	
	res    = Ringz.ar(lodriver + hidriver + thwack, freqs).mean;
	
	Out.ar(out, Pan2.ar(((res * 1) + (lodriver * 2) + thwack) * amp, pan));
},
metadata: (
	credit: "Based on the example at http://www.mcld.co.uk/cymbalsynthesis/ published 2008 by Dan Stowell",
	tags: [\percussion, \cymbal, \gong, \inharmonic, \additive, \subtractive]
	)
)
