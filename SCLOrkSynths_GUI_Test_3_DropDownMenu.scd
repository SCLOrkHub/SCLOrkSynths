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

header = CompositeView.new(window, Rect.new(0, 0, windowWidth - (margin * 2), 50));

banksMenu = PopUpMenu.new(header, Rect.new(0, 0, 100, 25));

banksMenu.items = ~banks.collect{ |i| i.asString};
// header.background = Color.rand;

banksMenu.value = ~banks.indexOf(currentBank);

buttonArray = ~synthDictionary.at(currentBank).collect({ arg item, count;
	Button.new(
		parent: window.view,
		bounds: Point.new(buttonWidth, buttonHeight),
)
	// .font_(Font.new(Font.defaultSansFace, 10))
	.states_([
		[item.asString.basename.drop(-4), Color.black, Color.defaultArgs],
		[item.asString.basename.drop(-4), Color.black, Color.green]
	])
	.action_({ arg button;
		if(activeButton!=nil, {buttonArray[activeButton].value = 0});
		activeButton = ~synthDictionary.indexOf(button.string.asSymbol);
		["currently active", activeButton].postln;

	})
});
