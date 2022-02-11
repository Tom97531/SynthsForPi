
// read wave buffer
// TODO: make a class of it
(
~sndDir = PathName.new(thisProcess.nowExecutingPath.dirname ++ "/snd");
~currentSoundDirNum = 0;
~currentSoundDir = ~sndDir.entries[0];
~currentSampleNum = 0;
~currentSample = ~currentSoundDir.entries[0];

~buffers = Array.newClear(5);

~buffers.do({
	arg item;
	item = Buffer.readChannel(s, ~currentSample.fullPath, channels:[0]);
});

~loadSample = {
	arg keyPressed, bufferNumber;

	// change directory
	if (keyPressed == 0, { // up
		~currentSoundDirNum = ~currentSoundDirNum - 1;

		if (~currentSoundDirNum < 0, {
			~currentSoundDirNum = ~sndDir.entries.size - 1;

		});
		~currentSoundDir = ~sndDir.entries[~currentSoundDirNum];
		~currentSampleNum = 0;
	});
	if (keyPressed == 1, { // down
		~currentSoundDirNum = ~currentSoundDirNum + 1;
		if (~currentSoundDirNum >= ~sndDir.entries.size, {
			~currentSoundDirNum = 0;

		});
		~currentSoundDir = ~sndDir.entries[~currentSoundDirNum];
		~currentSampleNum = 0;
	});

	// change sample
	if (keyPressed == 2, { // right
		~currentSampleNum = ~currentSampleNum + 1;
		if (~currentSampleNum >= ~currentSoundDir.entries.size, {
			~currentSampleNum = 0;
		});
	});
	if (keyPressed == 3, { // left
		~currentSampleNum = ~currentSampleNum - 1;
		if (~currentSampleNum < 0, {
			~currentSampleNum = ~currentSoundDir.entries.size - 1;
		});
	});

	~currentSample = ~currentSoundDir.entries[~currentSampleNum];
	~buffers[bufferNumber] = Buffer.readChannel(s, ~currentSample.fullPath, channels:[0]);
	// upgate all buffers
	~grans[bufferNumber].set(\buf, ~buffers[bufferNumber]);
	};
)