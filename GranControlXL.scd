// INIT
(
s.waitForBoot({
	"./synthsDef.scd".loadRelative;
	"./launchControlMIDI.scd".loadRelative;
	"./loadSample.scd".loadRelative;
};)
)

// instanciate granControlXL
(
~fxGroup = Group.new;
~synthGroup = Group.new;

~reverbBus = Bus.audio(s, 1);
~lpfBus = Bus.audio(s, 1);
~grans = Array.newClear(5);

// 5 granulators
5.do({
	arg i;
	~grans[i] = Synth.new(\gs2, [
		\buf, ~buffers[i],
		\amp, 0,
		\sync, 1,
		\posRand, 0.005,
		\out, ~lpfBus
	], ~synthGroup);
});


~reverb = Synth.new(\reverb,[
	\in, ~reverbBus
], ~fxGroup);

~lpf = Synth.new(\LPF, [
	\in, ~lpfBus,
	\out, ~reverbBus
], ~fxGroup);

)

//////////////////////////////////////////////
// for debug
s.scope;
s.meter;
s.plotTree;

(
~synthGroup.free;
~fxGroup.free;
)

~reverbBus.scope;
~lpfBus.scope;

~reverb.set(\mix, 0.1);
~reverb.set(\size, 0.8);
~reverb.set(\damp, 0.2);


