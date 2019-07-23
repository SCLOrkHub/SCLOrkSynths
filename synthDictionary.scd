// synthDictionary.scd
//
// Defines a Dictionary to hold all paths to *.scd SynthDef files
// Files are organized by bank names (corresponding to subfolders)


// ========================================
// An array with all bank names as Symbols
// ========================================
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

~getNameFromPath = { arg path; path.asPathName.fileNameWithoutExtension };

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