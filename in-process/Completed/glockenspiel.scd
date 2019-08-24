/* Retrieved from
http://sccode.org/1-5aD
*/

SynthDef(\glockenspiel, {
	|freq = 440, t60=6, pitchy=1, amp=0.25, gate=1, pan = 0|
	var sig, exciter;
	exciter = WhiteNoise.ar() * EnvGen.ar(Env.perc(0.001, 0.05), gate) * 0.25;
	sig = DynKlank.ar(
		`[
			[1, 2, 2.803, 3.871, 5.074, 7.81, 10.948, 14.421],   // freqs
			[1, 0.044, 0.891, 0.0891, 0.794, 0.1, 0.281, 0.079], // amplitudes
			[1, 0.205, 1, 0.196, 0.339, 0.047, 0.058, 0.047]*t60     // ring times
		],
		exciter,
		freqscale: freq);
	DetectSilence.ar(sig, 0.001, 0.5, doneAction:2);
	Out.ar(0, Pan2.ar(sig, pan, amp));
//This is the same used for glockenspiel, xylophone, marimba and regular bell, what changes is only the ring time t60
//By nicolaariutti and edited by Zé Craum
//	http://sccode.org/1-5ay#c835
}).add;
