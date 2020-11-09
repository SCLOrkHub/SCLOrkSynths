SCLOrkSynths
======================
 
Collection of SuperCollider SynthDefs (synth definitions) with accompanying Pattern demos.

Anyone is welcome to suggest new SynthDefs for the collection.

## Installation

You can install SCLOrkSynths just like any other SuperCollider [Quark](https://doc.sccode.org/Guides/UsingQuarks.html):

```
Quarks.fetchDirectory;
Quarks.install("SCLOrkSynths");
```
You may also use the Quarks gui (run `Quarks.gui;`) instead of running the lines above.
If you run into any trouble, you can try [these steps](https://github.com/SCLOrkHub/SCLOrkSynths/issues/95#issuecomment-724156637) to start fresh.

## Sources

Enormous thanks to all the authors who have shared SynthDef code online over the years. This repository would not be possible without them. Also thanks to an [early suggestion](https://github.com/SCLOrkHub/SCLOrkSynths/issues/2) by @meznon who inspired me to pursue this further over the years. Aside from the original SynthDefs created for this project, some of the main sources we borrowed code from were:

### SynthDefPool
Link: https://github.com/supercollider-quarks/SynthDefPool

This is a quark by @crucialfelix from where we borrowed SynthDefs. We have also reused the metadata model as seen there.

### sccode
Link: http://sccode.org/ 

Lots of great stuff on here, many SynthDefs by various authors were originallhy posted here. At the top comment in many our SynthDef files you will find the URL pointing to the sccode where we found the original SynthDef.

### synthDEFaults
Link: http://sccode.org/1-5aD 

A collection of SynthDefs organized by Zé Craum and released under GNU GPL 3. A lot of of SynthDefs included in our collection were adapted from this source. The original authors' names has been preserved when known.

## Contributors

*Bruno Ruviaro* @brunoruviaro - project lead; responsible for final review of all code, GUI creation, Quark maintenance, creation of some original SynthDefs

*Josh Mitchell* @joshmit - research assistant; responsible for standardizing coding conventions, rewriting SynthDefs to clarify or improve them, adding new amazing original SynthDefs

*Meha Gupta* @mehagupta - volunteer; initial gathering and upload of SynthDefs from mailing lists and public forums; contribution of additional demos

*Diya Menon* - volunteer; contribution of additional pattern demos

Most SynthDefs have their original author credited in the corresponding scd file. However, we could not identify the author for a few SynthDefs. Please let us know if you know the source of a SynthDef that has no author name, we'll be happy to add it.

## Some conventions

SynthDefs should have the following arguments (default values encouraged but flexible):

* out = 0, to be used in Out.ar(out, ...)
* pan = 0, to be used in Out.ar(out, Pan2.ar(snd, pan))
* freq = 440, for pitched synths
* amp = 0.2, for global amp of synth
* att = 0.01, attack time of the main amplitude envelope
* rel = 1, release time of amplitude envelope
* sus = 1, sustain level (as in a typical ADSR)
* dec = 0.1, decay time (as in typical ADSR)
* gate = 1, if using envelopes like ADSR (not needed if using self terminating envs such as Env.perc)

Miscellaneous:

* Use variables snd for main sound (whatever that is) and env for amplitude env. Variations as needed.
* Use doneAction: 2 to make synth free itself after note is done.
* Avoid specifying durations directly inside SynthDef (other than att and rel) -- patterns will take care of durations.
* Keep any relevant comments about the SynthDef as the header of the file (use block comment)
* Use metadata: inside the SynthDef in the following format, where "category" corresponds to the name of the SCLOrkSynths subfolder where the SynthDef is saved:

```
},
metadata: (
	credit: "name of author(s) of SynthDef",
	category: \drums,
	tags: [\percussion, \kick]
)
).add;
```


