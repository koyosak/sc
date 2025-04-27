// Define the SynthDef
(
SynthDef(\blip, { |freq|
	var env = Env.perc(level: 0.1, releaseTime: 0.2).kr(doneAction: Done.freeSelf);
	var sig = SinOsc.ar(freq) * env;
	Out.ar(0, [sig, sig]);
}).add;
)

// Define melodies and harmonies
(
Pdef(\melody, Pbind(
	\instrument, \blip,
	\dur, Pseq([0.5, 1, 0.5, 0.5, 0.5, 0.5, 0.5], inf),
	\degree, Pseq([0, 4, 7, 8, 4, 6, 7], inf),
	\scale, Scale.major,
	\octave, 4
));

Pdef(\melody2, Pbind(
	\instrument, \blip,
	\dur, Pseq([2], inf),
	\degree, Pseq([0, 4], inf),
	\scale, Scale.major,
	\octave, 3
));

Pdef(\melody3, Pbind(
	\instrument, \blip,
	\dur, Pseq([2], inf),
	\degree, Pseq([2, 1], inf),
	\scale, Scale.major,
	\octave, 4
));

Pdef(\melody4, Pbind(
	\instrument, \blip,
	\dur, Pseq([1], inf),
	\degree, Pseq([4, 2, 3, 1], inf),
	\scale, Scale.major,
	\octave, 5
));

Pdef(\melody5, Pbind(
	\instrument, \blip,
	\dur, Pseq([1], inf),
	\degree, Pseq([4, 7, 8, 6], inf),
	\scale, Scale.major,
	\octave, 5
));

Pdef(\harmony, Pbind(
	\instrument, \blip,
	\dur, Pseq([0.5], inf),
	\degree, Pseq([3, 2, 1, 0], inf),
	\scale, Scale.major,
	\octave, 6
));

Pdef(\harmony2, Pbind(
	\instrument, \blip,
	\dur, Pseq([0.5, 0.5, 0.5, 1, 0.5, 0.5, 0.5], inf),
	\degree, Pseq([1, 0, -3, 0, 0, 1, 2], inf),
	\scale, Scale.major,
	\octave, 6
));

Pdef(\harmony3, Pbind(
	\instrument, \blip,
	\dur, Pseq([0.5], inf),
	\degree, Pseq([0, -1, -2, -3], inf),
	\scale, Scale.major,
	\octave, 6
));

Pdef(\harmony4, Pbind(
	\instrument, \blip,
	\dur, Pseq([0.5], inf),
	\degree, Pseq([5, 4, 3, 2], inf),
	\scale, Scale.major,
	\octave, 6
));

Pdef(\harmony5, Pbind(
	\instrument, \blip,
	\dur, Pseq([0.25], inf),
	\degree, Pseq([7, 8, 6, 7, 5, 6, 4, 5], inf),
	\scale, Scale.major,
	\octave, 6
));

Pdef(\harmony5, Pbind(
	\instrument, \blip,
	\dur, Pseq([0.125], inf),
	\degree, Pseq([10, 7, 9, 8, 5, 7, 6, 4, 5, 3, 4, 2, 3, 5, 7], inf),
	\scale, Scale.major,
	\octave, 6
));

Pdef(\harmony6, Pbind(
	\instrument, \blip,
	\dur, Pseq([0.125], inf),
	\degree, Pseq([10, 7, 9, 8, 5, 7, 6, 4, 5, 3, 4, 2, 3, 5, 7, 8], inf),
	\scale, Scale.major,
	\octave, 7
));
)

// GUI
(
// Define window and patterns
var window, view, patterns, names, colors;

patterns = [\melody, \melody2, \melody3, \melody4, \melody5, \harmony, \harmony2, \harmony3, \harmony4, \harmony5, \harmony6];
names = ["Melody1", "Melody2", "Melody3", "Melody4", "Melody5", "Harmony 1", "Harmony 2", "Harmony 3", "Harmony 4", "Harmony 5", "Harmony6"];

// Define a color list matching patterns
colors = [
	Color(0.2, 0.7, 1), Color(0.2, 0.7, 1), Color(0.2, 0.7, 1), Color(0.2, 0.7, 1), Color(0.2, 0.7, 1),  // Melodies
	Color(0.8, 0.3, 0.6), Color(0.8, 0.3, 0.6), Color(0.8, 0.3, 0.6), Color(0.8, 0.3, 0.6), Color(0.8, 0.3, 0.6), Color(0.8, 0.3, 0.6) // Harmonies
];

window = Window("Pattern Controller", Rect(100, 100, 315, 430)); // a little taller and wider
view = window.view;

// Change window background to a light gray
window.background_(Color.black);

// Set decorator
view.decorator = FlowLayout(view.bounds, 5@5, 5@5);

patterns.do({ |pattern, i|
	var playButton, stopButton;

	// Play button
	playButton = StaticText(view, 150@30)
		.string_("▶️ Play " ++ names[i])
		.background_(colors[i])
		.stringColor_(Color.black)
		.align_(\center)
		.mouseDownAction_({
			Pdef(pattern).play(TempoClock.default, quant: 4);
		});

	// Stop button
	stopButton = StaticText(view, 150@30)
		.string_("⏹️ Stop " ++ names[i])
		.background_(colors[i].blend(Color.white, 0.3)) // lighter shade for stop
		.stringColor_(Color.black)
		.align_(\center)
		.mouseDownAction_({
			Pdef(pattern).stop;
		});
});

// 🚫 Stop Everything button
StaticText(view, 305@30)
	.string_("✋ Stop EVERYTHING ✋")
	.background_(Color.red.blend(Color.blue, 0.3);)
	.stringColor_(Color.white)
	.align_(\center)
	.mouseDownAction_({
		patterns.do({ |pattern|
			Pdef(pattern).stop;
		});
	});

window.front;
)




