/* Retrieved from
http://sccode.org/1-5aD

Original by Snapizz http://sccode.org/1-57f

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("neuroSnare", {
	arg
	//Basic Controls
	out = 0, pan = 0, amp = 0.1, freq = 160, curve = -4, preamp = 1.4,
	//Click Controls
	clickatt = 0.001, clicksus = 0.01, clickrel = 0.001, clickamp = 1, hipass = 300, lopass = 8000,
	//Body Controls
	bodyatt = 0.04, bodyrel = 0.2, bodyamp = 2,
	//Rattle Controls
	rattlehold = 0.01, rattleatt = 0.05, rattlerel = 0.2, rattleamp = 0.7, rattlefreq = 4000, rq = 0.5, rattlepeak = 3,
	//Sweep Controls
	sweepatt = 0.001, sweeprel = 0.02, sweepamp = 1, sweepstart = 3000, sweepend = 1500;

    var snd, click, cEnv, body, bEnvFreq, bEnvAmp, rattle, rEnv, sweep, sEnvFreq, sEnvAmp;

    // a percussive click to give it some attack
	cEnv = Env.linen(
		            attackTime: 0.001,
		            sustainTime: 0.01,
		            releaseTime: 0.001,
			        level: clickamp
	            ).ar;

	click = Hasher.ar(Sweep.ar);

	click = HPF.ar(in: click, freq: hipass);

    click = LPF.ar(in: click, freq: lopass);

	click = click * cEnv;

    // sine sweep body
	bEnvFreq = Env.new(
			        levels: [2.5, 1.225, 1],
			        times: [bodyatt, bodyrel],
			        curve: \exp
	            ).ar;

	bEnvAmp = Env.perc(
		            attackTime: bodyatt,
		            releaseTime: bodyrel,
		            level: bodyamp,
		            curve: curve
	            ).ar;

	body = SinOsc.ar(freq: freq * bEnvFreq, mul: bEnvAmp);

	body = body.tanh;

    // sound of snare coils rattling
	rEnv = Env.perc(
			        attackTime: rattleatt,
			        releaseTime: rattlerel,
			        level: rattleamp,
			        curve: curve
	            ).delay(rattlehold).ar;

	rattle = Hasher.ar(Sweep.ar);

	rattle = BPeakEQ.ar(in: rattle, freq: rattlefreq, rq: rq, db: rattlepeak);

	rattle = HPF.ar(in: rattle, freq: hipass);

	rattle = rattle * rEnv;

    // another sound sweep to improve the attack, optional
	sEnvFreq = XLine.kr(
		    	    start: sweepstart,
		    	    end: sweepend,
		    	    dur: sweeprel / 2
	            );

	sEnvAmp = Env.perc(
			        attackTime: sweepatt,
			        releaseTime: sweeprel,
			        level: sweepamp,
			        curve: curve
	            ).ar;

	sweep = SinOsc.ar(freq: sEnvFreq, mul: sEnvAmp);

    // distortion helps glue everything together and acts as a compressor
	snd = Mix.ar(click + body + rattle + sweep);

	snd = (snd * preamp).tanh * amp;

	DetectSilence.ar(in: snd, doneAction: 2);

	Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Original by Nathan Ho aka Snapizz",
	category: \drums,
	tags: [\unpitched, \snare]
	)
).add;