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
/* creating empty columns */
	Tourism_type = "";
	Category = "";
/* populating columns conditionally */
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
	keep Country_Name Tourism_Type Category Series YR2014;
run;

/* checking cleaned table */
proc contents data = tourism;
run;

* populating empty rows by filling down using retain ;
data cleaned_tourism (drop = filledType) ;
	set tourism;
	retain filledType ; /* keeps the last non-missing value in memory */
	if not missing(Tourism_type) then filledType = Tourism_type ; /* fills the new variable with non-missing value */
	Tourism_type = filledType;
	if series eq '' then delete;
run;

/* reading in country info data set */
data country_info;
	set cr.country_info (rename=(country=Country_Name));
run;


/* sorting data by country_name */
proc sort data = country_info;
	by country_name;
run;


/* creating custom format for continents */
proc format;
	value continent 1 = "North America"
					2 = "South America"
					3 = "Europe"
					4 = "Africa"
					5 = "Asia"
					6 = "Oceania"
					7 = "Antarctica";
run;

/*proc contents data = final_tourism;*/
/*run;*/

/* merge step creating two data sets */
data final_tourism nocountryfound;
	merge country_info (in = c) cleaned_tourism (in = t);
	by country_name;
	if c = 1 and t = 1 then output final_tourism;
	else if c = 0 and t = 1 then output nocountryfound;
	format continent continent.;
run;










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
	

