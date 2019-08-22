/* Recieved from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/kick_chrp.scd
*/

// a kick made using what radio folks would call a "chirp"
SynthDef(\kick_chrp, { |out=0, amp=0.1, pan=0|

var ampenv, pitchenv;

ampenv   = EnvGen.ar(Env.perc(0, 0.2, curve: 0), doneAction: 2);
pitchenv = EnvGen.ar(Env.perc(0, 0.1, curve: -20).exprange(0, 1000), doneAction: 0);

Out.ar(out, Pan2.ar(SinOsc.ar(pitchenv) * amp, pan))


},
metadata: (
	credit: "by dan stowell. public domain",
	tags: [\kick, \drum, \percussion, \chirp]
	)
)
