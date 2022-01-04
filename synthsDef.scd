
SynthDef.new(\gs2, {
	arg sync=1, dens=20, grainDur=0.1, durRand=1, buf=0,
	rate=1, pos=0, posSpeed=1, posRand=0,
	grainEnv=(-1), pan=0, panHz=0.1, panRand=0,
	amp=1, out=0;

	var sig, densCtrl, durCtrl, posCtrl, panCtrl;

	densCtrl = Select.ar(sync, [Dust.ar(dens), Impulse.ar(dens)]);

	durCtrl = grainDur * LFNoise1.kr(100).exprange(1/durRand, durRand);

	posCtrl = Phasor.ar(0, posSpeed*BufRateScale.ir(buf), 0, BufSamples.ir(buf)-1);
	posCtrl = posCtrl + LFNoise1.kr(100).bipolar(posRand*SampleRate.ir);
	posCtrl = posCtrl / BufSamples.ir(buf);
	posCtrl = posCtrl + pos;

	panCtrl = pan + LFNoise1.kr(panHz).bipolar(panRand*SampleRate.ir);

	sig = GrainBuf.ar(
		2,
		densCtrl,
		durCtrl,
		buf,
		rate,
		posCtrl,
		2,
		panCtrl,
		grainEnv
	);

	sig = sig * amp;

	Out.ar(out, sig);
}).add;


// Mono in reverb

SynthDef.new(\reverb, {
	arg in, out=0,
	mix=0.33, size=10, damp=0.5, time=3;
	var sig;
	sig = In.ar(in, 1);
	sig = GVerb.ar(sig, size, time, damp, 0.8, 15, 1-mix, mix, mix-0.2)!2;
	// sig = GVerb.ar(sig, size, time, damp)!2;
	// sig = GVerb.ar(sig, size)!2;
	Out.ar(out, sig);
}).add;


// Low pass filter

SynthDef.new(\LPF, {
	arg in, out,
	freq=15000, q=1;
	var sig;
	sig = In.ar(in, 1);
	sig = BLowPass4.ar(sig, freq, q);
	Out.ar(out, sig);
}).add;
