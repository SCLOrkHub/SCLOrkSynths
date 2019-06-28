/* Retrieved from
http://sccode.org/1-5aD
*/

SynthDef(\sampler_PlayBuf, {
//A really simple sampler	based on PlayBuf and midi ratios
	|out=0, pan=0, buf=0, midiratio=2, amp=1.0, pos=0.0, atk= 0.001, sus = 0.01 rel=1.0|
	var sig, rate, start, env;
	env = EnvGen.ar(Env.linen(atk, sus, rel), doneAction:2);
	rate = BufRateScale.ir(buf) * (midiratio.midiratio);
	start = BufFrames.kr(buf) * pos;
	sig = PlayBuf.ar(1, buf, rate, 1, start);
	Out.ar(out, Pan2.ar(sig, pan, amp) * env);
//By Zé Craum
}).add;
