/*Recieved from 
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/cymbal808_ryan.scd
*/

SynthDef(\cymbal808_ryan, {
	arg out=0, baseFreq = 300, time = 250, amp=0.1;
	//var freqs = [baseFreq, baseFreq*1.3420, baseFreq*1.2312, baseFreq*1.6532, baseFreq*1.9523, baseFreq*2.1523];
	//var freqs = [78.6, 140.44, 123.87, 219.4, 787.5, 531.3];
	//var freqs = [205.35, 254.29, 294.03, 304.41, 369.64, 522.71];
	var freqs = [205.35, 304.41, 369.64, 522.71, 540.54, 812.21];
	var signal, pulseEnv;
	
	pulseEnv = EnvGen.ar(Env.new([1.0, 0.6], [time], [-0.5]), timeScale:(1/1000));
	signal = Mix.new(LFPulse.ar(freqs * 4.09));
	signal = (BinaryOpUGen('==', signal, 6.0) * 0.6) + (BinaryOpUGen('==', signal, 2.0) * 0.2) + (BinaryOpUGen('==', signal, 1.0) * 0.9); // XOR
ÊÊ 	signal = (signal * pulseEnv) + (Mix.new(LFPulse.ar(freqs, width:0.55)) * 0.9);
Ê	signal = RLPF.ar(signal, 7000, 0.6);
Ê 	signal = RHPF.ar(signal, 6800, 1.5);
Ê	signal = RHPF.ar(signal, 6800, 1.5);
Ê	signal = RHPF.ar(signal, 1200, 1.5);
	signal = signal + FreeVerb.ar(signal);
	signal = signal * EnvGen.ar(Env.new([0, 1, 0.4, 0, 0], [2, time, 50, 500], [0, -0.5, 0, -50]), timeScale:(1/1000), doneAction:2);
	signal = [signal, DelayN.ar(signal, 0.005, 0.005)];
	OffsetOut.ar(out, signal*4*amp);
},
metadata: (
	credit: "Published on sc-users 2007-08-25 by Ryan Brown",
	tags: ['808', \hihat, \percussion, \cymbal]
	)
)
