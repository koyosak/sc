# Sharing is Caring!!

## what I did for this project

#### I initially was thinking of making horror ambient patch since I wanted to experiment what kind of sound I can make out of Supercollider. However, when I started working on it, Wendy enjoying the drum patch came to my mind and it inspired me to make patch that is not only easy to play for other Supercoliders, but also for everyone who understand only basic about computer (how to use mouse and press button on computer) I think I made this patch a true sharing is caring patch.

## Patch Breakdown

#### This code is simple yet fun code. I only used one SynthDef and created different layers of lines that could go together with any pairs or orders. Anyone can control it using GUI. I also put effort on GUI to make it aesthetically pleasant and fun for everyone. There are play and stop button for every lines and one stop eveerything button just in case when you get overwhelmed.

### SynthDef

#### I created percussive note that almost sound like the marimba


    (
    SynthDef(\blip, { |freq|
        var env = Env.perc(level: 0.1, releaseTime: 0.2).kr(doneAction: Done.freeSelf);
        var sig = SinOsc.ar(freq) * env;
        Out.ar(0, [sig, sig]);
    }).add;
    ) 
 

### one of the melody line

    Pdef(\melody, Pbind(
        \instrument, \blip,
        \dur, Pseq([0.5, 1, 0.5, 0.5, 0.5, 0.5, 0.5], inf),
        \degree, Pseq([0, 4, 7, 8, 4, 6, 7], inf),
        \scale, Scale.major,
        \octave, 4
    ));

#### I defined this line as \melody and put every information (duration, melody line, scale and octave)

## GUI

#### One of the thing I really liked when I saw Wendy playing the drum patch is how GUI makes Supercollider accessible. It inspired me to use GUI for this project.

#### I defined window, view, patterns, names, colors first.

    
    var window, view, patterns, names, colors;

#### I defined every melody and harmony lines I had and correlated them with buttons.

    patterns = [\melody, \melody2, \melody3, \melody4, \melody5, \harmony, \harmony2, \harmony3, \harmony4, \harmony5, \harmony6];
    names = ["Melody1", "Melody2", "Melody3", "Melody4", "Melody5", "Harmony 1", "Harmony 2", "Harmony 3", "Harmony 4", "Harmony 5", "Harmony6"];

#### I defined colors for each buttons.

colors = [
	Color(0.2, 0.7, 1), Color(0.2, 0.7, 1), Color(0.2, 0.7, 1), Color(0.2, 0.7, 1), Color(0.2, 0.7, 1),  // Melodies
	Color(0.8, 0.3, 0.6), Color(0.8, 0.3, 0.6), Color(0.8, 0.3, 0.6), Color(0.8, 0.3, 0.6), Color(0.8, 0.3, 0.6), Color(0.8, 0.3, 0.6) // Harmonies
];

#### Setting the size of the window according to the size of the button for the clean, organized look and made the background black.

    window = Window("Pattern Controller", Rect(100, 100, 315, 430));
    view = window.view;

    window.background_(Color.black);


#### Setting the space between each button using decorator

    view.decorator = FlowLayout(view.bounds, 5@5, 5@5);

#### Setting the play and stop button for each line of harmonies and melodies (color and function)

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

#### Setting the emergency stop button to stop all of the line at once

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

[link to my Sharing is Caring patch](https://github.com/koyosak/sc/blob/main/Sharing%20is%20Caring/Sharing_is_Caring_Code.scd)