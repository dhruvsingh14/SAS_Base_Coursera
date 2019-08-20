%let path = C:\Users\dhnsingh\Documents\ECRB94;
libname cr "&path\data";

*******************************;
* 	  Practice Quiz 5.01	   ;
*******************************;

data q3_sales;
	set cr.m7_sales cr.m8_sales(rename = (Employee_ID=EmpID)) cr.m9_sales;
run;

proc contents data = cr.m9_sales;
run;

