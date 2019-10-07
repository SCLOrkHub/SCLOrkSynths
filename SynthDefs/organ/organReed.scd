/* Retrieved from
http://sccode.org/1-5aD

Reed Organ Simulation
Original by Nathan Ho aka Snappizz
http://sccode.org/1-51m

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("organReed", {
    arg
	//Standard Values
	out = 0, pan = 0, freq = 440, amp = 0.3, gate = 1, att = 0.3, rel = 0.3,
	//Depth and Rate Controls (pwmDepth and amDepth range from 0 to 1)
	ranDepth = 0.04, pwmRate = 0.06, pwmDepth = 0.1, amDepth = 0.05, amRate = 5,
	//Other Controls
	nyquist = 18000, fHarmonic = 0.82, fFreq = 2442, rq = 0.3, hiFreq = 1200, hirs = 1, hidb = 1;

    var snd, env;

	// The same envelope controls both the resonant freq and the amplitude
    env = Env.asr(
		attackTime: att,
		sustainLevel: amp,
		releaseTime: rel).ar(gate: gate, doneAction: 2);

    // pulse with modulating width
	snd = Pulse.ar(
		freq: TRand.ar(lo: 2.pow(-1 * ranDepth), hi: 2.pow(ranDepth), trig: gate) * freq,
		width: LFNoise1.kr(freq: pwmRate, mul: pwmDepth).range(0, 1),
		mul: 0.0625);  //Incereasing this lessens the impact of the BPF

    // add a little "grit" to the reed
    //original used snd = Disintegrator.ar(snd, 0.5, 0.7);
	snd = Latch.ar(snd, Impulse.ar(nyquist * 2));

    // a little ebb and flow in volume
	snd = snd * LFNoise2.kr(freq: amRate).range((1 - amDepth), 1);

	//Filtering (BHiShelf intensifies the buzzing)
	snd = snd + BPF.ar(in: snd, freq: env.linexp(0, amp, fFreq * fHarmonic, fFreq), rq: rq);
    snd = BHiShelf.ar(in: snd, freq: hiFreq, rs: hirs, db: hidb);

	//Output
	snd = Mix.ar(snd * env);

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Nathan Ho aka Snappizz",
	category: \organ,
	tags: [\pitched, \tom, \sos]
	)
).add;