SynthDef(\blip, { |freq|
	var env = Env.perc(level: 0.1, releaseTime: 0.2).
	kr(doneAction: Done.freeSelf);
	var sig = SinOsc.ar(freq: freq, width: 0.5) * env;
	Out.ar(0, [sig, sig])
}).add;


a = Pdef(\melody,
	Pbind(
		\instrument, \blip,
		\dur, Pseq([0.5, 1, 0.5, 0.5, 0.5, 0.5, 0.5], inf),
		\degree, Pseq([0, 4, 6, 8, 4, 6, 7], inf),
		\scale, Scale.minor,
		\octave, 4
	)
).play(TempoClock.default, quant: 4);


b = Pdef(\harmony,
	Pbind(
		\instrument, \blip,
		\dur, Pseq([0.5], inf),
		\degree, Pseq([3,2,1,0], inf),
		\scale, Scale.major,
		\octave, 4
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

c = Pdef(\harmony2,
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

d = Pdef(\harmony3,
	Pbind(
		\instrument, \blip,
		\dur, Pseq([0.25], inf),
		\degree, Pseq([7,8,6,7,5,6,4,5], inf),
		\scale, Scale.major,
		\octave, 6
	)
).play(TempoClock.default, quant: 4);

e = Pdef(\harmony4,
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

f = Pdef(\drumBeat,
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

(
a.stop
b.stop
c.stop
d.stop
e.stop
f.stop
)