*******************************;
* 	  Practice Quiz 4.01	   ;
*******************************;

%let path = C:\Users\dhnsingh\Documents\ECRB94;
libname cr "&path\data";

proc contents data = cr.employee;
run;

* debugging ;

data emp_US emp_AU;
	set cr.employee(keep=EmpID Name Country JobTitle Salary Department TermDate);
	where TermDate = .;
	Country=upcase(country);
	if TermDate = . and Country="US" then output emp_US;
	else output emp_AU;
run;

*******************************;
* 	  Practice Quiz 4.02	   ;
*******************************;

* from scratch solution ;
data dead (drop = status) alive (drop = status DeathCause AgeAtDeath);
	set sashelp.heart;
	if Status = "Dead" then output dead;
	else if Status = "Alive" then output alive;
run;

*******************************;
* 	  Practice Quiz 4.03	   ;
*******************************;
