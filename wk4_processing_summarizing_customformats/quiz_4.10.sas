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



