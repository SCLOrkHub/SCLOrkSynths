/* The default Supercollider synth, with some minor improvements for increased control and understandability.

Modified by Josh Mithell and Bruno Ruviaro July 2019.
*/

SynthDef("defaultB", {
	arg
	//Standard values
	out=0, freq=440, amp=0.1, att = 0.01, rel = 0.3, pan=0, gate=1,
	// Extra controls
	beatingsRatio = 1.0009, sawWidth = 0.3, filterMax = 5000, filterMin = 4000, filterRatio = 0.63;

    var snd, freqarray, filterfreq;

	freqarray = [1, Rand(abs(2 - beatingsRatio), 1.0), Rand(beatingsRatio, 1.0)];
	filterfreq = XLine.kr(
			        start: Rand(filterMin, filterMax),
		            //With default values, end is within +/- 50hz of the original.
			        end: Rand(filterMin * filterRatio, filterMax * filterRatio),
			        dur: 3 * rel
		    );

	// The original adds the array [0, Rand(-0.4, 0.0), Rand(0.0, 0.4)] to freq instead.
    snd = VarSaw.ar(freq: freq * freqarray, width: sawWidth);
	snd = LPF.ar(
		            in: snd,
		            freq: filterfreq
	        );
	snd = snd * Env.asr(
		            attackTime: att,
		            //Use amp/5 to roughly match the amp of the original.
		            sustainLevel: amp/5,
		            releaseTime: rel,
		            curve: \lin
	        ).kr(gate: gate, doneAction: 2);
	snd = Mix.ar(snd);

	//The original uses OffsetOut instead.
    Out.ar(out, Pan2.ar(snd, pan))
},
metadata: (
	credit: "default SuperCollider synth, modified",
	category: \keyboards,
	tags: [\piano, \pitched]
)
).add;