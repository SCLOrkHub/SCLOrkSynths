/* Retrieved from
http://sccode.org/1-5aD

Original by Nathan Ho aka Snappizz, http://sccode.org/1-523

**Note: Cool reverse-snare type sounds can be achieved with a slightly longer attack**

Modified By Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef(\clap_electro, {
    arg
	//Standard Arguments
	out = 0, amp = 0.5, pan = 0, att = 0.02, rel = 0.2, curve = -4,
	//Other Controls: mix is 0 - 1, fadeTime is a fraction of noise1's length.
	mix = 0.6, fadeFreq = 4000, fadeTime = 0.52;

    var env1, env2, snd, noise1, noise2;

    // noise 1 - 4 short repeats
    env1 = Env.new(
            [0, 1, 0, 0.9, 0, 0.7, 0, 0.5, 0],
            [att / 20, 0.009, 0, 0.008, 0, 0.01, 0, 0.03],
            [0, curve, 0, curve, 0, curve, 0, curve]
        ).kr;

    noise1 = WhiteNoise.ar(env1);
    noise1 = HPF.ar(noise1, 600);
    noise1 = LPF.ar(noise1, XLine.kr(7200, fadeFreq, fadeTime * 0.058));
    noise1 = BPF.ar(noise1, 1620, 3);

    // noise 2 - 1 longer single
	env2 = Env.perc(att, rel, 1, [0, curve]).kr;

    noise2 = WhiteNoise.ar(env2); //Try GrayNoise here - JM
    noise2 = HPF.ar(noise2, 1000);
    noise2 = LPF.ar(noise2, 7600);
    noise2 = BPF.ar(noise2, 1230, 0.7);

	snd = Mix.ar((mix * noise1) + ((1 - mix) * noise2));
    snd = snd * 2;
    snd = snd.softclip;

	DetectSilence.ar(snd, 0.0001, 0.2, doneAction: 2);

    Out.ar(out, Pan2.ar(snd,pan,amp));
},
metadata: (
	credit: "Nathan Ho aka Snappizz, http://sccode.org/1-523",
	category: \percussion,
	tags: [\unpitched, \clap, \electronic]
	)
).add;