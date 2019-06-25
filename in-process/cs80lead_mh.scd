/* Recieved from 
https://github.com/supercollider-quarks/SynthDefPool/blob/master/pool/cs80lead_mh.scd
*/

SynthDef("cs80lead_mh", {
	arg freq=880, amp=0.5, att=0.75, decay=0.5, sus=0.8, rel=1.0, fatt=0.75, fdecay=0.5, fsus=0.8, frel=1.0,
		cutoff=200, pan=0, dtune=0.002, vibrate=4, vibdepth=0.015, gate=1.0, ratio=1,out=0,cbus=1;
	var env,fenv,vib,ffreq,sig;
	cutoff=In.kr(cbus);
	env=EnvGen.kr(Env.adsr(att,decay,sus,rel),gate,levelScale:1,doneAction:2);
	fenv=EnvGen.kr(Env.adsr(fatt,fdecay,fsus,frel,curve:2),gate,levelScale:1,doneAction:2);
	vib=SinOsc.kr(vibrate).range(-1*vibdepth,vibdepth)+1;
	freq=Line.kr(freq,freq*ratio,5);
	freq=freq*vib;
	sig=Mix.ar(Saw.ar([freq,freq*(1+dtune)],mul:env*amp));
	// keep this below nyquist!!
	ffreq=max(fenv*freq*12,cutoff)+100;
	sig=LPF.ar(sig,ffreq);
	Out.ar(out, Pan2.ar(sig,pan) );  
},
metadata: (
	credit: "Vangelis/Blade Runner lead sound, based on tutorial by meastempo @ http://www.youtube.com/watch?v=Fne0oIEv-WI",
	tags: [\lead, \modulation, \analog, \cs80, \vangelis, \bladerunner]
	)
)
