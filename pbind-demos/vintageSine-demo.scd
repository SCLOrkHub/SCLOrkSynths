Pdef(\vintageSine,
	Pmono(
	"vintageSine",
	\ctranspose, Pseq([Prand([-6, -6, 6], 20), -6], 1),
    \legato, 1,
	\dur, 1/5,
	\degree, Pseq([Pseq([Prand([0, 2, 5], 1), Prand([1, 4, 7], 1)], 10), 0], 1),
	\amp, Pseq([Pwhite(0.75, 1, 4), 0], inf)
)
);