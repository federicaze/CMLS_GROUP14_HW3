s.boot();
s.plotTree();



(
SynthDef(\fmSynth, {

	arg carFreq = 440, carPartial = 1, amp = 0.5,
	modFreq = 220, modPartial = 1, modIndex = 1,
	outBus = 0, pan = 0.0;

	var carSig, modSig;

	modSig = SinOsc.ar(modFreq * modPartial, 0, amp* modFreq * modIndex);
	carSig = SinOsc.ar(carFreq * carPartial + modSig, 0, amp);

	Out.ar(outBus, Pan2.ar(carSig, pan));

}).add;
)

x = Synth(\fmSynth);

x.set(\carFreq, 220, \carPartial, 2, \modFreq, 880, \modPartial, 2, \modIndex, 1, \pan, -1, \amp, 0.1, );

x.free;




(
~p1 = 440.0;
~p2 = 70.0;
~p3 = 5.0;
~p4 = 700.0;


r = Routine({
	//var p1 = 440.0, p2 = 70.0, p3 = 5.0, p4 = 700;
	var b = NetAddr.new("127.0.0.1", 12000);
	{
		b.sendMsg('/parameters', ~p1, ~p2, ~p3, ~p4);
		~p1 = ~p1 + 0.001 %1000;
		~p2 = ~p2 + 0.001 %1000;
		~p3 = ~p3 + 0.001 %1000;
		~p4 = ~p4 + 0.001 %1000;

}.loop;}).play;
)


(
var p1 = 440.0, p2 = 7.0, p3 = 5.0, p4 = 440;
b = NetAddr.new("127.0.0.1", 12000);    // create the NetAddr
b.sendMsg('/parameters', p1, p2, p3, p4);
)