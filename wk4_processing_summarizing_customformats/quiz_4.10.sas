%let path = C:\Users\dhnsingh\Documents\ECRB94;
libname cr "&path\data";

*******************************;
* 	  Practice Quiz 4.10	   ;
*******************************;

proc format;
	value BMIRANGE
		low -< 18.5 = 'Underweight'
		18.5 - 24.9 = 'Normal'
		25 - 29.9 = 'Overweight'
		30 - high = 'Obese';
run;

proc freq data = sashelp.bmimen;
	where age >= 21;
	table BMI;
	format BMI BMIRANGE.;
run;

*******************************;
* 	  Practice Quiz 4.11	   ;
*******************************;

data continent_codes;
	set cr.continent_codes;
run;

proc format;
	value CONTFMT
		91 = 'North America'
		92 = 'South America'
		93 = 'Europe'
		94 = 'Africa'
		95 = 'Asia'
		96 = 'Oceania'
		97 = 'Antarctica';
run;

data demographics;
	set cr.demographics;
run;

proc contents data = demographics;
run;

proc means data = demographics min max mean sum;
	var pop;
	class cont;
	format cont CONTFMT.;
run;

*******************************;
* 	  Practice Quiz 4.11	   ;
*******************************;

* debugging exercise ;

proc format;
	value statfmt S="Single"
	              M="Married"
	              O="Other";
	value salrange low<50000="Under $50K"
	               50000-100000="50K-100K"
	               100000<high="Over 100K";
run;

proc freq data=cr.employee;
	tables Status;
	tables City*Salary / nopercent nocol;
run;
