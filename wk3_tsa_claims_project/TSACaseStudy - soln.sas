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
	
	
	if Claim_Type = "-" or Claim_Type = "" then Claim_Type = "Unknown";
	
	if Disposition = "-" or Disposition = "" then Disposition = "Unknown";
run;

/* unique values for claim_type,  claim_site, disposition*/
proc sql;
	select distinct(claim_type) as uClaim_Type from claims_complete; 
	select distinct(claim_site) as uClaim_Site from claims_complete; 
	select distinct(disposition) as uDisposition from claims_complete;
run;

/* splitting claim type column by slash, replacing spaces and truncations to standardize */
data claims_unique;
	set claims_complete;
	claim_type = scan(claim_type, 1, '/');
	disposition = tranwrd(disposition, "losed: Contractor ", "Closed:Contractor ");
	disposition = tranwrd(disposition, ": ", ":");
run;

proc sql;
	select distinct(claim_type) as uClaim_Type from claims_unique; 
	select distinct(claim_site) as uClaim_Site from claims_unique; 
	select distinct(disposition) as uDisposition from claims_unique;
run;
