%let path = C:\Users\dhnsingh\Documents\ECRB94;
libname cr "&path\data";

* reading in tourism data ;
data tourism;
	set cr.tourism;
run;

proc contents data = tourism;
run;

* creating cleaned columns: country, type, category;
data tourism;
	retain Country_name Tourism_type Category Series YR2014;
	length Tourism_type $20. Category $50.;
	set tourism;
/* creating tourism type column */
	Tourism_type = "";
	Category = "";
	if A ne . then Country_Name = Country;
	if Country = "Inbound tourism" then Tourism_Type = "Inbound tourism";
	else if Country = "Outbound tourism" then Tourism_Type = "Outbound tourism";
/* modifying column values */
	if Country = "Arrivals - Thousands" then Category = "Arrivals";
	if Country = "Departures - Thousands" then Category = "Departures";
	if Country = "Passenger transport - US$ Mn" then Category = "Passenger transport - US$";
	if Country = "Tourism expenditure in other countries - US$ Mn" then Category = "Tourism expenditure in other countries - US$";
	if Country = "Tourism expenditure in the country - US$ Mn" then Category = "Tourism expenditure in the country - US$";
	if Country = "Travel - US$ Mn" then Category = "Travel - US$";
/* modifying series column */
	series = upcase(series);
	if series = ".." then series = "";
/* creating yr2014 column */
	YR2014 = 0;
	if findw(country,'Thousands')>0 then YR2014 = _2014*1000;
	if findw(country,'Mn')>0 then YR2014 = _2014*1000000;
	format YR2014 comma20.;
	keep Country_Name Tourism_Type Category Series Y2014;
run;

proc contents data = tourism;
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
	

