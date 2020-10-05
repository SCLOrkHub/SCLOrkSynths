Pbindef( \apadMH,
	\instrument, "apadMH",
	\dur, 4,
	\tremoloRate, Pwhite(4.0, 6.0, inf),
	\ctranspose, -5,
	\strum, Pseq([0.05, -0.05, 0.05, 0.05, -0.05]),
	\note, Pseq([
	        	    [3, 5, 10, 12, 17, 19], [2, 6, 9, 13, 16, 20],
	        	    [4, 11, 18], [2, 6, 9, 13, 16, 20],
	        	    [0, 7, 14, 21]
	            ]),
	\amp, 0.1
);