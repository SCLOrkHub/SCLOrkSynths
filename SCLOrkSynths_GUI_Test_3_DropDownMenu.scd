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
var windowHeight = windowWidth * 0.75;
var buttonWidth = windowWidth - (margin * 2) - (numberOfColumns * (gap - 1)) / numberOfColumns;
var buttonHeight = 25; //(windowHeight * 0.75) / numberOfRows;
var buttonArray;
// var bankNameArray = (Document.current.dir ++ "/*.scd").resolveRelative.pathMatch.collect({ arg path; path.basename.drop(-4).asSymbol });
var activeButton;
var footer;
var currentSynthText;


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

banksMenu = PopUpMenu.new(header, Rect.new(0, 0, 100, 25));

banksMenu.items = ~banks.collect{ |i| i.asString};
// header.background = Color.rand;

banksMenu.value = ~banks.indexOf(currentBank);

buttonArray = 50.collect({ arg count;
	Button.new(
		parent: window.view,
		bounds: Point.new(buttonWidth, buttonHeight),
	)
	.action_({ arg button; currentSynthText.string = button.string });
});


banksMenu.action = { arg menu;
	["bank menu action", menu.value, menu.item].postln;
	currentBank = menu.item; // currentBank holds a symbol, not a number
	// clean up buttons
	buttonArray.do({arg button;
		button.string = " ";
	});
	currentBank.postln;
	~synthDictionary.at(currentBank.asSymbol).do({arg item, count;
		buttonArray[count].string = item.asString.basename.drop(-4)
	});

};

banksMenu.valueAction = currentBank;


footer = CompositeView.new(window, Rect.new(0, 300, windowWidth - (margin * 2), 50));
// footer.background = Color.green(0.5, 0.2);

footer.bounds.height.postln;

currentSynthText = StaticText.new(footer, Rect(0, 0, footer.bounds.width, footer.bounds.height)).string_("click on a button to choose a SynthDef").background_(Color.green(0.5, 0.2)).align_(\center).font_(Font(Font.default, size: 24, bold: true)).front;