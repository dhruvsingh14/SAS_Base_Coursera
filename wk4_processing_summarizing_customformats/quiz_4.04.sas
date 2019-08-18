%let path = C:\Users\dhnsingh\Documents\ECRB94;
libname cr "&path\data";

*******************************;
* 	  Practice Quiz 4.04	   ;
*******************************;

/* original program from scratch */

proc freq data = sashelp.stocks;
	tables date;
	format date year4.;
run;

proc sort data = sashelp.stocks out=stocks;
	by Stock Date;
run;

data stocks_total;
	set stocks;
	where year(date) = 2005;
	by Stock; /* anytime you use by, there must be an accompanying sort statement */	
	if first.Stock = 1 then YTDVolume = 0;
	YtDVolume + Volume;
run;

*******************************;
* 	  Practice Quiz 4.05	   ;
*******************************;

proc sort data = sashelp.shoes out = shoes;
	by product sales;
run;

data highlow;
	set shoes;
	by product sales;
	if last.product = 1 then Highlow = "High";
	if first.product = 1 then HighLow = "Low";
	if first.product = 1 or last.product = 1;
run;


