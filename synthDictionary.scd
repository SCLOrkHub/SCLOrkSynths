// synthDictionary.scd
//
// Creates a Dictionary holding relevant info about each synth:
// Dictionary[
//   (synthName1 ->
//      Dictionary[
//        (bank -> bank),
//        (synthPath -> path),
//        (patternPath -> path)
//       ],
//     ),
//  \synthName2,
//      [
//        \bank, <bank>,
//        \synthPath, <path>,
//        \patternPath, <path>
//       ]
// ... etc
//  ]
//
//
//


// this is the single big dictionary
~synthDictionary = Dictionary.new;


// ========================================
// An array with all bank names as Symbols
// ========================================

// should I try to simplify this step?
// i.e. either extract bank names directly from folder names;
// or from SynthDef metadata

(
~banks = [
	// All banks (subfolders of SynthDefs/ folder) area listed here.
	// When adding a new bank (subfolder), add entry manually here.
	\bass,
	\bells,
	\drums,
	\guitar,
	\keyboards,
	\misc,
	\organ,
	\pads,
	\strings,
	\winds
]
);


// ========================================
// POPULATE SYNTH DICTIONARY
// ========================================

(
~banks.do({ arg bank;

	// for every subfolder we get an array of paths to scd files:
	var synthPathsArray = (Document.current.dir ++ "/SynthDefs/" ++ bank.asString ++ "/*.scd").resolveRelative.pathMatch;

	// iterate over array to extract synthNames;
	// populate inner Dictionaries, one for each synth.

	synthPathsArray.do({ arg path;
		var synthName = PathName.new(path).fileNameWithoutExtension;
		~synthDictionary.add(synthName.asSymbol -> Dictionary.newFrom([\synthPath, path, \bank, bank]));
	});
});
);


(
// Now look into pbinds folder and add those paths to synthDictionary

(Document.current.dir ++ "/pbind-demos/*.scd").resolveRelative.pathMatch.do({ arg path;

	var synthName = PathName.new(path).fileNameWithoutExtension.drop(-5); // drop "-demo" from end of filename

	// Add paths to dictionary
	~synthDictionary[synthName.asSymbol].add(\patternPath -> path);

});
);

// Test it:
/*
~synthDictionary[\kalimba][\bank];
~synthDictionary[\kalimba][\patternPath];
~synthDictionary[\kalimba][\synthPath];

~synthDictionary[\cheapPiano1][\bank];
~synthDictionary[\cheapPiano1][\patternPath];
~synthDictionary[\cheapPiano1][\synthPath];
*/




// ========================================
// A Function that collects all paths
// inside a bank folder. Function takes bank
// name as argument. Bank name should match folder
// name. Banks are subfolders of SynthDefs folder.
// SynthDef files are saved inside each bank subfolder.
// Function returns an Array of paths.
// ========================================

~collectPaths = { arg bank; (Document.current.dir ++ "/SynthDefs/" ++ bank.asString ++ "/*.scd").resolveRelative.pathMatch };


// ========================================
// A Function that takes a full path and
// returns the filename without .scd extension
// ========================================

~getNameFromPath = { arg path; PathName.new(path).fileNameWithoutExtension };

// ========================================
// A Dictionary holding all SynthDef files
// (*.scd) paths organized by banks.
// Keys are bank names. Values are array of paths.
// ========================================

(
// Create empty Dictionary
~synthDictionary = Dictionary.new;

// Populate Dictionary
~banks.do({ arg bank; ~synthDictionary.put(bank, ~collectPaths.value(bank)) });

~currentSynth = nil; // to be set when user pushes a button to select a synth

// Print pretty in Post window
(
~banks.do({ arg bank;
	bank.asString.toUpper.postln;
	~synthDictionary[bank].do({ arg p;
		("  " ++ ~getNameFromPath.value(p)).postln;
	});
})
)
);

// ========================================
// Boot server and load all synths
// ========================================

s.waitForBoot({
	"Booting server and loading SynthDefs...".postln;
	~synthDictionary.do({arg entry; entry.do({ arg path; path.load; path.postln }) });
});




// ========================================
// pathDictionary
// keys are synthDef names
// values are a Dictionary holding two things: synthDef path and pattern path
// pattern paths will be added in the patternDictionary.scd file
// ========================================
(
~pathDictionary = Dictionary.new;

~synthDictionary.do({ arg array;
	array.do({ arg path;
		var synthName = ~getNameFromPath.value(path);
		~pathDictionary.put(synthName.asSymbol, Dictionary.newFrom([\synthPath, path]))
		// path.postln

	})
})
);