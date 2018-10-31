

(

( //a gabor(approx. gaussian-shaped) grain
SynthDef(\gabor1,{|out, amp=0.01, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2|
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*MouseY.kr(0.9,1.1)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)*MouseX.kr(0, BufFrames.kr(bufnum)));
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(Env.sine(sustain,amp2),
		doneAction:2);
	OffsetOut.ar(out,HPF.ar(Pan2.ar(sig*env,pan),25));
},\ir!5).add;
);

(//wider,quasi-gauss env, w/hold time in middle
SynthDef(\gabWide1,{|out, amp=0.01, freq=440, sustain=0.01, pan, width=0.5, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2|
	var holdT = sustain*width;
	var fadeT = width*sustain*0.5;
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*MouseY.kr(0.9,1.1)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)*MouseX.kr(0, BufFrames.kr(bufnum)));
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.4;
	var env = EnvGen.ar(
		Env([0,1,1,0],[fadeT,holdT,fadeT],\sin),
		levelScale:amp2,
		doneAction:2);
	OffsetOut.ar(out,HPF.ar(Pan2.ar(sig*env,pan),25));
},\ir!5).add;
);

(//percussive envelope
SynthDef(\percSin1,{|out,amp=0.1, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2|
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*MouseY.kr(0.9,1.1)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)*MouseX.kr(0, BufFrames.kr(bufnum)));
	var amp2 = amp * AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(
		Env.perc(0.1,0.9,amp2),
		timeScale: sustain,
		doneAction:2
	);
	OffsetOut.ar(out,HPF.ar(Pan2.ar(sig*env,pan),25));
},\ir!5).add;
);

(//reverse percussive env
SynthDef(\rpercSin1,{|out, amp=0.1, freq=440, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2|
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*MouseY.kr(0.9,1.1)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)*MouseX.kr(0, BufFrames.kr(bufnum)));
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(
		Env.perc(0.9, 0.1,amp2),
		timeScale:sustain,
		doneAction:2
	);
	OffsetOut.ar(out,HPF.ar(Pan2.ar(sig*env,pan),25));
},\ir!5).add;
);

(//expo decay envelope
SynthDef(\expodec1,{|out, freq=440, amp=0.3, sustain=0.01, pan, bufnum, trigs=2000, rate =1,
	samp_rand_rate = 1, samp_rand_range = 2|
	var snd = FSinOsc.ar(freq);
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*MouseY.kr(0.9,1.1)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)*MouseX.kr(0, BufFrames.kr(bufnum)));
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = XLine.ar(amp2,amp2*0.001,sustain,doneAction:2);
	OffsetOut.ar(out,HPF.ar(Pan2.ar(sig*env,pan),25));
},\ir!5).add;//5 refers to num arg
);


(//reverse expo decay envelope
SynthDef(\rexpodec1,{|out, freq=440, amp=0.3, sustain=0.01, pan,
	bufnum, trigs=2000, rate= 1,
	samp_rand_rate = 1, samp_rand_range = 2|
	var trig =  Blip.kr(trigs,1,80);
	var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*MouseY.kr(0.9,1.1)*rate, trig,
		LFNoise1.kr(samp_rand_rate).range(1,samp_rand_range)*MouseX.kr(0, BufFrames.kr(bufnum)));
	var snd = FSinOsc.ar(freq);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = XLine.ar(amp2*0.001,amp2,sustain,doneAction:2)
	*(AmpComp.ir(freq)*0.5);
	OffsetOut.ar(out,HPF.ar(Pan2.ar(sig*env,pan,amp.lag(0.1)),25));

},\ir!5).add;//5 refers to num arg
);


(//expo decay envelope no samples
SynthDef(\expodec,{|out, freq=440, amp=0.3, sustain=0.01, pan|
	var snd = SinOsc.ar(freq);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = XLine.ar(amp2,amp2*0.001,sustain,doneAction:2);
	OffsetOut.ar(out,Pan2.ar(snd*env,pan));
},\ir!5).add;//5 refers to num arg
);

(//reverse expo decay envelope
SynthDef(\rexpodec,{|out, freq=440, amp=0.3, sustain=0.01, pan|
	var snd = SinOsc.ar(freq);
	var amp2 = amp*AmpComp.ir(freq.max(50))*0.5;
	var env = XLine.ar(amp2*0.001,amp2,sustain,doneAction:2)
	*(AmpComp.ir(freq)*0.5);
	OffsetOut.ar(out,Pan2.ar(snd*env,pan));

},\ir!5).add;//5 refers to num arg
);

(//percussive envelope
SynthDef(\percSin,{|out,amp=0.1, freq=440, sustain=0.01, pan|
	var snd = SinOsc.ar(freq);
	var amp2 = amp * AmpComp.ir(freq.max(50))*0.5;
	var env = EnvGen.ar(
		Env.perc(0.1,0.9,amp2),
		timeScale: sustain,
		doneAction:2
	);
	OffsetOut.ar(out,Pan2.ar(snd*env,pan));
},\ir!5).add;
)
)
//"C:/Users/Jackalaka/Desktop/misc samples/10_27_18 a foggy, quiet, morning/birds--then_ocean.wav"
~courtyard = Buffer.read(s,"C:/Users/Jackalaka/Desktop/misc samples/10_25_18 courtyard_birds/TAS768edit.wav");
~foggy_morning = Buffer.read(s,"C:/Users/Jackalaka/Desktop/misc samples/10_27_18 a foggy, quiet, morning/short brd chirp NO background noise.wav");


(
MIDIIn.connectAll;
~zero_levels = -60;
~gen_levels = -60;
~one_levels = -60;
~two_levels = -60;
~three_levels = -60;
~four_levels = -60;


MIDIFunc.cc({ |ccval, cn,chan,src|
	~gen_levels = (ccval.linlin(0,127,0.001,1).ampdb);
	["~gen_levels"+(ccval.linlin(0,127,0.001,1)).ampdb].postln;
},0);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~zero_levels = (ccval.linlin(0,127,0.001,3)).ampdb;
	["~zero_levels"+(ccval.linlin(0,127,0.001,3)).ampdb].postln;
},1);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~one_levels = (ccval.linlin(0,127,0.001,4)).ampdb;
	["~one_levels"+(ccval.linlin(0,127,0.001,4)).ampdb].postln;
},2);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~two_levels = (ccval.linexp(0,127,0.01,6)).ampdb;
	["~two_levels"+(ccval.linexp(0,127,0.01,6)).ampdb].postln;
},3);


~random_zero = 3.4;
~random_one = 1.4;
~random_two = 1.1;
~random_three = 1.4;
~pitch_zero = 0.2;
~pitch_pattern_zero = 18;
~pitch_one = 1.4;
~pitch_pattern_one = 14;
~pitch_two = 0.4;
~pitch_pattern_two = 12;

MIDIFunc.cc({ |ccval, cn,chan,src|
	~random_zero = ccval.linlin(0,127,1,10);
	["random_zero"+ccval.linlin(0,127,1,10)].postln;
},18);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~random_one = ccval.linexp(0,127,1,10);
	["random_one"+ccval.linexp(0,127,1,10)].postln;
},20);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~random_two = ccval.linlin(0,127,1,10);
	["random_two"+ccval.linlin(0,127,1,10)].postln;
},22);


MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_zero = ccval.linlin(0,127,-4,4);
	["pitch_zero"+ccval.linlin(0,127,-4,4)].postln;
},26);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_pattern_zero = ccval.linlin(0,127,1,45);
	["pitch_pattern_zero"+ccval.linexp(0,127,1,45)].postln;
},27);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_one = ccval.linlin(0,127,-4,4);
	["pitch_one"+ccval.linlin(0,127,-4,4)].postln;
},28);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_pattern_one = ccval.linlin(0,127,1,45);
	["pitch_pattern_one"+ccval.linexp(0,127,1,45)].postln;
},29);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_two = ccval.linlin(0,127,-4,4);
	["pitch_two"+ccval.linlin(0,127,-4,4)].postln;
},30);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_pattern_two = ccval.linlin(0,127,1,45);
	["pitch_pattern_two"+ccval.linexp(0,127,1,45)].postln;
},31);

);


s.reboot;


//----------------------------1st song
(
~pan_kitchen= Array.new;
~folder101 = PathName.new("C:/Users/Jackalaka/Desktop/misc samples/pan_line/pan_line_conserve_sound");
(
~folder101.entries.do({
	arg path;
	~pan_kitchen = ~pan_kitchen.add(Buffer.read(s,path.fullPath));
})
))

//default (experimental)
// pan kitchen[0]
~pitch_zero = 0.2;
~pitch_pattern_zero = 18;
(
~zero = Pbindef(\0,
	\instrument,\expodec1,
	\sustain,Pn(Pgeom(0.04,1.2,35),inf),
	\dur,Pn(Pgeom(0.03,1.2,10),inf),
	\bufnum, ~pan_kitchen[0],
	\trigs, 0.001,
	\amp, Pfunc{~zero_levels.dbamp},
	\rate, Pn(Pgeom(Pfunc{~pitch_zero}.iter,1.1,Pfunc{~pitch_pattern_zero}.iter),inf),
	\samp_rand_rate, 2,
	\samp_rand_range, Pfunc{~random_zero}
).play;
)
~zero.stop;

//SineWave
s.reboot;
//Pn(Pgeom(10,1.2,7))
(
~gen = Pbindef(\no,
	\instrument,\expodec,
	\freq,Pn(Pbrown(30,50,4)),
	\sustain,Pn(Pgeom(10,1.2,7)),
	\dur,Pn(Pbrown(3.8,12),inf),
	\pan,Pn(Pwhite(-1,1)),
	\amp,Pfunc{~gen_levels.dbamp},

).play;
)
~gen.stop;


(
Pbindef(\no,
	\instrument,\expodec,
	\freq,Pn(Pbrown(50,60,4)),
	\sustain,Pn(Pgeom(10,1.2,7)),
	\dur,Pn(Pgeom(5.5,1.2,10),inf),
	\amp, 0.1,

).play;
)

(
~bowlspoon = Array.new;
~folder9 = PathName.new("C:/Users/Jackalaka/Desktop/misc samples/bowl and spoon");
(
~folder9.entries.do({
	arg path;
	~bowlspoon = ~bowlspoon.add(Buffer.read(s,path.fullPath));
})
))


//default
//
(
 ~one = Pbindef(\1,
	\instrument,\rexpodec1,
	\sustain,Pn(Pgeom(0.001,1.2,35),inf),
	\dur,Pn(Pgeom(0.001,1.2,10),inf),
	\bufnum, ~bowlspoon[2],
	\trigs, 0.001,
	\amp, Pfunc{~one_levels.dbamp},
	\rate, Pn(Pgeom(Pfunc{~pitch_one}.iter,1.1,Pfunc{~pitch_pattern_one}.iter),inf),
	\samp_rand_rate, 0.1,
	\samp_rand_range, Pfunc{~random_one},
).play;
)
~one.stop;
///Magnets
(
~magnets= Array.new;
~mag = PathName.new("C:/Users/Jackalaka/Desktop/misc samples/10_28_18-magents");
(
~mag.entries.do({
	arg path;
	~magnets = ~magnets.add(Buffer.read(s,path.fullPath));
})
))

s.reboot;
//mag [5]
//abrupt changes from silence to full vol
~pitch_two = 0.4;
~pitch_pattern_two = 12;
(
~two = Pbindef(\2,
	\instrument,\rexpodec1,
	\sustain,Pn(Pgeom(0.001,1.2,35),inf),
	\dur,Pn(Pgeom(0.001,1.2,10),inf),
	\bufnum, ~magnets[5],
	\trigs, 0.001,
	\amp, Pfunc{~two_levels.dbamp},
	\rate, Pn(Pgeom(Pfunc{~pitch_two}.iter,1.1,Pfunc{~pitch_pattern_two}.iter),inf),
	\samp_rand_rate, 1.1,
	\samp_rand_range, Pfunc{~random_two},
).play;
)
~two.stop

//------------------part2
d = Buffer.read(s,"C:/Users/Jackalaka/Desktop/misc samples/10_9_18/beautiful_birds_clean.wav" );

//default
(
Pbindef(\yes,
	\instrument,\rpercSin1,  //rpercSin1 expodec1 rexpodec1 percSin1 gabWide1 gabor1
	\sustain,Pn(Pgeom(0.1,1.2,35),inf),
	\dur,Pn(Pgeom(0.09,1.2,10),inf),
	\bufnum, d,
	\trigs, 0.001,
	\amp, 1,
	\rate, Pn(Pbrown(0.7,0.1),inf),
	\samp_rand_rate, 1,
	\samp_rand_range, 1.1

).play;
)

//fuck around
(
Pbindef(\yes,
	\instrument,\rpercSin1,  //rpercSin1 expodec1 rexpodec1 percSin1 gabWide1 gabor1
	\sustain,Pn(Pgeom(0.1,1.2,35),inf),
	\dur,Pn(Pgeom(0.09,1.2,10),inf),
	\bufnum, d,
	\trigs, 0.001,
	\amp, 1,
	\rate, Pn(Pbrown(0.7,0.1),inf),
	\samp_rand_rate, 1,
	\samp_rand_range, 1.1

).play;
)



(
~dusk= Array.new;
~folder6 = PathName.new("C:/Users/Jackalaka/Desktop/misc samples/9_8_18dusk_walk/scdir");
(
~folder6.entries.do({
	arg path;
	~dusk = ~dusk.add(Buffer.read(s,path.fullPath));
})
))

f = Buffer.read(s,"C:/Users/Jackalaka/Desktop/misc samples/10_20-a_weekend_with_marisa/key_shoe_concert.wav");







(
Pbindef(\yes,
	\instrument,\rpercSin1,
	\sustain,Pn(Pgeom(2.6,1.3,25),inf),
	\dur,Pn(Pgeom(2,1.2,10),inf),
	\bufnum, ~dusk[1],
	\trigs, 0.001,
	\amp, 2,
	\rate, Pn(Pbrown(-1,1.5),inf),
	\samp_rand_rate, 0.1,
	\samp_rand_range, 4
).play;
)

(
Pbindef(\yes,
	\instrument,\rexpodec1,
	\sustain,Pn(Pgeom(0.001,1.2,35),inf),
	\dur,Pn(Pgeom(0.001,1.2,10),inf),
	\bufnum, ~courtyard,
	\trigs, 0.001,
	\amp, 1,
	\rate, Pn(Pgeom(-1.4,1.1,12),inf),
	\samp_rand_rate, 0.1,
	\samp_rand_range, 3
).play;
)


///Magnets
(
~magnets= Array.new;
~mag = PathName.new("C:/Users/Jackalaka/Desktop/misc samples/10_28_18-magents");
(
~mag.entries.do({
	arg path;
	~magnets = ~magnets.add(Buffer.read(s,path.fullPath));
})
))


(
Pbindef(\yes,
	\instrument,\expodec1,
	\sustain,Pn(Pgeom(0.19,1.2,35),inf),
	\dur,Pn(Pgeom(0.07,1.2,10),inf),
	\bufnum, ~magnets[5],
	\trigs, 0.001,
	\amp, 0.2,
	\rate, Pn(Pgeom(1.4,1.1,12),inf),
	\samp_rand_rate, 0.1,
	\samp_rand_range, 1.4
).play;
)


//dusk[4]---------general layout

//default
(
Pbindef(\yes,
	\instrument,\rexpodec1,
	\sustain,Pn(Pgeom(0.001,1.2,35),inf),
	\dur,Pn(Pgeom(0.001,1.2,10),inf),
	\bufnum, f,
	\trigs, 0.001,
	\amp, 1,
	\rate, Pn(Pgeom(0.4,1.1,12),inf),
	\samp_rand_rate, 1.1,
	\samp_rand_range, 1.1
).play;
)

(
Pbindef(\yes,
	\instrument,\expodec1,
	\sustain,Pn(Pgeom(0.0035,1.3,25),inf),
	\dur,Pn(Pgeom(0.009,1.2,10),inf),
	\bufnum, f,
	\trigs, 0.001,
	\amp, 1.4,
	\rate, Pn(Pgeom(1.1,1.1,12),inf),
	\samp_rand_rate, 0.1,
	\samp_rand_range, 4
).play;
)

//fuck around
(
Pbindef(\yes,
	\instrument,\rexpodec1,
	\sustain,Pn(Pgeom(0.001,1.2,35),inf),
	\dur,Pn(Pgeom(0.001,1.2,10),inf),
	\bufnum, ~dusk[4],
	\trigs, 0.001,
	\amp, 3,
	\rate, Pn(Pgeom(2.5,1.1,12),inf),
	\samp_rand_rate, 1.1,
	\samp_rand_range, 1.1
).play;
)