
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
~foggy_morning = Buffer.read(s,"/Users/jkilgore/Music/misc-samples/10_27_18 a foggy, quiet, morning/short brd chirp NO background noise.wav");


(
MIDIIn.connectAll;

//Default Volume Levels
~zero_levels = -60;
~gen_levels = -60;
~one_levels = -60;
~two_levels = -60;
~three_levels = -60;
~four_levels = -60;
~five_levels = -60;
~six_levels = -60;
~seven_levels = -60;
~eight_levels = -60;
~nine_levels = -60;

//Mapping Volume Levels To Vertical Sliders

//1st bank
//(0..127).collect(_.lincurve(0,127,0.001,4,-2)).plot;

MIDIFunc.cc({ |ccval, cn,chan,src|
	~gen_levels = (ccval.linlin(0,127,0.001,1).ampdb);
	["~gen_levels"+(ccval.linlin(0,127,0.001,1)).ampdb].postln;
},0);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~zero_levels = (ccval.linexp(0,127,0.001,3)).ampdb;
	["~zero_levels"+(ccval.linexp(0,127,0.001,3)).ampdb].postln;
},1);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~one_levels = (ccval.lincurve(0,127,0.001,4,-2)).ampdb;
	["~one_levels"+(ccval.lincurve(0,127,0.001,4,-2)).ampdb].postln;
},2);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~two_levels = (ccval.lincurve(0,127,0.01,4,-2)).ampdb;
	["~two_levels"+(ccval.lincurve(0,127,0.01,4,-2)).ampdb].postln;
},3);

//2nd bank

MIDIFunc.cc({ |ccval, cn,chan,src|
	~three_levels = (ccval.lincurve(0,127,0.001,4,-2).ampdb);
	["~three_levels"+(ccval.lincurve(0,127,0.001,4,-2)).ampdb].postln;
},4);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~four_levels = (ccval.lincurve(0,127,0.001,3,-2)).ampdb;
	["~four_levels"+(ccval.lincurve(0,127,0.001,3,-2)).ampdb].postln;
},5);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~five_levels = (ccval.lincurve(0,127,0.001,4,-2)).ampdb;
	["~five_levels"+(ccval.lincurve(0,127,0.001,4,-2)).ampdb].postln;
},6);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~six_levels = (ccval.lincurve(0,127,0.01,4,-2)).ampdb;
	["~six_levels"+(ccval.lincurve(0,127,0.01,4,-2)).ampdb].postln;
},7);

///---------Default PAD Values
~sustain_gen = 1.4;
~random_zero = 3.4;
~random_one = 1.4;
~random_two = 1.1;
~random_three = 1.4;
~random_four = 1.4;
~random_five = 1.4;
~random_six = 1.4;

~pitch_gen = 0.2;
~pitch_pattern_gen = 7;
~pitch_zero = 0.2;
~pitch_pattern_zero = 18;
~pitch_one = 1.4;
~pitch_pattern_one = 14;
~sustain_two = 0.0045;
~dur_two = 1;
~pitch_three = 0.4;
~pitch_pattern_three = 12;
~pitch_four = 0.4;
~pitch_pattern_four = 12;
~pitch_five = 0.4;
~pitch_pattern_five = 12;
~pitch_six = 0.4;
~pitch_pattern_six = 12;

/////PAD MAPPING

// first row of pads x-axis
MIDIFunc.cc({ |ccval, cn,chan,src|
	~sustain_gen = ccval.linlin(0,127,1,60);
	["sustain_gen"+ccval.linlin(0,127,1,60)].postln;
},16);
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

//third row of pads x-axis
MIDIFunc.cc({ |ccval, cn,chan,src|
	~random_three = ccval.linlin(0,127,1,10);
	["random_three"+ccval.linlin(0,127,1,10)].postln;
},32);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~random_four = ccval.linexp(0,127,1,10);
	["random_four"+ccval.linexp(0,127,1,10)].postln;
},34);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~random_five = ccval.linlin(0,127,1,10);
	["random_five"+ccval.linlin(0,127,1,10)].postln;
},36);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~random_six = ccval.linlin(0,127,1,10);
	["random_six"+ccval.linlin(0,127,1,10)].postln;
},38);

//2nd row of pads xy axis
MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_gen = ccval.linlin(0,127,-4,4);
	["pitch_gen"+ccval.linlin(0,127,-4,4)].postln;
},24);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_pattern_gen = ccval.linlin(0,127,0.01,10);
	["pitch_pattern_gen"+ccval.linexp(0,127,1,45)].postln;
},25);
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
	~sustain_two = ccval.linlin(0,127,0.001,0.01);
	["sustain_two"+ccval.linlin(0,127,0.001,0.01)].postln;
},30);

MIDIFunc.cc({ |ccval, cn,chan,src|
	~dur_two = ccval.linlin(0,127,0.001,0.01);
	["dur_two"+ccval.linexp(0,127,0.001,0.01)].postln;
},31);

//4th row of pads xy axis

MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_three = ccval.lincurve(0,127,-4,4,-2);
	["pitch_three"+ccval.lincurve(0,127,-4,4,-2)].postln;
},40);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_pattern_three = ccval.linlin(0,127,1,45);
	["pitch_pattern_three"+ccval.linexp(0,127,1,45)].postln;
},41);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_four = ccval.linlin(0,127,-4,4);
	["pitch_four"+ccval.linlin(0,127,-4,4)].postln;
},42);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_pattern_four = ccval.linlin(0,127,1,45);
	["pitch_pattern_four"+ccval.linexp(0,127,1,45)].postln;
},43);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_five = ccval.linlin(0,127,-4,4);
	["pitch_five"+ccval.linlin(0,127,-4,4)].postln;
},44);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_pattern_five = ccval.linlin(0,127,1,45);
	["pitch_pattern_five"+ccval.linexp(0,127,1,45)].postln;
},45);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_six = ccval.linlin(0,127,-4,4);
	["pitch_six"+ccval.linlin(0,127,-4,4)].postln;
},46);
MIDIFunc.cc({ |ccval, cn,chan,src|
	~pitch_pattern_six = ccval.linlin(0,127,1,45);
	["pitch_pattern_six"+ccval.linexp(0,127,1,45)].postln;
},47);

);


s.reboot;


//----------------------------Part1 field recording


~pitch_zero = 0.2;
~pitch_pattern_zero = 18;


(
~dusk= Array.new;
~folder6 = PathName.new("/Users/jkilgore/Music/misc-samples/9_8_18dusk_walk/scdir/");
(
~folder6.entries.do({
	arg path;
	~dusk = ~dusk.add(Buffer.read(s,path.fullPath));
})
));


(
~zero = Pbindef(\0,
	\instrument,\rpercSin1,
	\sustain,Pn(Pgeom(2.6,1.3,25),inf),
	\dur,Pn(Pgeom(2,1.2,10),inf),
	\bufnum, ~dusk[4],
	\trigs, 0.001,
	\amp,Pfunc{~zero_levels.dbamp} ,
	\rate, Pn(Pbrown(-1.8,2.5),inf),
	\samp_rand_rate, 0.1,
	\samp_rand_range, Pfunc{~random_zero}
).play;
)
~zero.stop;





//SineWave

//sustain Pn(Pgeom(10,1.2,7))
//Pfunc{~sustain_gen}
//dur
//freq 42
//pan 0
(
~gen = Pbindef(\no,
	\instrument,\expodec,
	\freq,42,
	\sustain,Pfunc{~sustain_gen},
	\dur,Pn(Pbrown(3.8,12),inf),
	\pan,0,
	\amp,Pfunc{~gen_levels.dbamp}

).play;
)
(
~gen = Pbindef(\no,
	\instrument,\expodec,
	\freq,Pn(Pbrown(40,60,4)),
	\sustain,Pn(Pgeom(10,1.2,7),inf),
	\dur,Pn(Pbrown(3.8,12),inf),
	\pan,Pn(Pwhite(-1,1)),
	\amp,Pfunc{~gen_levels.dbamp}

).play;
)
~gen.stop;




///////////// BowlSpoon Glass Panner
(
~bowlspoon = Array.new;
~folder9 = PathName.new("/Users/jkilgore/Music/misc-samples/bowl and spoon/");
(
~folder9.entries.do({
	arg path;
	~bowlspoon = ~bowlspoon.add(Buffer.read(s,path.fullPath));
})
));

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



///////////dusk[8] rhythms--note, sample needs to "warm up" for some reason
~sustain_two = 0.0045;
(
~two = Pbindef(\two,
	\instrument,\percSin1,
	\sustain,Pn(Pgeom(Pfunc{~sustain_two}.iter,1.3,25),inf),
	\dur,Pn(Pgeom(Pfunc{~dur_two}.iter,1.2,10),inf),
	\bufnum, ~dusk[8],
	\trigs, 0.001,
	\amp, Pfunc{~two_levels.dbamp},
	\rate, Pn(Pbrown(0.01,0.6),inf),
	\samp_rand_rate, 0.1,
	\samp_rand_range, Pfunc{~random_two}
).play;
)
~two.stop;








//------------Part2-----------mag [5]

(
~mag= Array.new;
~folder61 = PathName.new("/Users/jkilgore/Music/misc-samples/10_28_18-magents/");
(
~folder61.entries.do({
	arg path;
	~mag = ~mag.add(Buffer.read(s,path.fullPath));
})
))

//abrupt changes from silence to full vol
~pitch_three = 0.4;
~pitch_pattern_three = 12;
(
~three = Pbindef(\3,
	\instrument,\rexpodec1,
	\sustain,Pn(Pgeom(0.001,1.2,35),inf),
	\dur,Pn(Pgeom(0.001,1.2,10),inf),
	\bufnum, ~mag[5],
	\trigs, 0.001,
	\amp, Pfunc{~three_levels.dbamp},
	\rate, Pn(Pgeom(Pfunc{~pitch_three}.iter,1.1,Pfunc{~pitch_pattern_three}.iter),inf),
	\samp_rand_rate, 1.1,
	\samp_rand_range, Pfunc{~random_three},
).play;
)
~three.stop



//------------------part3
d = Buffer.read(s,"/Users/jkilgore/Music/misc-samples/10_9_18/beautiful_birds_clean.wav");

//default
(
~birds = Pbindef(\yes,
	\instrument,\rpercSin1,  //rpercSin1 expodec1 rexpodec1 percSin1 gabWide1 gabor1
	\sustain,Pn(Pgeom(0.1,1.2,35),inf),
	\dur,Pn(Pgeom(0.09,1.2,10),inf),
	\bufnum, d,
	\trigs, 0.001,
	\amp, Pfunc{~six_levels.dbamp},
	\rate, Pn(Pbrown(0.7,0.1),inf),
	\samp_rand_rate, 1,
	\samp_rand_range, 1.1

).play;
)
~birds.stop;

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







///----------------------------MISC-------------------------------------------


////other zero
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

//---------stubs
(
~four = Pbindef(\4,
	\instrument,\expodec1,
	\sustain,Pn(Pgeom(0.001,1.2,35),inf),
	\dur,Pn(Pgeom(0.001,1.2,10),inf),
	\bufnum, ~magnets[4],
	\trigs, 0.001,
	\amp, Pfunc{~four_levels.dbamp},
	\rate, Pn(Pgeom(Pfunc{~pitch_four}.iter,1.1,Pfunc{~pitch_pattern_four}.iter),inf),
	\samp_rand_rate, 1.1,
	\samp_rand_range, Pfunc{~random_four},
).play;
)
~four.stop;

(
~five = Pbindef(\5,
	\instrument,\rexpodec1,
	\sustain,Pn(Pgeom(0.01,1.2,35),inf),
	\dur,Pn(Pgeom(0.01,1.2,10),inf),
	\bufnum, ~dusk[4],
	\trigs, 0.001,
	\amp, Pfunc{~five_levels.dbamp},
	\rate, Pn(Pgeom(Pfunc{~pitch_five}.iter,1.1,Pfunc{~pitch_pattern_five}.iter),inf),
	\samp_rand_rate, 1.1,
	\samp_rand_range, Pfunc{~random_five},
).play;
)
~now = Buffer.read(s,"/Users/jkilgore/Music/misc-samples/10_20-a_weekend_with_marisa/key_shoe_concert.wav");
(
~six = Pbindef(\6,
	\instrument,\rexpodec1,
	\sustain,Pn(Pgeom(0.001,1.2,35),inf),
	\dur,Pn(Pgeom(0.001,1.2,10),inf),
	\bufnum, ~magnets[5],
	\trigs, 0.001,
	\amp, Pfunc{~six_levels.dbamp},
	\rate, Pn(Pgeom(Pfunc{~pitch_six}.iter,1.1,Pfunc{~pitch_pattern_six}.iter),inf),
	\samp_rand_rate, 1.1,
	\samp_rand_range, Pfunc{~random_six},
).play;
)
