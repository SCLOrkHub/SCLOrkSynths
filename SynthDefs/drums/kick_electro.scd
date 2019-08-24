/* Retrieved from
http://sccode.org/1-5aD

Original by Nathan Ho aka Snappizz
http://sccode.org/1-523

Modified by Bruno Ruviaro and Josh Mitchell 8/19
*/

SynthDef(\kick_electro, {
    arg out = 0, pan = 0, amp = 0.3, att = 0.005, rel = 0.3;

    var body, bodyFreq, bodyAmp, pop, popFreq, popAmp, click, clickAmp, snd;

    // body starts midrange, quickly drops down to low freqs, and trails off
    bodyFreq = Env.new(
		    levels: [261, 120, 51],
		    times: [rel / 8.57, rel / 3.75],
		    curve: \exp
		).kr;

    bodyAmp = Env.linen(
		    attackTime: att,
		    sustainTime: rel / 3,
		    releaseTime: rel
	    ).kr;

    body = SinOsc.ar(freq: bodyFreq, mul: bodyAmp);

    // pop sweeps over the midrange
    popFreq = XLine.kr(start: 750, end: 261, dur: 0.02);

	popAmp = Env.linen(
		    attackTime: att / 5,
		    sustainTime: rel / 15,
		    releaseTime: rel / 30,
		    level: 0.15
	    ).kr;

    pop = SinOsc.ar(freq: popFreq, mul: popAmp);

    // click is spectrally rich, covering the high-freq range
    // you can use Formant, FM, noise, whatever
    clickAmp = Env.perc(
		    attackTime: att / 5,
		    releaseTime: rel / 300,
		    level: 0.15
	    ).kr;

    click = LPF.ar(
	    	in: Formant.ar(fundfreq: 910, formfreq: 4760, bwfreq: 2110),
	    	freq: 3140,
	    	mul: clickAmp
	    );

	//Putting it all together:
	snd = Mix.ar([body, pop, click]);
    snd = snd.tanh * amp;

	DetectSilence.ar(in: snd, doneAction: 2);

    Out.ar(out, Pan2.ar(snd, pan, amp));
},
metadata: (
	credit: "By Nathan Ho aka Snappizz",
	category: \drums,
	tags: [\percussive, \bass, \kick, \electronic]
	)
).add;