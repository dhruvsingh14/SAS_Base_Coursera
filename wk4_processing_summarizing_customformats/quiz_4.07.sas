%let path = C:\Users\dhnsingh\Documents\ECRB94;
libname cr "&path\data";

*******************************;
* 	  Practice Quiz 4.07	   ;
*******************************;

data fish;
	set sashelp.fish;
	Length = round(mean(of Length1--Length3),.01);
run;

proc means data = fish mean sum min max maxdec = 2;
	var Length;
	class Species;
run;

*******************************;
* 	  Practice Quiz 4.08	   ;
*******************************;

proc contents data = sashelp.baseball;
run;

data outfield;
	set sashelp.baseball;
	where substr(Position, 2, 1) = 'F';
	Player=catx(" ", scan(Name, 2, ','), scan(Name, 1, ','));
	BatAvg=round(nHits/nAtBat, 0.001);
run;

proc sort data = outfield;
	by descending BatAvg;
run;

*******************************;
* 	  Practice Quiz 4.09	   ;
*******************************;

proc contents data= emp_new;
run;

data emp_new;
	set cr.employee_new (rename = (HireDate = HireDateChar));
	EmpID=substr(EmpID, 4);
	HireDate=input(HireDateChar, anydtdte10.);
	Salary=input(AnnualSalary, dollar12.);
	drop HireDateChar;
	format HireDate date9. Salary dollar12.;
run;	
	

