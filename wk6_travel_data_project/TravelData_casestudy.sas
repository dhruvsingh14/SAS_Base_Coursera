%let path = C:\Users\dhnsingh\Documents\ECRB94;
libname cr "&path\data";

* reading in data ;
data tourism;
	set cr.tourism;
run;

* creating cleaned columns;
data tourism;
	set tourism;
	retain Country_Name Tourism_Type Category;
	if A ne . then Country_Name = Country;
	if Country = "Inbound tourism" then Tourism_Type = "Inbound tourism";
	else if Country = "Outbound tourism" then Tourism_Type = "Outbound tourism";  
	if A = . and country ne "Inbound tourism" and country ne "Outbound tourism" then Category = Country;
run;

DATA tourismFilled (DROP = filledX) ;
	SET tourism ;
	RETAIN filledX ; /* keeps the last non-missing value in memory */
	IF NOT MISSING(Country_Name) THEN filledX = Country_Name ; /* fills the new variable with non-missing value */
	Country_Name = filledX ;
RUN ;












data country_info;
	set cr.country_info;
run;

* runnining proc contents;
proc contents data = tourism;
run;

proc contents data = country_info;
run;


* sorting data sets;
proc sort data = tourism;
	by country;
run;

proc sort data = country_info;
	by country;
run;

* merging first;
data country_tourism;
	merge tourism country_info;
	by country;
run;













* transposing in steps;

* step 1: furling out country column, narrow to wide;
proc sort data = tourism;
	by A;
run;

* wide to long ;
proc transpose data = tourism out = tourism_w;
	var country _1995 -- _2014;
	by A ;
run;
	

