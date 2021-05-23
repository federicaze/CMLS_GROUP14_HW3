s.boot();

SerialPort.devices;
~port = SerialPort.new("COM3", 9600);


(
~charArray = [ ];
~getValues = Routine.new({
	var ascii;
	{ascii = ~port.read.asAscii;
		if(ascii.isDecDigit,{~charArray = ~charArray.add(ascii)});
		if(ascii == $a,{
			~val = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ];
			if(~val < 1025, {~pCarFreq = ~val});
			if(~val >= 1025 && ~val < 2050, {~pCarPart = ~val});
			if(~val >= 2050 && ~val < 3075, {~pModFreq = ~val});
			if(~val >= 3075 && ~val < 4100, {~pModPart = ~val});
			if(~val >= 4100 && ~val < 5125, {~pMod2Freq = ~val});
			if(~val >= 5125 && ~val < 6150, {~pAmp = ~val});
			if(~val >= 6150 && ~val < 7175, {~pPan = ~val});
			if(~val >= 7175 && ~val < 8200, {~pModIndex = ~val});
			if(~val >= 8200, {~pMod2Index = ~val});
		})
	}.loop;}
).play;
)


(
SynthDef(\fmSynth, {

	arg carFreq = 440.00, carPartial = 1,
	modFreq = 220.00, modPartial = 1, modIndex = 0,
	mod2Freq = 440.00, mod2Index = 0,
    amp = 0.01, pan = 0.0 outBus = 0;

	var carSig, modSig, mod2Sig;

	mod2Sig = SinOsc.ar(mod2Freq, 0, mod2Freq * mod2Index);
	modSig = SinOsc.ar(modFreq * modPartial + mod2Sig, 0, modFreq * modIndex);
	carSig = SinOsc.ar(carFreq * carPartial + modSig, 0, amp);

	Out.ar(outBus, Pan2.ar(carSig, pan));

}).send;

~x = Synth(\fmSynth);

//~x.set(\carFreq, 262, \carPartial, 4, \modFreq, 2000, \modPartial, 1, \modIndex, 1, \mod2Freq, 1000, \mod2Partial, 0, \pan, 0, \amp, 0.05);
)

//~x.free();

(
~control = Routine.new({
	var b = NetAddr.new("127.0.0.1", 12000);
	{~x.set(\carFreq, ~pCarFreq.linlin(0, 1024, 0, 3000), \carPartial, ~pCarPart.linlin(1025, 2049, 1, 8), \modFreq, ~pModFreq.linlin(2050, 3074, 0, 3000), \modPartial, ~pModPart.linlin(3075, 4099, 1, 8), \modIndex, ~pModIndex.linlin(7175, 8199, 0, 10), \mod2Freq, ~pMod2Freq.linlin(4100, 5124, 0, 3000), \mod2Partial, ~pMod2Index.linlin(8200, 9224, 1, 8), \amp, ~pAmp.linlin(5125, 6149, 0, 1), \pan, ~pPan.linlin(6150, 7174, -1, 1));
		b.sendMsg('/parameters', ~pCarFreq, ~pCarPart, ~pModFreq, ~pModPart, ~pModIndex, ~pMod2Freq, ~pMod2Index, ~pAmp, ~pPan);
		0.01.wait;
}.loop;}
).play;
)