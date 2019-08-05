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

(
// Load all files, add paths to pathDictionary
(Document.current.dir ++ "/pbind-demos/*.scd").resolveRelative.pathMatch.do({ arg path;

	var fileName = ~getNameFromPath.value(path).drop(-5); // drop "-demo" from end

	// Add paths to dictionary
	~pathDictionary[fileName.asSymbol].add(\patternPath -> path);

	// Load files
	path.load;




});
);

Pdef.all.do({arg item; item.quant = 0.0; item.key.postln });

"Patterns loaded";
