/* Recieved from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/kick_chrp.scd

A kick made using what radio folks would call a "chirp"

Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef(\kick_chirp, {

	arg out = 0, amp = 0.1, pan = 0, curve = -20, att = 0.001, rel = 0.5, maxFreq = 500;

    var env, snd;

	env = Env.perc(attackTime: att, releaseTime: rel, curve: curve).exprange(0, maxFreq).kr(doneAction: 2);

    snd = SinOsc.ar(freq: env, mul: amp);
    snd = LeakDC.ar(snd);

Out.ar(out, Pan2.ar(snd, pan))
},
metadata: (
	credit: "Original by dan stowell. public domain",
	category: \drums,
	tags: [\kick, \drum, \percussion, \chirp]
	)
).add;