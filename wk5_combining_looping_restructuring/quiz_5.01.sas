%let path = C:\Users\dhnsingh\Documents\ECRB94;
libname cr "&path\data";

*******************************;
* 	  Practice Quiz 5.01	   ;
*******************************;

data q3_sales;
	set cr.m7_sales cr.m8_sales(rename = (Employee_ID=EmpID)) cr.m9_sales;
run;

proc freq data = q3_sales;
	table order_type;
run;

*******************************;
* 	  Practice Quiz 5.02	   ;
*******************************;

proc sort data = cr.employee out = employee;
	by empid;
run;

proc sort data = cr.employee_addresses out = employee_addresses;
	by employee_id;
run;

data emp_full;
	merge employee (in=emp rename=(EmpID=Employee_ID)) 
				employee_addresses (in=add);
	by Employee_ID;
	if emp=1;
run;

*******************************;
* 	  Practice Quiz 5.03	   ;
*******************************;

proc sort data=cr.employee(keep=EmpID Name Department) out=emp_sort;
	by EmpID;
run;

proc sort data=cr.employee_donations out=donate_sort;
	by EmpID;
run;

data donation;
	merge emp_sort(in=in_emp) donate_sort(in=in_don);
	by EmpID;
	if in_don=1 and in_emp=1 then TotalDonation=sum(of Qtr1-Qtr4);
		output donation;
run;
	


