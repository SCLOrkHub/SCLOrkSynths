
// subBass step by step


// Here's the input wave:
{ LFPar.ar(100 * 2, iphase: 2) }.plot;


// Step 1: take input, constrain between 0-1, create a mirror image of it (invert phase)
(
{
	var freq = 100, in, ina, inb;

	//Input wave - To use SinOsc.ar, replace "iphase: 2" with "phase: 3pi/2"
	in = LFPar.ar(freq: freq * 2, iphase: 2);

	//Mirroring the wave around the x-axis
	ina = in.range(0, 1);
	inb = ina * -1;

	[ina, inb];
}.plot(0.1);
)



// Step 2: create two square waves (opposite phases) to use as "gates"
(
{
	var freq = 100, in, ina, inb, synca, syncb;

	//Input wave - To use SinOsc.ar, replace "iphase: 2" with "phase: 3pi/2"
	in = LFPar.ar(freq: freq * 2, iphase: 2);

	//Mirroring the wave around the x-axis
	ina = in.range(0, 1);
	inb = ina * -1;

	[ina, inb];

	synca = LFPulse.ar(freq: freq, iphase: 0);
	syncb = LFPulse.ar(freq: freq, iphase: 0.5);

	[ina, inb, synca, syncb]
}.plot(0.1);
)

// Step 3: multiply input waves by square wave gates; mix results together.
// Result is composite wave that is part ina, part inb
(
{
	var freq = 100, in, ina, inb, synca, syncb, octa, octb, octave;

	//Input wave - To use SinOsc.ar, replace "iphase: 2" with "phase: 3pi/2"
	in = LFPar.ar(freq: freq * 2, iphase: 2);

	//Mirroring the wave around the x-axis
	ina = in.range(0, 1);
	inb = ina * -1;

	[ina, inb];

	synca = LFPulse.ar(freq: freq, iphase: 0);
	syncb = LFPulse.ar(freq: freq, iphase: 0.5);



	octa = ina * synca;
	octb = inb * syncb;

	octave = Mix.ar([octa, octb]);

	[ina, inb, synca, syncb, octa, octb, octave]

}.plot(0.1);
)



