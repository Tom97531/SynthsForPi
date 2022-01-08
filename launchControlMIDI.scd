(
// launch control setup
// MIDI CC
~launchControlXLCC = Dictionary.newFrom([
//~k1 =
	13, {arg val; ~grans[0].set(\posSpeed, val.linlin(0, 127, 0, 10));},
	14, {arg val; ~grans[1].set(\posSpeed, val.linlin(0, 127, 0, 10));},
	15, {arg val; ~grans[2].set(\posSpeed, val.linlin(0, 127, 0, 10));},
	16, {arg val; ~grans[3].set(\posSpeed, val.linlin(0, 127, 0, 10));},
	17, {arg val; ~grans[4].set(\posSpeed, val.linlin(0, 127, 0, 10));},
	18, nil,
	19, nil,
	20, nil,
// ~k2 =
	29, {arg val; ~grans[0].set(\grainDur, val.linlin(0, 127, 0.01, 5));},
	30, {arg val; ~grans[1].set(\grainDur, val.linlin(0, 127, 0.01, 5));},
	31, {arg val; ~grans[2].set(\grainDur, val.linlin(0, 127, 0.01, 5));},
	32, {arg val; ~grans[3].set(\grainDur, val.linlin(0, 127, 0.01, 5));},
	33, {arg val; ~grans[4].set(\grainDur, val.linlin(0, 127, 0.01, 5));},
	34, nil,
	35, nil,
	36, {arg val; ~reverb.set(\damp, val.linlin(0, 127, 0, 1));},
// ~k3 =
    49, {arg val; ~grans[0].set(\dens, val);},
	50, {arg val; ~grans[1].set(\dens, val);},
	51, {arg val; ~grans[2].set(\dens, val);},
	52, {arg val; ~grans[3].set(\dens, val);},
	53, {arg val; ~grans[4].set(\dens, val);},
	54, nil,
	55, {arg val; ~lpf.set(\q, val.linlin(0, 127, 0, 1));},
	56, {arg val; ~reverb.set(\size, val.linlin(0, 127, 10, 50));},
// ~fader =
	77, {arg val; ~grans[0].set(\pos, val.linlin(0, 127, 0, 1));},
	78, {arg val; ~grans[1].set(\pos, val.linlin(0, 127, 0, 1));},
	79, {arg val; ~grans[2].set(\pos, val.linlin(0, 127, 0, 1));},
	80, {arg val; ~grans[3].set(\pos, val.linlin(0, 127, 0, 1));},
	81, {arg val; ~grans[4].set(\pos, val.linlin(0, 127, 0, 1));},
	82, nil,
	83, {arg val; ~lpf.set(\freq, val.linexp(0, 127, 20, 18000));},
	84, {arg val; ~reverb.set(\mix, val.linlin(0, 127, 0, 1));val.linlin(0, 127, 0, 1).postln;},
// ~bUp =
	106, {arg val; if (val == 127, {~loadSample.value(0);});},
// ~bDown =
	107, {arg val; if (val == 127, {~loadSample.value(1);});},
// ~bRight =
	104, {arg val; if (val == 127, {~loadSample.value(2);});},
// ~bLeft =
	105, {arg val; if (val == 127, {~loadSample.value(3);});}
]);

// MIDI note
~launchControlXLNote = Dictionary.newFrom([
// ~bFocus =
	41, {~grans[0].set(\amp, 0);},
	42, {~grans[1].set(\amp, 0);},
	43, {~grans[2].set(\amp, 0);},
	44, {~grans[3].set(\amp, 0);},
	57, {~grans[4].set(\amp, 0);},
	58, nil,
	59, nil,
	60, nil,
// ~bControl =
	73, {~grans[0].set(\amp, 0.5);},
	74, {~grans[1].set(\amp, 0.5);},
	75, {~grans[2].set(\amp, 0.5);},
	76, {~grans[3].set(\amp, 0.5);},
	89, {~grans[4].set(\amp, 0.5);},
	90, nil,
	91, nil,
	92, nil,
// ~bBottom =
	108, nil,
	107, nil,
	106, nil,
	105, nil
]);

~launchControlCC = Dictionary.newFrom([
//~k1 =
	21, {arg val; ~grans[0].set(\rate, val.linlin(0, 127, 0, 10));},
	22, {arg val; ~grans[1].set(\rate, val.linlin(0, 127, 0, 10));},
	23, {arg val; ~grans[2].set(\rate, val.linlin(0, 127, 0, 10));},
	24, {arg val; ~grans[3].set(\rate, val.linlin(0, 127, 0, 10));},
	25, {arg val; ~grans[4].set(\rate, val.linlin(0, 127, 0, 10));},
	26, nil,
	27, nil,
	28, nil,
//~k2 =
	41, {arg val; ~grans[0].set(\amp, val.linlin(0, 127, 0, 0.9));},
	42, {arg val; ~grans[1].set(\amp, val.linlin(0, 127, 0, 0.9));},
	43, {arg val; ~grans[2].set(\amp, val.linlin(0, 127, 0, 0.9));},
	44, {arg val; ~grans[3].set(\amp, val.linlin(0, 127, 0, 0.9));},
	45, {arg val; ~grans[4].set(\amp, val.linlin(0, 127, 0, 0.9));},
	46, nil,
	47, nil,
	48, nil
]);

~launchControlXLNote = Dictionary.newFrom([
// ~bFocus =
	9,  nil,
	10, nil,
	11, nil,
	12, nil,
	25, nil,
	26, nil,
	27, nil,
	28, nil,
]);

MIDIClient.init;
MIDIIn.connectAll;

MIDIdef.noteOn(\noteOneTest, {
	arg val, num, chan, src;
	[val, num, chan, src].postln;
	if(chan == 0, {
		~launchControlNote[num].value;
	},{
		~launchControlXLNote[num].value;
	});
});

MIDIdef.cc(\ccTest, {
	arg val, chan, src;
	[val, chan, src].postln;
	if(src == 0, {
		~launchControlCC[chan].value(val);
	},{
		~launchControlXLCC[chan].value(val);
	});
});
)