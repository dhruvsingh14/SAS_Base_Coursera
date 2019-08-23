%let path = C:\Users\dhnsingh\Documents\ECRB94;
libname cr "&path\data";

*******************************;
* 	  Practice Quiz 5.07	   ;
*******************************;

proc sort data=sashelp.shoes out=shoes_sort nodupkey;
	by Region Subsidiary Product;
run;

proc transpose data=shoes_sort out=shoes_sales (drop = _name_ _label_);
	var sales;
	by Region Subsidiary;
	id Product;
run;


*******************************;
* 	  Practice Quiz 5.08	   ;
*******************************;

data training_wide;
	set cr.employee_training;
run;

proc sort data = training_wide;
	by name;
run;

proc transpose data = training_wide out = training_narrow;
	by name;
	var Compliance_Training Corporate_Security On_the_Job_Safety;
run;

proc sort data = training_narrow;
	by col1;
run;

proc freq data = training_narrow;
	table col1;
	format col1 monname.;
run;
