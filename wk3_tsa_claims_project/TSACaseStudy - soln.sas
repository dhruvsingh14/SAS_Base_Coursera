%let path = C:\Users\dhnsingh\Documents\ecrb94_ue\ECRB94;

libname tsa "&path\programs\wk3_tsa_claims_project";
options validvarname=v7;

/* reading in csv values */
proc import datafile = "&path\data\TSAClaims2002_2017.csv" 
		dbms = csv
		out = claims_raw		 
		replace;
	guessingrows=max;
run;

/* exploratory */
proc print data = claims_raw (obs= 20);
run;

proc contents data = claims_raw varnum;
run;

proc freq data = claims_raw;
	tables claim_site
			disposition
			claim_type
			date_received
			incident_date / nocum nopercent;
	format incident_date date_received year4.; /* key hack to grouping date by year */
run;

proc print data = claims_raw;
	where date_received < incident_date;
	format date_received incident_date date9.;
run;


/* removing duplicate records */
proc sort data = claims_raw 
		out = claims_nodup noduprecs;
	by _all_; /* sorting by all sorts on all columns, so dups are adjacent */
run;
	
proc sort data = claims_nodup;
	by incident_date;
run;

/* missing values */
data tsa.claims_cleaned;
	set claims_nodup;
/* claim_site column */
	if Claim_Site in ("-", "") then Claim_Site = "Unknown";
/* disposition column */
	if disposition in ("-", "") then disposition = "Unknown";
	else if disposition = "losed: Contractor Claim" then disposition = "Closed:Contractor Claim";
	else if disposition = "Closed: Canceled" then disposition = "Closed:Canceled";
/* claim_type column */
	if claim_type in ("-", "") then claim_type = "Unknown";
	else if claim_type = "Passenger Property Loss/Personal Injur" then claim_type = "Passenger Property Loss";
	else if claim_type = "Passenger Property Loss/Personal Injury" then claim_type = "Passenger Property Loss";
	else if claim_type = "Property Damage/Personal Injury" then claim_type = "Property Damage";
/* case change */
	State = upcase(State);
	Statename = propcase(Statename);
/* date issues */
	if (Incident_date > Date_received or
		date_received = . or
		incident_date = . or 
		year(incident_date) < 2002 or
		year(incident_date) > 2017 or
		year(date_received) < 2002 or
		year(date_received) > 2017) then Date_Issues = "Needs Review";
/* labels and formats */
	format incident_date date_received date9. close_amount dollar20.2;
	label Airport_Code = "Airport Code"
		Airport_Name = "Airport Name"
		Claim_Number = "Claim Number"
		Claim_Site = "Claim Site"
		Claim_Type = "Claim Type"
		Close_Amount = "Close Amount"
		Date_Issues = "Date Issues"
		Date_Received = "Date Received"
		Incident_Date = "Incident Date"
		Item_Category = "Item Category";
/* dropping vars */
		drop county city;
run;
