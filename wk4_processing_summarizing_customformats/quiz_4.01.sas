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

proc sort data = cr.employee_current out = employee_current;
	by department;
run;

/* creating a summary table with cumulating salary column by department */
data salary;
	set employee_current;
	by department;
	if first.department = 1 then TotalSalary = 0;
	TotalSalary + Salary;
	if last.department = 1;
run;

/* salary forecast table */
data salaryforecast;
	set salary;
	format TotalSalary dollar12.;
	Year = 1;
	TotalSalary = TotalSalary*1.03;
	output;
	Year = 2;
	TotalSalary = TotalSalary*1.03;
	output;
	Year = 3;
	TotalSalary = TotalSalary*1.03;
	output;
run;
