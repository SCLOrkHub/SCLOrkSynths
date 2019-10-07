/* Received from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/snare_stein.scd
*/

SynthDef(\snare_stein, { |out=0, amp=0.1, pan=0|
var snare, filtWhite;

filtWhite = LPF.ar(WhiteNoise.ar(1), 7040, 1);

snare = ((SinOsc.ar(330,0,0.25) * EnvGen.ar(Env.perc(0.0005,0.055)))+(SinOsc.ar(185,0,0.25) * EnvGen.ar(Env.perc(0.0005,0.075)))+(filtWhite * EnvGen.ar(Env.perc(0.0005,0.2), doneAction: 2) * 0.2)+(HPF.ar(filtWhite, 523, 1) * EnvGen.ar(Env.perc(0.0005,0.183)) * 0.2));

Out.ar(out, Pan2.ar(snare * amp * 10, pan));

},
metadata: (
	credit: "Snare written by Esben Stein, I believe",
	tags: [\percussion, \drum, \snare]
	)
)
