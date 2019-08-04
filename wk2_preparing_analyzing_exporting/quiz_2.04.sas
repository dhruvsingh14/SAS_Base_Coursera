*******************************;
* 	  Practice Quiz 2.04	   ;
*******************************;

libname cr '\\toaster\homes\d\h\dhnsingh\nt\ecrb94_ue\ecrb94_ue\ECRB94\data';

* sorting by team;
proc sort data = sashelp.baseball out = baseball;
	by Team;
run;

* checking for labels;
proc contents data = baseball;
run;

* diagnosing code errors;
* adding labels to report;
title "Baseball Team Statistics";
proc print data=baseball lable;
	by Team;
	var Name Position YrMajor nAtBat nHits nHome;
	sum nAtBat nHits nHome;
	id Name; /*replacing obs column with name */
run;

*******************************;
* 	  Practice Quiz 2.05	   ;
*******************************;

* sorting data by relevant variables;
proc sort data = cr.employee out = employee;
	by city department jobtitle;
run;

* finding highest emp count by city;
proc means data = employee sum;
	class city;
run;

* creating report for percentage of total: sales;
proc freq data = employee;
	tables department;
run;

* checking for unique jobtitle values;
proc freq data = employee nlevels;
	tables jobtitle;
run;


*******************************;
* 	  Practice Quiz 2.06	   ;
*******************************;

data profit;
	set cr.profit;
run;

* creating twoway freq table;
proc freq data = profit;
	format order_date monname.; /* monname format to display only one row for each month of order date*/
	tables order_date*order_source/ norow nocol;
run;


*******************************;
* 	  Practice Quiz 2.07	   ;
*******************************;
title;
data employee;
	set cr.employee;
run;

* creating report of salaries by jobtitle;
proc means data = employee sum mean min max maxdec=0;
	where department = "Sales";
	var salary;
	*class jobtitle;
run;


*******************************;
* 	  Practice Quiz 2.08	   ;
*******************************;

data employee;
	set cr.employee;
run;

* creating report of salaries by jobtitle;
proc means noprint data = employee;
	var salary;
	output out = salary_summary mean = AvgSalary; 
	class department city; 
	*TotalSalary = sum(Salary, AvgSalary);
	ways 2;
run;

/*proc means data=cr.employee noprint;*/
/*    var Salary;*/
/*    class Department City;*/
/*    output out=salary_summary mean=AvgSalary sum=TotalSalary;*/
/*    ways 2;*/
/*run;*/
/**/
