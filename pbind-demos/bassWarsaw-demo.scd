var durs = Pseq([
	1/4, Rest(1/8), 1/8, Rest(1/8), 1/8, Rest(1/8), 1/8, 1/2, Pn(1/8, 4),
	1/4, Rest(1/8), 1/8, Rest(1/8), 1/8, Rest(1/8), 1/8, 1/2, Pn(1/8, 3), Rest(1/8), 1/2
]);
var degrees = Pseq([
	3, \rest, 10, \rest, 7, \rest, 8, 4, 8, 11, 8, 4,
	3, \rest, 0, \rest, 1, \rest, 3, 4, 8, 7, 5, \rest, 0
]);

Pdef(\bassWarsaw,
	Pseq(
		[
			Pbind(
				\instrument, "bassWarsaw",
				\dur, durs,
				\legato, Pseq([1, Pn(0.1, 6), 1, Pn(0.1, 4)], inf),
				\ctranspose, -24,
				\degree, degrees,
				\amp, 0.7,
			),
			Pmono(
				"bassWarsaw",
				\dur, durs,
				\ctranspose, -24,
				\degree, degrees,
				\amp, 0.7,
				\slideTime, Pwhite(0.04, 0.2)
			)
		]
	)
);