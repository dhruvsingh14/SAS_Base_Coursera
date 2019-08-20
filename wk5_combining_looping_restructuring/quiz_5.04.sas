%let path = C:\Users\dhnsingh\Documents\ECRB94;
libname cr "&path\data";

*******************************;
* 	  Practice Quiz 5.04	   ;
*******************************;

data shoes_future;
	set cr.shoes_summary;
	drop totalstores totalprofit;
run;


data shoes_future;
	Year = 0;
	set cr.shoes_summary;
	do Year = 1 to 5;
		profitperstore + (profitperstore*0.03);
		output;
	end;
	drop totalstores totalprofit;
run;

*******************************;
* 	  Practice Quiz 5.05	   ;
*******************************;

data future_expenses;
   format Wages Retire Medical TotalCost comma15.;
   Wages=12874000;
   Retire=1765000;
   Medical=649000;
   Year=0;
   TotalCost = 0;
   do Year = 1 to 10;
   		Wages + (Wages*0.06);
	    Retire + (Retire*0.014);
   		Medical + (Medical*0.095);
		TotalCost = Wages + Retire + Medical;
		output;
   end;
run;


*******************************;
* 	  Practice Quiz 5.06	   ;
*******************************;

* code completion exercise;

data income_expenses;
	Wages=12874000;
	Retire=1765000;
	Medical=649000;
	Income=50000000;
	Year=0;
	do until (TotalCost > Income );
		Year + 1;
		Wages=Wages*1.06;
		Retire=Retire*1.014;
		Medical=Medical *1.095;
		Income=Income *1.01;
		TotalCost=sum(Wages, Retire, Medical);
		output;
	end;
	keep Year TotalCost;
	format TotalCost comma12.;
run;
