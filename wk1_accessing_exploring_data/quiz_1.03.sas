libname cr '\\toaster\homes\d\h\dhnsingh\nt\ecrb94_ue\ecrb94_ue\ECRB94\data';

***********************;
* 	Quiz 1.03		   ;
***********************;

proc contents data=cr._all_ nods;
run;

***********************;
* 	Quiz 1.04		   ;
***********************;

options validvarname=v7;

proc import datafile = '\\toaster\homes\d\h\dhnsingh\nt\ecrb94_ue\ecrb94_ue\ECRB94\data\payroll.csv'
	dbms =csv
	out = payroll
	replace;
	getnames = yes;
	guessingrows = 425;
run;

proc contents data = payroll;
run;
	

***********************;
* 	Quiz 1.05		   ;
***********************;

libname cert xlsx '\\toaster\homes\d\h\dhnsingh\nt\ecrb94_ue\ecrb94_ue\ECRB94\data\employee.xlsx';

data work.adds;
	set cert.addresses;
run;

data work.phones;
	set cert.phones;
run;

proc contents data = adds;
run;
