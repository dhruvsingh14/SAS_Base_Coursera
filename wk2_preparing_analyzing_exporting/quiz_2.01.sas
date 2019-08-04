*******************************;
* 	  Practice Quiz 2.01	   ;
*******************************;

libname cr '\\toaster\homes\d\h\dhnsingh\nt\ecrb94_ue\ecrb94_ue\ECRB94\data';

proc contents data = sashelp.holiday;
run;

data holiday2019;
	set sashelp.holiday;
	where end=. and rule=0;
	CountryCode=substr(Category,4,2);
	Date=mdy(month, day, 2019);
	keep Desc CountryCode Date;
run;


*******************************;
* 	  Practice Quiz 2.02	   ;
*******************************;

data sales; 
	set cr.employee;
	where department = "Sales" and termdate = .;
	length SalesLevel $6;
	if findw(jobtitle, "I")>0 then SalesLevel = "Entry";
	else if findw(jobtitle, "II")>0 or findw(jobtitle, "III")>0 then SalesLevel = "Middle";
	else if findw(jobtitle, "IV")>0 then SalesLevel = "Senior";
run;

proc sort data = sales out = sales_sort;
	by saleslevel;
run;

proc means data = sales_sort;
	by saleslevel;
run;


*******************************;
* 	  Practice Quiz 2.03	   ;
*******************************;

data bonus; 
	set cr.employee;
	where termdate = .;
	YearsEmp = YrDif(HireDate, '01JAN2019'd);
	if YearsEmp >= 10 then do;
		Bonus = 0.03*salary;
		Vacation = 20;
	end;
	else if YearsEmp = 10 then do;
		Bonus = 0.02*salary;
		Vacation = 15;
	end;
run;

proc sort data = bonus out = bonus_sort;
	by descending YearsEmp;
run;

proc means data = bonus_sort;
	by descending vacation;
run;
