%let path = \\toaster\homes\d\h\dhnsingh\nt\ecrb94_ue\ecrb94_ue\ECRB94;

options validvarname=v7;
libname tsa "&path\programs\wk3_tsa_claims_project";

/* reading in csv values */
proc import datafile = "&path\data\TSAClaims2002_2017.csv" 
		out = tsa.claims_raw
		dbms = csv 
		replace;
		getnames = no;
		guessingrows=max;
run;

/* removing header row */
data claims_vars;
	set tsa.claims_raw;
	if VAR6 = "Claim_Type" then delete;
run;

/* renaming variables after unclean read from csv */
data claims_vars;
	set claims_vars (rename = (VAR1=Claim_Number VAR2=Date_Received VAR3=Incident_Date VAR4=Airport_Code VAR5=Airport_Name
									   VAR6=Claim_Type   VAR7=Claim_Site    VAR8=Item_Category VAR9=Close_Amount VAR10=Disposition
									   VAR11=StateName VAR12=State VAR13=County VAR14=City));

run;

/* removing duplicate records */
proc sort data = claims_vars out = claims_nodup
		dupout = claims_duprecs
		nodupkey;
	by claim_number;
run;
	
/* missing values */
data claims_complete;
	set claims_nodup;
	if Claim_Type = "-" or Claim_Type = "" then Claim_Type = "Unknown";
	if Claim_Site = "-" or Claim_Site = "" then Claim_Site = "Unknown";
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
