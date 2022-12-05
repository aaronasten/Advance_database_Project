--SCHEMA CREATION
	--CREATE TABLE CHILD DETAILS
	SELECT  UNIQUEID,
			case 
				when GENDER ='1' then 'Male'
				when GENDER ='2' then 'Female'
			end as GENDER,
			case
			  when ETHNICITY ='1' then 'Kinh'
			  when ETHNICITY ='2' then 'H’Mong'
			  when ETHNICITY ='3' then 'Cham-HRoi'
			  when ETHNICITY ='4' then 'Ede'
			  when ETHNICITY ='5' then 'Ba Na'
			  when ETHNICITY ='6' then 'Nung'
			  when ETHNICITY ='7' then 'Tay'
			  when ETHNICITY ='8' then 'Dao'
			  when ETHNICITY ='9' then 'Giay'
			  when ETHNICITY ='10' then 'Other'
			end as ETHNICITY,
			case 
			  when MOM_EDUC ='0' then 'Never been to school'
			  when MOM_EDUC ='1' then 'Primary school (Grades 1-5)'
			  when MOM_EDUC ='2' then 'Lower secondary school (Grades 6-9)'
			  when MOM_EDUC ='2' then 'Intermediate vocational training'
			  when MOM_EDUC ='2' then 'Upper secondary school (Grades 10)'
			  when MOM_EDUC ='2' then 'Higher education (e.g. university/college) '
			  when MOM_EDUC ='2' then 'Don’t know'
			end as MOM_EDUC,
			case 
			  when DAD_EDUC ='0' then 'Never been to school'
			  when DAD_EDUC ='1' then 'Primary school (Grades 1-5)'
			  when DAD_EDUC ='2' then 'Lower secondary school (Grades 6-9)'
			  when DAD_EDUC ='2' then 'Intermediate vocational training'
			  when DAD_EDUC ='2' then 'Upper secondary school (Grades 10)'
			  when DAD_EDUC ='2' then 'Higher education (e.g. university/college) '
			  when DAD_EDUC ='2' then 'Don’t know'
			end as DAD_EDUC,
			case
			  when STDCMPLT ='1' then 'Respondent absent'
			end as STDCMPLT,
			case
			  when STDLIV ='1' then 'At home with my parents'
			  when STDLIV ='2' then 'With other family or friends'
			  when STDLIV ='3' then 'In a school hostel'
			  when STDLIV ='4' then 'In a private hostel'
			  when STDLIV ='5' then 'Other'
			end as STDLIV
	into childdetails
	FROM dbo.vietnam_wave_1;


	select * from childdetails;

	--CREATE TABLE CHILD HEALTH
	SELECT  UNIQUEID,
			case
			  when STDCMPLT ='1' then 'Respondent absent'
			end as STDCMPLT,
			case 
				when STDMEAL ='1' then '1 Meals'
				when STDMEAL ='2' then '2 Meals'
				when STDMEAL ='3' then '3 or more meals'
			end as STDMEAL,
			case 
				when STDHLTH1 ='0' then 'No'
				when STDHLTH1 ='1' then 'Yes'
			end as STDHLTH1,
			case 
				when STDHLTH2 ='0' then 'No'
				when STDHLTH2 ='1' then 'Yes'
			end as STDHLTH2,
			case 
				when STDHLTH3 ='0' then 'No'
				when STDHLTH3 ='1' then 'Yes'
			end as STDHLTH3,
			case 
				when STDHLTH4 ='0' then 'No'
				when STDHLTH4 ='1' then 'Yes'
			end as STDHLTH4,
			case 
				when STDHLTH5 ='0' then 'No'
				when STDHLTH5 ='1' then 'Yes'
			end as STDHLTH5,
			case 
				when STDHLTH6 ='0' then 'No'
				when STDHLTH6 ='1' then 'Yes'
			end as STDHLTH6,
			case 
				when STDHLTH0 ='0' then 'No'
				when STDHLTH0 ='1' then 'Yes'
			end as STDHLTH0
	into childhealth
	FROM dbo.vietnam_wave_1;

	select * from childhealth;

	--CREATE TABLE CHILD HEALTH
	SELECT  UNIQUEID,
			case
			  when STDCMPLT ='1' then 'Respondent absent'
			end as STDCMPLT,
			case 
				when STHVDESK ='0' then 'No'
				when STHVDESK ='1' then 'Yes'
			end as STHVDESK,
			case 
				when STHVCHR ='0' then 'No'
				when STHVCHR ='1' then 'Yes'
			end as STHVCHR,
			case 
				when STHVLAMP ='0' then 'No'
				when STHVLAMP ='1' then 'Yes'
			end as STHVLAMP,
			case 
				when STHVCOMP ='0' then 'No'
				when STHVCOMP ='1' then 'Yes'
			end as STHVCOMP,
			case 
				when STHVINTR ='0' then 'No'
				when STHVINTR ='1' then 'Yes'
			end as STHVINTR
	into childaccessto_usefulitems
	FROM dbo.vietnam_wave_1;

	select * from childaccessto_usefulitems;

	--CREATE TABLE CHILD EDU
	SELECT  UNIQUEID,
			case
			  when STDCMPLT ='1' then 'Respondent absent'
			end as STDCMPLT,
			case 
				when STRPTCL1 ='0' then 'No, never'
				when STRPTCL1 ='1' then 'Yes, once'
				when STRPTCL1 ='1' then 'Yes, twice or more'
			end as STRPTCL1,
			case 
				when STRPTCL6 ='0' then 'No, never'
				when STRPTCL6 ='1' then 'Yes, once'
				when STRPTCL6 ='1' then 'Yes, twice or more'
			end as STRPTCL6,
			case 
				when STRPTCL10 ='0' then 'No, never'
				when STRPTCL10 ='1' then 'Yes, once'
				when STRPTCL10 ='1' then 'Yes, twice or more'
			end as STRPTCL10
	into child_edu
	FROM dbo.vietnam_wave_1;

	select * from child_edu;

	--CREATE TABLE CHILD HEALTH
	SELECT  UNIQUEID,
			case 
				when STRSNMS1 ='0' then 'No'
				when STRSNMS1 ='1' then 'Yes'
			end as STRSNMS1,
			case 
				when STRSNMS2 ='0' then 'No'
				when STRSNMS2 ='1' then 'Yes'
			end as STHVCHR,
			case 
				when STRSNMS3 ='0' then 'No'
				when STRSNMS3 ='1' then 'Yes'
			end as STRSNMS3,
			case 
				when STRSNMS4 ='0' then 'No'
				when STRSNMS4 ='1' then 'Yes'
			end as STRSNMS4,
			case 
				when STRSNMS5 ='0' then 'No'
				when STRSNMS5 ='1' then 'Yes'
			end as STRSNMS5
	into child_schooldetails
	FROM dbo.vietnam_wave_2;

	select * from child_schooldetails;

	--creating a procedure for making unique ID column not null
	CREATE or alter PROCEDURE notnull @table nVarchar(50)
		AS
		begin
			declare @abc nvarchar(100);
				set @abc='ALTER TABLE '+@table+' ALTER COLUMN UNIQUEID varchar(50) NOT NULL;';
			exec (@abc);
		end;
	--making unique ID columsn not null using the procedure created
	exec notnull @table='childdetails';
	exec notnull @table='childhealth';
	exec notnull @table='childaccessto_usefulitems';
	exec notnull @table='child_edu';
	exec notnull @table='child_schooldetails';

	--adding primary key to childdetails
	ALTER TABLE childdetails ADD PRIMARY KEY(UNIQUEID)

	--creating procedure for making foreign kekys in a table
	CREATE or alter PROCEDURE foreignkey @table nVarchar(50)
		AS
		begin
			declare @abc nvarchar(100);
				set @abc='ALTER TABLE '+@table+' ADD FOREIGN KEY (UNIQUEID) REFERENCES childdetails(UNIQUEID);';
			exec (@abc);
		end;
	--adding foreign keys to tables using the procedure created
	exec foreignkey @table='childhealth';
	exec foreignkey @table='childaccessto_usefulitems';
	exec foreignkey @table='child_edu';
	exec foreignkey @table='child_schooldetails';


/*
drop table childhealth;
drop table childdetails;
drop table childaccessto_usefulitems;
drop table child_edu;
drop table child_schooldetails;*/