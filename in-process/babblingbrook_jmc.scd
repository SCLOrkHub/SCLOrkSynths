/* Recieved from 
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/babblingbrook_jmc.scd
*/

SynthDef(\babblingbrook_jmc, { |out=0, amp=0.1|
	var son;

	son = ({RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, 14)
		* 400 + 500, 0.03, 0.003)}!2)
		+ ({RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, 20)
		* 800 + 1000, 0.03, 0.005)}!2)  * 4;
	Out.ar(out, son * (amp * 20))
},
metadata: (
	credit: "based on code posted to sc-users 2007-04-07 by james mccartney",
	tags: [\babbling, \brook]
	)
)
