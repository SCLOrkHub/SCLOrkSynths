// Piano synth based on Mda Plugin
 
SynthDef(\piano_MDA, {
   |out = 0, freq= 440, gate= 1, vel= 80, decay= 0.8, release= 0.8, hard= 0.4, velhard= 0.8, muffle= 0.8, velmuff= 0.8, velcurve= 0.8, stereo= 0.2, tune= 0.5, random= 0.1, stretch= 0.1, sustain= 0, mul= 1, add= 0, amp = 0.5|
    var snd;
    snd = MdaPiano.ar(freq, gate, vel, decay, release, hard, velhard, muffle, velmuff, velcurve, stereo, tune, random, stretch, sustain, mul, add);
    snd = snd * EnvGen.kr(Env.asr(0, 1, 0.1), gate, doneAction: 2);
    Out.ar(out, snd * amp);
//by ????

}).add;
