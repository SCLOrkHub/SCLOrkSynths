/* Received from
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/forest_bird_pj.scd
*/

SynthDef(\forest_bird_pj, { |out=0, amp=0.1, pan=0|
	Out.ar(out, Pan2.ar(
		BPF.ar(BrownNoise.ar,SinOsc.kr(LFNoise2.kr(50,50,50),0,100,2000),0.001,10)
		* amp, pan))},
metadata: (
	credit: "by Paul Jones, posted to sc-users mailing list 2007-04-07",
	tags: [\forest, \bird]
	)
)
