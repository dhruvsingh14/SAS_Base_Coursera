*******************************;
* 	  Practice Quiz 1.07	   ;
*******************************;

libname cr '\\toaster\homes\d\h\dhnsingh\nt\ecrb94_ue\ecrb94_ue\ECRB94\data';

proc sort data = cr.employee_raw out = emp_clean
		dupout = emp_check
		nodupkey;		
	by empid;
run;	

*where country in ('US', 'AU');
proc freq data = emp_clean;
	tables country department;
run;

proc print data = cr.employee_raw;
	where termdate > hiredate and termdate ne .;
run;

/*printing violation to aforementioned rule*/
proc print data = cr.employee_raw;
	where termdate > hiredate and termdate ne .;
run;


*******************************;
* 	  Practice Quiz 1.08	   ;
*******************************;

libname cr '\\toaster\homes\d\h\dhnsingh\nt\ecrb94_ue\ecrb94_ue\ECRB94\data';

proc sort data = cr.employee_raw out = emp_sort
		dupout = emp_check
		nodupkey;		
	by empid;
run;	

proc print data = emp_sort;
	where jobtitle contains 'Logistics';
	format hiredate date9.;
run;

proc means data = emp_sort;
	where hiredate > '01JAN2010'd and termdate eq .;
	format hiredate date9.;
run;
	
proc sort data = emp_sort out = sal_sort;
	by descending salary;
run;
