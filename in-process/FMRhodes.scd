  /*
Retrieved from: http://sccode.org/1-522

FM Rhodes Synthesizer

Native SuperCollider port of STK's Rhodey. This should be preferred over the StkInst version because:

- It uses much less CPU.
- It is easier to modify.
- It doesn't require sc3-plugins or a correct setting of StkGlobals.
- It's beginner-friendly because it uses only basic UGens: SinOsc, EnvGen, Mix, Pan2, Out.

*/

(
SynthDef(\rhodey_sc, {
    |
    // standard meanings
    out = 0, freq = 440, gate = 1, pan = 0, amp = 0.1,
    // all of these range from 0 to 1
    vel = 0.8, modIndex = 0.2, mix = 0.2, lfoSpeed = 0.4, lfoDepth = 0.1
    |
    var env1, env2, env3, env4;
    var osc1, osc2, osc3, osc4, snd;

    lfoSpeed = lfoSpeed * 12;

    freq = freq * 2;

    env1 = EnvGen.ar(Env.adsr(0.001, 1.25, 0.0, 0.04, curve: \lin));
    env2 = EnvGen.ar(Env.adsr(0.001, 1.00, 0.0, 0.04, curve: \lin));
    env3 = EnvGen.ar(Env.adsr(0.001, 1.50, 0.0, 0.04, curve: \lin));
    env4 = EnvGen.ar(Env.adsr(0.001, 1.50, 0.0, 0.04, curve: \lin));

    osc4 = SinOsc.ar(freq * 0.5) * 2pi * 2 * 0.535887 * modIndex * env4 * vel;
    osc3 = SinOsc.ar(freq, osc4) * env3 * vel;
    osc2 = SinOsc.ar(freq * 15) * 2pi * 0.108819 * env2 * vel;
    osc1 = SinOsc.ar(freq, osc2) * env1 * vel;
    snd = Mix((osc3 * (1 - mix)) + (osc1 * mix));
    snd = snd * (SinOsc.ar(lfoSpeed) * lfoDepth + 1);

    // using the doneAction: 2 on the other envs can create clicks (bc of the linear curve maybe?)
    snd = snd * EnvGen.ar(Env.asr(0, 1, 0.1), gate, doneAction: 2);
    snd = Pan2.ar(snd, pan, amp);

    Out.ar(out, snd);
}).add;
)

(
Pbind(
    \instrument, \rhodey_sc,
    \scale, Scale.mixolydian,
    \octave, 4,
    \root, 2,
    \legato, Pseq([0.9, 0.5, 0.5, 0.9, 0.9, 0.9, 0.9, 0.5, 1, 0.5, 1, 0.6, 0.3], inf),
    \dur, Pseq([1 + (1/3), 1/3, 1/3, 1/7, 6/7, 5/6, 1/6, 1/2, 2/6, 1/6, 2 + 1/2, 1, 1/2], inf),
    \degree, Pseq([
        [0, 2, 4], 2, 4, 7, 8, 7, 0, [1, 3, 6], 5, [1, 3, 6], Rest(), [-1, 1, 3], [1, 3, 5],
        [0, 2, 4], 2, 4, 8, 9, 7, 0, [1, 3, 6], 5, [1, 3, 6], Rest(), [-1, 1, 3], [1, 3, 5],
    ], inf),
    \mix, 0.2,
    \modIndex, 0.2,
    \lfoSpeed, 0.5,
    \lfoDepth, 0.4,
    \vel, Pgauss(0.8, 0.1, inf),
    \amp, 0.3
).play(TempoClock(1.5));
)

