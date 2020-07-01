// ksbass.scd
// the code below demonstrates the timbral effect of parameters impulseAtt, impulseSus, impulseDec, and impulseHold (which determine the exact shape of the impulse wave)

// create function to generate plots
(
f = { arg impulseAtt = 1, impulseSus = 1, impulseDec = 1, impulseHold = 1, freq = 1200;
	var impulse = Env.new(
		levels: [0, 1, 1, 0, 0],
		times: [impulseAtt, impulseSus, impulseDec, impulseHold]
	);
	["impulse original duration", impulse.duration].postln;
	["impulse scaled duration", impulse.duration / freq].postln;

	(impulse.duration = impulse.duration / freq).plot;
};
)



// 1. inspecting effect of impulseAtt on timbre
(
Window.closeAll;
Pbind(
	\instrument, "ksbass",
	\dur, 1/4,
	\rel, 0.7,
	\ctranspose, -18,
	\amp, 0.5,
	\degree, Pseq([-2, -2, \rest, -2, 0, 1, 0, 2, 4,
			       1, 1, \rest, -5, -4, -4, \rest, -3,
		           -2, -2, \rest, -2, 0, 1, 0, 2, 4,
			       1, 1, \rest, -5, -4, -4, -3, -3,
	               0], 2),
	\impulseAtt, Pseries(1, 1, inf).trace,
	\impulseSus, 1,
	\impulseDec, 1,
	\impulseHold, 1,
	\plot, Pfunc({ |ev|
		{
			f.value(
				ev[\impulseAtt],
				ev[\impulseSus],
				ev[\impulseDec],
				ev[\impulseHold]
			)
		}.defer;
	})
).play;
)



// 2. inspecting effect of impulseSus (EST) on timbre
(
Window.closeAll;
Pbind(
	\instrument, "ksbass",
	\dur, 1/4,
	\rel, 0.7,
	\ctranspose, -18,
	\amp, 0.5,
	\degree, Pseq([-2, -2, \rest, -2, 0, 1, 0, 2, 4,
			       1, 1, \rest, -5, -4, -4, \rest, -3,
		           -2, -2, \rest, -2, 0, 1, 0, 2, 4,
			       1, 1, \rest, -5, -4, -4, -3, -3,
	               0], 2),
	\impulseAtt, 1,
	\impulseSus, Pseries(0, 0.5, inf).trace,
	\impulseDec, 1,
	\impulseHold, 1,
	\plot, Pfunc({ |ev|
		{
			f.value(
				ev[\impulseAtt],
				ev[\impulseSus],
				ev[\impulseDec],
				ev[\impulseHold]
			)
		}.defer;
	})
).play;
)


// 3. inspecting effect of impulseDec on timbre
(
Window.closeAll;
Pbind(
	\instrument, "ksbass",
	\dur, 1/4,
	\rel, 0.7,
	\ctranspose, -18,
	\amp, 0.5,
	\degree, Pseq([-2, -2, \rest, -2, 0, 1, 0, 2, 4,
			       1, 1, \rest, -5, -4, -4, \rest, -3,
		           -2, -2, \rest, -2, 0, 1, 0, 2, 4,
			       1, 1, \rest, -5, -4, -4, -3, -3,
	               0], 2),
	\impulseAtt, 1,
	\impulseSus, 1,
	\impulseDec, Pgeom(1, 1.1, inf).trace,
	\impulseHold, 1,
	\plot, Pfunc({ |ev|
		{
			f.value(
				ev[\impulseAtt],
				ev[\impulseSus],
				ev[\impulseDec],
				ev[\impulseHold]
			)
		}.defer;
	})
).play;
)



// 4. inspecting effect of impulseHold on timbre
(
Window.closeAll;
Pbind(
	\instrument, "ksbass",
	\dur, 1/4,
	\rel, 0.7,
	\ctranspose, -18,
	\amp, 0.5,
	\degree, Pseq([-2, -2, \rest, -2, 0, 1, 0, 2, 4,
			       1, 1, \rest, -5, -4, -4, \rest, -3,
		           -2, -2, \rest, -2, 0, 1, 0, 2, 4,
			       1, 1, \rest, -5, -4, -4, -3, -3,
	               0], 2),
	\impulseAtt, 1,
	\impulseSus, 1,
	\impulseDec, 1,
	\impulseHold, Pgeom(1, 1.05, inf).trace,
	\plot, Pfunc({ |ev|
		{
			f.value(
				ev[\impulseAtt],
				ev[\impulseSus],
				ev[\impulseDec],
				ev[\impulseHold]
			)
		}.defer;
	})
).play;
)



