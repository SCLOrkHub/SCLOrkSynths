Pbindef( \organReed,
	\instrument, "organReed",
	\ctranspose, -12,
	\degree, Pseq([
		        [0, 7, 9, 11], Pn([7, 9, 11, 14], 3),
		        [7, 9, 11], [4, 10, 11, 15], [4, 10, 11, 13], [7, 9, 11, 14]
	    ]),
	\dur, Pseq([1, 3/4, 1/4, 2], 2),
	\legato, Pseq([1, 2/3, 1, 7/8], 2)
).play;