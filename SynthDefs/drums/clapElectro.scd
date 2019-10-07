/* Retrieved from
http://sccode.org/1-5aD

Original by Nathan Ho aka Snappizz, http://sccode.org/1-523

**Note: Cool reverse-snare type sounds can be achieved with a slightly longer attack**

Modified By Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("clapElectro", {
    arg
	//Standard Arguments
	out = 0, amp = 0.5, pan = 0, att = 0.02, rel = 0.2, curve = -4,
	//Other Controls: mix is 0 - 1, fadeTime is a fraction of noise1's length.
	mix = 0.6, fadeFreq = 4000, fadeTime = 0.52;

    var env1, env2, snd, noise1, noise2;

    // noise 1: four short repeats
    env1 = Env.new(
            levels: [0, 1, 0, 0.9, 0, 0.7, 0, 0.5, 0],
            times: [att / 20, 0.009, 0, 0.008, 0, 0.01, 0, 0.03],
            curve: [0, curve, 0, curve, 0, curve, 0, curve]
        ).kr;

    noise1 = WhiteNoise.ar(env1);
	noise1 = HPF.ar(in: noise1, freq: 600);
    noise1 = LPF.ar(
		    in: noise1,
		    freq: XLine.kr(start: 7200, end: fadeFreq, dur: fadeTime * 0.058)
	    );
    noise1 = BPF.ar(in: noise1, freq: 1620, rq: 3);

    // noise 2: one longer single burst
	env2 = Env.perc(attackTime: att, releaseTime: rel, curve: [0, curve]).kr;

    noise2 = WhiteNoise.ar(env2);
    noise2 = HPF.ar(in: noise2, freq: 1000);
    noise2 = LPF.ar(in: noise2, freq: 7600);
    noise2 = BPF.ar(in: noise2, freq: 1230, rq: 0.7);

	//Mixing
	snd = Mix.ar((mix * noise1) + ((1 - mix) * noise2));
	snd = (snd * 2).softclip;
	snd = snd * amp;

	DetectSilence.ar(in: snd, doneAction: 2);

    Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Nathan Ho aka Snappizz, http://sccode.org/1-523",
	category: \drums,
	tags: [\unpitched, \clap, \electronic, \percussion]
	)
).add;