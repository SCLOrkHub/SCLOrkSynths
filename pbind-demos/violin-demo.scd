// Bach Chaconne
Pbindef(\violin,
	\instrument, "violin",
	\dur, Pseq([
		3/8, 1/8, // m. 1
		1/4 + 0.1, 3/8 + 0.1, 1/8, // m. 2
		1/4, 3/8 // m. 3
	]) * 4,
	\strum, 0.05,
    \midinote, Pseq([
		[62, 65, 69], 69,
		[62, 67, 70, 76],
		[61, 67, 69, 76], 76,
		[62, 69, 74, 77],
		[58, 65, 70, 74]
	]),
);