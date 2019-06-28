
// sketches

var window;
var gap = 5;
var margin = 10;
var numberOfColumns = 5;
var numberOfRows = 10;
var windowWidth = 1000;
var windowHeight = 750;
var buttonWidth = windowWidth - (margin * 2) - (numberOfColumns * (gap - 1)) / numberOfColumns;
var buttonArray;


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

buttonArray = 75.do({
	Button.new(
		parent: window.view,
		bounds: Point.new(buttonWidth, 30),
)
	.string_(["violin", "piano", "guitar"].choose ++ rrand(1, 10).asString)
	.action_{ arg button; button.string.postln }
});
