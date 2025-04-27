(
SynthDef(\cfstring1, { arg i_out, freq = 360, gate = 1, pan, amp=0.1;
    var out, eg, fc, osc, a, b, w;
    fc = LinExp.kr(LFNoise1.kr(Rand(0.1, 2)), -1, 1, 500, 2000);
    osc = Mix.fill(8, {LFSaw.ar(freq * [Rand(0.99, 1.01), Rand(0.99, 1.01)], 0, amp) }).distort * 0.2;
    eg = EnvGen.kr(Env.perc(0.05, 1, 1, -4), gate, doneAction: Done.freeSelf);
    out = eg * RLPF.ar(osc, fc, 0.1);
    #a, b = out;
    Out.ar(i_out, Mix.ar(PanAz.ar(4, [a, b], [pan, pan+0.3])));
}).add;

e = Pbind(
    \degree, Pseq((0..6), inf),
    \dur, 0.2,
    \instrument, \cfstring1
).play; // returns an EventStream
)

( // an interactive session
e.stop
e.play
e.reset
e.mute; // keeps playing, but replaces notes with rests
e.unmute;
)

(
SynthDef("envSynth", {var env;
	env = EnvGen.kr(Env.linen(1, 2, 3, 0.6), doneAction:0,);
	Out.ar(0, SinOsc.ar(100))});
.add;
).play;

(
x={
	arg freq=78s;
	// | freq=220 |
	SinOsc.ar(freq:freq);
}.play; // .play will play it
)

SynthDef(\blip, { |freq|
	var env = Env.perc(level: 0.1, releaseTime: 0.2).
	kr(doneAction: Done.freeSelf);
	var sig = SinOsc.ar(freq: freq, width: 0.5) * env;
	Out.ar(0, [sig, sig])
}).add;


Pdef(\melody,
	Pbind(
		\instrument, \blip,
		\dur, Pseq([0.5, 1, 0.5, 0.5, 0.5, 0.5, 0.5], inf),
		\degree, Pseq([0, 4, 6, 8, 4, 6, 7], inf),
		\scale, Scale.minor
	)
).play(TempoClock.default, quant: 4);


Pdef(\harmony,
	Pbind(
		\instrument, \blip,
		\dur, Pseq([0.5], inf),
		\degree, Pseq([3,2,1,0], inf),
		\scale, Scale.major,
		\octave, 6
	)
).play(TempoClock.default, quant: 4);

Pdef(\harmony,
	Pbind(
		\instrument, \blip,
		\dur, Pseq([0.5], inf),
		\degree, Pseq([4,3,2,1], inf),
		\scale, Scale.minor,
		\octave, 6
	)
).play(TempoClock.default, quant: 4);

Pdef(\harmony2,
	Pbind(
		\instrument, \blip,
		\dur, Pseq([0.5], inf),
		\degree, Pseq([5,4,3,3], inf),
		\scale, Scale.major,
		\octave, 6
	)
).play(TempoClock.default, quant: 4);

Pdef(\harmony2,
	Pbind(
		\instrument, \blip,
		\dur, Pseq([0.5], inf),
		\degree, Pseq([6,5,4,3], inf),
		\scale, Scale.minor,
		\octave, 6
	)
).play(TempoClock.default, quant: 4);

Pdef(\harmony3,
	Pbind(
		\instrument, \blip,
		\dur, Pseq([0.25], inf),
		\degree, Pseq([7,8,6,7,5,6,4,5], inf),
		\scale, Scale.major,
		\octave, 6
	)
).play(TempoClock.default, quant: 4);

Pdef(\harmony4,
	Pbind(
		\instrument, \blip,
		\dur, Pseq([0.125], inf),
		\degree, Pseq([10,7,9,8,5,7,6,4,5,3,4,2,3,5,7], inf),
		\scale, Scale.major,
		\octave, 6
	)
).play(TempoClock.default, quant: 16);

Pdef(\harmony4,
	Pbind(
		\instrument, \blip,
		\dur, Pseq([0.125], inf),
		\degree, Pseq([10,7,9,8,5,7,6,4,5,3,4,2,3,5,7], inf),
		\scale, Scale.minor,
		\octave, 6
	)
).play(TempoClock.default, quant: 16);

SynthDef(\drums, { |freq|
	var env = Env.perc(level: 0.1, releaseTime: 0.2).
	kr(doneAction: Done.freeSelf);
	var sig = WhiteNoise.ar * env;
	var trigger = Impulse.ar(freq);
	sig = Latch.ar(sig, trigger);
	Out.ar(0, [sig, sig])
}).add;

Synth(\drums, [\freq, 500])
~bass = 500; ~snare = 10000;

Pdef(\drumBeat,
	Pbind(
		\instrument, \drums,
		\dur, Pseq([0.25, 0.375, 0.125, 0.125, 0.125], inf),
		\freq, Pseq([~bass, ~snare, ~bass, ~snare, ~bass], inf)
	)
).play(TempoClock.default, quant: 8);

Pdef(\drumBeat2,
	Pbind(
		\instrument, \drums,
		\dur, Pseq([0.5, 0.75, 0.125, 0.125, 0.125], inf),
		\freq, Pseq([~bass, ~snare, ~bass, ~snare, ~bass], inf)
	)
).play(TempoClock.default, quant: 8);

// Define the SynthDef first
SynthDef(\drum, { |freq = 500|
    var env = Env.perc(0.01, 0.3, 0.5, -4).kr(doneAction: Done.freeSelf);
    var sig = SinOsc.ar(freq) * env;
    Out.ar(0, [sig, sig]);
}).add;

// Set up your variables
~bass = 500;
~snare = 10000;

// Now you can play it
Synth(\drum, [\freq, ~bass]);
Synth(\drum, [\freq, ~snare]);

~envSynth.free;

