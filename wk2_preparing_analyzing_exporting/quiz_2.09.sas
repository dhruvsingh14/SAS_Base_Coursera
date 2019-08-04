*******************************;
* 	  Practice Quiz 2.09	   ;
*******************************;

* debugging errors ;
ods graphics on;
ods noproctitle; /* no space in no proctitle option */

* ods excel is the correct syntax; * ods xlsx is not valid ;
ods excel file="\\toaster\homes\d\h\dhnsingh\nt\ecrb94_ue\ecrb94_ue\ECRB94\output\heart.xlsx"; /* local directory */
title "Distribution of Patient Status";
proc freq data=sashelp.heart order=freq;
	tables DeathCause Chol_Status BP_Status / nocum plots=freqplot;
run;

title "Summary of Measures for Patients";
proc means data=sashelp.heart mean;
	var AgeAtDeath Cholesterol Weight Smoking;
	class Sex;
run;
ods excel close; /* ods _ close instead of end */


*******************************;
* 	  Practice Quiz 2.10	   ;
*******************************;

* modifying to generate pdf;
ods noproctitle;
ods pdf file = "\\toaster\homes\d\h\dhnsingh\nt\ecrb94_ue\ecrb94_ue\ECRB94\output\truck.pdf" 
		style = journal startpage = no;

title "Truck Summary";
title2 "SASHELP.CARS Table";

proc freq data=sashelp.cars;
	where Type="Truck";
	tables Make / nocum;
run;

proc print data=sashelp.cars;
	where Type="Truck";
	id Make;
	var Model MSRP MPG_City MPG_Highway;
run;

ods pdf close;


*******************************;
* 	  Practice Quiz 2.11	   ;
*******************************;

%let path = \\toaster\homes\d\h\dhnsingh\nt\ecrb94_ue\ecrb94_ue\ECRB94;
libname cr "&path/data";

proc export data = cr.employee_current outfile = "&path/output/employees_current.csv" dbms = csv replace;
run;
