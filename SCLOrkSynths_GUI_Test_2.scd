
// sketches

// /*
//
// Document.current.dir.postln;
// l = (Document.current.dir ++ "/SynthDefs/*").resolveRelative.pathMatch;
// l.collect{|p| p.dirname.postln};
//
//
// ~collectNames.value("drums");
//
// */

~collectNames = { arg bank; (Document.current.dir ++ "/SynthDefs/" ++ bank.asString ++ "/*.scd").resolveRelative.pathMatch.collect({ arg path; path.asPathName.fileNameWithoutExtension }) };

~banks = Dictionary.new;

(
[
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
].do({ arg bank; ~banks.put(bank, ~collectNames.value(bank)) });
)

~banks.at(\drums);
~banks.at(\winds);


//
// l.do{|p| p.basename.drop(-4).postln};


// ADD
// button: "play demo"
// button: "play scale"
// button: "see code" (opens SynthDef and Pbind in new file)

var window;
var gap = 5;
var margin = 10;
var numberOfColumns = 5;
var numberOfRows = 10;
var windowWidth = Window.screenBounds.width / 2;
var windowHeight = windowWidth * 0.75;
var buttonWidth = windowWidth - (margin * 2) - (numberOfColumns * (gap - 1)) / numberOfColumns;
var buttonHeight = 25;
var buttonArray;
var synthNameArray = (Document.current.dir ++ "/*.scd").resolveRelative.pathMatch.collect({ arg path; path.basename.drop(-4).asSymbol });
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

buttonArray = synthNameArray.collect({ arg item, count;
	Button.new(
		parent: window.view,
		bounds: Point.new(buttonWidth, buttonHeight),
)
	.states_([
		[item.asString, Color.black, Color.defaultArgs],
		[item.asString, Color.black, Color.green]
	])
	.action_({ arg button;
		if(activeButton!=nil, {buttonArray[activeButton].value = 0});
		activeButton = synthNameArray.indexOf(button.string.asSymbol);
		["currently active", activeButton].postln;

	})
});
