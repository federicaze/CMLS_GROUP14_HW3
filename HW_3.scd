s.boot();
s.plotTree();


// First, we enstablish the comunication between Arduino and Supercollider
SerialPort.devices;
~port = SerialPort.new("COM3", 9600);


~val =18;
if((~val >= 1025 && ~val < 2050), {postln("ok")});
// We define a routine that reads incoming value from Arduino and assign them to the correct parameter of the synth
(
~charArray = [ ];
~getValues = Routine.new({
	var ascii;
	{ascii = ~port.read.asAscii;
		if(ascii.isDecDigit,{~charArray = ~charArray.add(ascii)});
		if(ascii == $a,{
			~val = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ];
			if(~val < 1025, {~pCarFreq = round(~val.linlin(0, 1024, 0, 3000)*1000)/1000});
			if((~val >= 1025) and: (~val < 2050), {~pCarPart = round(~val.linlin(1025, 2049, 1, 8)*1000)/1000});
			if((~val >= 2050) and: (~val < 3075), {~pModFreq = round(~val.linlin(2050, 3074, 0, 3000)*1000)/1000});
			if((~val >= 3075) and: (~val < 4100), {~pModIndex = round(~val.linlin(3075, 4099, 1, 8)*1000)/1000});
			if((~val >= 4100) and: (~val < 5125), {~pMod2Freq = round(~val.linlin(4100, 5124, 0, 3000)*1000)/1000});
			if((~val >= 5125) and: (~val < 6150), {~pAmp = round(~val.linlin(5125, 6149, 0, 1)*1000)/1000});
			if((~val >= 6150) and: (~val < 7175), {~pPan = round(~val.linlin(6150, 7174, -1, 1)*1000)/1000});
			if((~val >= 7175) and: (~val < 8200), {~pModPart = round(~val.linlin(7175, 8199, 0, 10)*1000)/1000});
			if(~val >= 8200, {~pMod2Index = round(~val.linlin(8200, 9224, 1, 8)*1000)/1000});
		})
	}.loop;}
).play;
)


// We define the FMSynth we a carrier and two modulators that acts directly on the carrier
(
SynthDef(\fmSynth, {

	arg carFreq = 440.00, carPartial = 1,
	modFreq = 220.00, modPartial = 1, modIndex = 0,
	mod2Freq = 440.00, mod2Index = 0,
    amp = 0.01, pan = 0.0, outBus = 0;

	var carSig, modSig, mod2Sig;

	mod2Sig = SinOsc.ar(mod2Freq, 0, mod2Freq * mod2Index);
	modSig = SinOsc.ar(modFreq * modPartial, 0, modFreq * modIndex);
	carSig = SinOsc.ar(carFreq * carPartial + modSig + mod2Sig, 0, amp);

	Out.ar(outBus, Pan2.ar(carSig, pan));

}).add;

~x = Synth(\fmSynth);
)


// Finally, we define a second routine that sets the parameters of the synth to the values read from Arduino and sends those same values to Processing
(
~control = Routine.new({
	var b = NetAddr.new("127.0.0.1", 12000);
	{~x.set(\carFreq, ~pCarFreq, \carPartial, ~pCarPart, \modFreq, ~pModFreq, \modPart, ~pModPart, \modIndex, ~pModIndex, \mod2Freq, ~pMod2Freq, \mod2Index, ~pMod2Index, \amp, ~pAmp, \pan, ~pPan);
		b.sendMsg('/parameters', ~pCarFreq, ~pCarPart, ~pModFreq, ~pModIndex, ~pModPart, ~pMod2Freq, ~pMod2Index, ~pAmp, ~pPan);
		0.01.wait;
}.loop;}
).play;
)


~x.free();