// ========================================
// patternDictionary.scd
//
// Loads all pattern demos (one per *.scd SynthDef file)
// ========================================

// ========================================
// All patterns are Pbindefs or Pdefs
// all in separate files
// ========================================

// Clear it up
Pdef.removeAll;

// Load all files
(Document.current.dir ++ "/pbind-demos/" ++ "/*.scd").resolveRelative.pathMatch.do({ arg path; path.load });

"Patterns loading...".postln;
Pdef.all.do({arg item; item.quant = 0.0; item.key.postln });