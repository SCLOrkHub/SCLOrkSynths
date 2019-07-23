/*
functionality

// button: "play demo"
// button: "play scale"
// button: "see code" (opens SynthDef and Pbind in new file)
--> how to fetch (copy) entire string from an unopened document, and open a new file with it?

-


*/

// ~banks.size

var window;
var header;
var gap = 5;
var margin = 10;
var banksMenu;
var currentBank = \drums;
var numberOfColumns = 5;
var numberOfRows = 10;
var windowWidth = Window.screenBounds.width / 2;
var windowHeight = windowWidth * 0.5;
var buttonWidth = windowWidth - (margin * 2) - (numberOfColumns * (gap - 1)) / numberOfColumns;
var buttonHeight = 25; //(windowHeight * 0.75) / numberOfRows;
var buttonArray;
// var bankNameArray = (Document.current.dir ++ "/*.scd").resolveRelative.pathMatch.collect({ arg path; path.basename.drop(-4).asSymbol });
var activeButton;
var footer;
var currentSynthText;

Window.closeAll;

window = Window.new(
	name: "SCLOrkSynths",
	bounds: Rect.new(
		left: 100,
		top: 100,
		width: windowWidth,
		height: windowHeight
	),
	resizable: false
);

window.front;

window.view.decorator = FlowLayout.new(
	bounds: window.view.bounds,
	margin: Point.new(margin, margin),
	gap: Point.new(gap, gap)
);

// header is just the area where drop down menu sits
header = CompositeView.new(window, Rect.new(0, 0, windowWidth - (margin * 2), 50));

// StaticText goes first so EZPopUpMenu stays on top
StaticText.new(
	parent: header,
	bounds: Rect(0, 0, header.bounds.width, header.bounds.height))
.string_("SCLOrkSynths")
// .background_(Color.green(0.5, 0.2))
.align_(\topRight)
.font_(Font(Font.default, size: 24, bold: true));

banksMenu = EZPopUpMenu.new(
	parentView: header,
	bounds: Rect.new(0, 10, 185, 30),
	label: "bank: ",
	items: ~banks.collect{ |i| i.asSymbol},
	globalAction: { arg menu;
		["bank menu action", menu.value, menu.item].postln;
		currentBank = menu.item; // currentBank holds a symbol, not a number
		// clean up buttons
		buttonArray.do({arg button;
			button.string = " ";
		});
		currentBank.postln;
		~synthDictionary.at(currentBank.asSymbol).do({arg path, count;
			var indexDownByColumn = count % numberOfRows * numberOfColumns + count.div(numberOfRows);
			// [path.asString.basename, count].postln;
			buttonArray[indexDownByColumn].string = path.asString.basename.drop(-4)
	});

},
	initVal: ~banks.indexOf(currentBank.asSymbol),
	initAction: false, // because buttonArray does not exist yet
	labelWidth: 50
);


// header.background = Color.rand;

buttonArray = 50.collect({ arg count;
	Button.new(
		parent: window.view,
		bounds: Point.new(buttonWidth, buttonHeight),
	)
	.action_({ arg button;
		currentSynthText.string = button.string;
		~currentSynth = button.string;
	});
});

// now that buttonArray exists, we can run EZPopUpMenu action to initialize button labels:
banksMenu.valueAction = currentBank;

footer = CompositeView.new(window, Rect.new(0, 300, windowWidth - (margin * 2), 50));
// footer.background = Color.green(0.5, 0.2);

footer.bounds.height.postln;

currentSynthText = StaticText.new(
	parent: footer,
	bounds: Rect(0, 0, footer.bounds.width, footer.bounds.height))
.string_("click on a button to choose a SynthDef")
.background_(Color.gray(0.5, 0.2))
.align_(\center)
.font_(Font(Font.default, size: 24, bold: true))
.front;

Button.new(
	parent: window,
	bounds: Rect.new(0, 300, windowWidth - (margin * 2), 50)
)
.string_("play demo")
.font_(Font(Font.default.name, 18))
.action_({ "playing...".postln; Pdef(~currentSynth.asSymbol).play });

