%let path = C:\Users\dhnsingh\Documents\ECRB94;
libname cr "&path\data";

* reading in data ;
data tourism;
	set cr.tourism;
run;

proc contents data = tourism;
run;

proc sort data = tourism;
	by A country series;
run;

* wide to long ;
proc transpose data = tourism out = tourism_narrow;
	var _1995 -- _2014;
	by A country series;
run;
	

