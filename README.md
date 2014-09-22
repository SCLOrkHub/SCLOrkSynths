SynthDefs-for-Patterns
======================

Collection of SuperCollider SynthDefs (synth definitions) for use with Patterns

WARNING: very much a work in progress (barely started).

I don't remember where I got some SynthDefs from. I will do my best to add credits and/or links to original synthdefs if I can.

Feel free to add new SynthDefs to the collection, or suggest new ones.

##Some conventions

SynthDefs should have the following arguments (default values encouraged but flexible):

out = 0, to be used in Out.ar(out, ...)
pan = 0, to be used in Out.ar(out, Pan2.ar(snd, pan))
freq = 440, always the main freq for pitched synths
amp = 0.2, always the main amplitude of the final sound
att = 0.01, attack time of the main amplitude envelope
rel = 1, release time of amplitude envelope
sus = 1, sustain amount (as in a typical ADSR)
dec = 0.1, decay time (as in typical ADSR)
gate = 1, if using envelopes like ADSR (not needed if using self terminating envs such as Env.perc)

* use variables snd for main sound (whatever that is) and env for amplitude env. Variations as needed.

* use doneAction: 2 to make synth free itself after note is done.

* avoid specifying durations directly inside SynthDef (other than att and rel) -- Pbind will do that.

BTR
