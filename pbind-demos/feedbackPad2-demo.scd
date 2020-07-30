Pbindef( \feedbackPad2,
	\instrument, "feedbackPad2",
	\dur, 3,
	\ctranspose, 12,
	\legato, 0.55,
	\del, Pwhite(0.05, 0.1),
	\rel, Pseq([Pn(1.75, 7), 3]),
	\polFlip, Prand([0, 1], inf),
	\thresh, Pwhite(0.01, 0.67),
	\degree, Pseq([[-7, 0, 2, 4], [-5, -1, 2, 4], [-6, -2, 1, 4], [-7, -3, 0, 4]], 2)
);