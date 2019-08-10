// synthDictionary.scd
//
// Creates a Dictionary of Dictionaries holding relevant info about each synth:
// Dictionary[
//   (synthName1 ->
//      Dictionary[
//        (bank -> bank),
//        (synthPath -> path),
//        (patternPath -> path)
//       ],
//     ),
// (synthName2 ->
//      Dictionary[
//        (bank -> bank),
//        (synthPath -> path),
//        (patternPath -> path)
//       ],
//     ),
// ... etc
//  ]
//
//
//

// list of bank PathNames -- one for each bank folder
var bankPathsArray = PathName.new(Document.current.dir +/+ "SynthDefs").folders;

// list of pattern PathNames -- one for each pbind file
var patternPathsArray = PathName.new(Document.current.dir +/+ "pbind-demos").files;

// this is the single big dictionary
~synthDictionary = Dictionary.new;

// iterate through list of bank PathNames
bankPathsArray.do({ arg bankPath;
	var bankName = bankPath.folderName;

	// iterate over array of file Paths in bankPath to
	// populate inner Dictionaries, one for each synth.

	bankPath.files.do({ arg synthPath;
		var synthName = synthPath.fileNameWithoutExtension.asSymbol;
		var patternPath;

		// find path for the corresponding pattern
		patternPathsArray.do({ arg p;
			var pName = p.fileNameWithoutExtension.drop(-5).asSymbol;
			if(pName === synthName, { patternPath = p.fullPath });
		});

		// add everything in:
		~synthDictionary.add(
			synthName -> Dictionary.newFrom(
				[
					\synthPath, synthPath.fullPath,
					\bank, bankPath.folderName,
					\patternPath, patternPath
				]
			)
		)
	});
});


// LOAD all SynthDefs and Pbindefs:

s.waitForBoot({
	~synthDictionary.keysValuesDo({ arg synthName, synthDic;
		synthDic[\patternPath].postln;
		synthDic[\patternPath].asString.load;
		synthDic[\synthPath].postln;
		synthDic[\synthPath].asString.load;
	});


	"synthDictionary was created.".postln;
	"all SynthDefs and Pbindefs were loaded".postln;
	" "
});





// Test it:
/*
~synthDictionary[\kalimba][\bank];
~synthDictionary[\kalimba][\patternPath];
~synthDictionary[\kalimba][\synthPath];

~synthDictionary[\cheapPiano1][\bank];
~synthDictionary[\cheapPiano1][\patternPath];
~synthDictionary[\cheapPiano1][\synthPath];


~synthDictionary.keysValuesDo({ arg key, value; key.postln; value.keys.postln });
*/
