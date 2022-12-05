--create a table containing country info
	CREATE TABLE country(
		countryid NUMERIC not null,
		countryname VARCHAR(15),
		PRIMARY KEY(countryid));

--inserting country values into table
	INSERT INTO country values
		(1,'Ethiopia'),
		(2,'India'),
		(3,'Peru'),
		(4,'Vietnam');

--displyaing the vlaues of country table
	SELECT * FROM country;

--INDIA

	-- creating table child_details from already existing INDIAN database
		SELECT distinct(childid),
		case 
		  when chsex ='1' then 'male'
		  when chsex ='2' then 'female'
		  end as chsex,
		case 
		  when chlang ='99' then 'missing'
		  when chlang ='10' then 'other'
		  when chlang ='77' then 'nk'
		  when chlang ='79' then 'refused to answer'
		  when chlang ='24' then 'oria'
		  when chlang ='21' then 'telugu'
		  when chlang ='22' then 'hindi'
		  when chlang ='23' then 'urdu'
		  when chlang ='88' then 'n/a'
		  when chlang ='25' then 'kannada'
		  when chlang ='26' then 'marati'
		  when chlang ='27' then 'tamil'
		  when chlang ='28' then 'local dialect'
		  end as chlang
		into child_details_in
		FROM dbo.india_constructed;

	--making childid notnull and then the primary key
		ALTER TABLE child_details_in ALTER COLUMN childid VARCHAR(50) NOT NULL;
		ALTER TABLE child_details_in ADD PRIMARY KEY(childid);

	--adding country id to the table child_details
		ALTER TABLE child_details_in
		ADD country_id numeric,
		FOREIGN KEY(country_id) REFERENCES country(countryid);

		Select * from child_details_in;

	--updating country_id values
		UPDATE child_details_in
		SET country_id = 2
		WHERE childid like'IN%';

	--adding alive/dead status to the child_details table
		CREATE VIEW partition_india AS
		select childid,roundnumber,deceased,
		count(1) over (partition by childid) as number_of_rounds
		from dbo.india_constructed
		where deceased='1'

		select * from partition_india

		CREATE VIEW round_deceased_in AS
		select distinct(childid),(5-number_of_rounds) as round_died_in
		from partition_india
		where deceased='1'

		select * from round_deceased;

		ALTER TABLE child_details_in
		ADD deceased_round varchar(3);

		UPDATE child_details_in
		SET deceased_round =(
		SELECT round_died_in
		FROM round_deceased_in
		WHERE round_deceased_in.childid = child_details_in.childid);

		select * from child_details_in

		ALTER TABLE child_details_in
		ADD alive varchar(3);

		update child_details_in
		set alive='yes' where deceased_round is null

		update child_details_in
		set alive='no' where deceased_round is not null


	--creating table child_caregiver_chara from already existing INDIAN database
		SELECT	childid,
				roundnumber,
				dadage,
				dadyrdied,
				case 
				  when dadedu ='0' then 'None'
				  when dadedu ='1' then 'Grade 1'
				  when dadedu ='2' then 'Grade 2'
				  when dadedu ='3' then 'Grade 3'
				  when dadedu ='4' then 'Grade 4'
				  when dadedu ='5' then 'Grade 5'
				  when dadedu ='6' then 'Grade 6'
				  when dadedu ='7' then 'Grade 7'
				  when dadedu ='8' then 'Grade 8'
				  when dadedu ='9' then 'Grade 9'
				  when dadedu ='10' then 'Grade 10'
				  when dadedu ='11' then 'Grade 11'
				  when dadedu ='12' then 'Grade 12'
				  when dadedu ='13' then 'Vocational, technical college'
				  when dadedu ='14' then 'University'
				  when dadedu ='15' then 'Masters, doctorate'
				  when dadedu ='28' then 'Adult literacy'
				  when dadedu ='29' then 'Religious education'
				  when dadedu ='30' then 'Other'
				end as dadedu,
				momage,
				momyrdied,
				case 
				  when momedu ='0' then 'None'
				  when momedu ='1' then 'Grade 1'
				  when momedu ='2' then 'Grade 2'
				  when momedu ='3' then 'Grade 3'
				  when momedu ='4' then 'Grade 4'
				  when momedu ='5' then 'Grade 5'
				  when momedu ='6' then 'Grade 6'
				  when momedu ='7' then 'Grade 7'
				  when momedu ='8' then 'Grade 8'
				  when momedu ='9' then 'Grade 9'
				  when momedu ='10' then 'Grade 10'
				  when momedu ='11' then 'Grade 11'
				  when momedu ='12' then 'Grade 12'
				  when momedu ='13' then 'Vocational, technical college'
				  when momedu ='14' then 'University'
				  when momedu ='15' then 'Masters, doctorate'
				  when momedu ='28' then 'Adult literacy'
				  when momedu ='29' then 'Religious education'
				  when momedu ='30' then 'Other'
				end as momedu,
				careage,
				caresex,
				case 
				  when carerel ='0' then 'YL child'
				  when carerel ='1' then 'Biological parent'
				  when carerel ='2' then 'Non-biological parent'
				  when carerel ='3' then 'Grandparent'
				  when carerel ='4' then 'Uncle/aunt'
				  when carerel ='5' then 'Sibling'
				  when carerel ='6' then 'Other-relative'
				  when carerel ='7' then 'Other-nonrelative'
				  when carerel ='8' then 'Partner/spouse of YL child'
				  when carerel ='9' then 'Father-in-law/mother-in-law'
				end as carerel,
				case 
				  when caredu ='0' then 'None'
				  when caredu ='1' then 'Grade 1'
				  when caredu ='2' then 'Grade 2'
				  when caredu ='3' then 'Grade 3'
				  when caredu ='4' then 'Grade 4'
				  when caredu ='5' then 'Grade 5'
				  when caredu ='6' then 'Grade 6'
				  when caredu ='7' then 'Grade 7'
				  when caredu ='8' then 'Grade 8'
				  when caredu ='9' then 'Grade 9'
				  when caredu ='10' then 'Grade 10'
				  when caredu ='11' then 'Grade 11'
				  when caredu ='12' then 'Grade 12'
				  when caredu ='13' then 'Vocational, technical college'
				  when caredu ='14' then 'University'
				  when caredu ='15' then 'Masters, doctorate'
				  when caredu ='28' then 'Adult literacy'
				  when caredu ='29' then 'Religious education'
				  when caredu ='30' then 'Other'
				end as caredu
		into child_caregiver_chara_in
		FROM dbo.india_constructed

		select * from child_caregiver_chara_in

	--creating table child_education from already existing INDIAN database
		SELECT	childid,
				roundnumber,
				case 
				  when preprim ='0' then 'No'
				  when preprim ='1' then 'Yes'
				end as preprim,
				agegr1,
				case 
				  when enrol ='0' then 'No'
				  when enrol ='1' then 'Yes'
				  when enrol ='99' then 'missing'
				  when enrol ='77' then 'nk'
				  when enrol ='88' then 'n/a'
				end as enrol,
				case 
				  when engrade ='0' then 'None'
				  when engrade ='1' then 'Grade 01'
				  when engrade ='2' then 'Grade 02'
				  when engrade ='3' then 'Grade 03'
				  when engrade ='4' then 'Grade 04'
				  when engrade ='5' then 'Grade 05'
				  when engrade ='6' then 'Grade 06'
				  when engrade ='7' then 'Grade 07'
				  when engrade ='8' then 'Grade 08'
				  when engrade ='9' then 'Grade 09'
				  when engrade ='10' then 'Grade 10'
				  when engrade ='11' then 'Grade 11'
				  when engrade ='12' then 'Grade 12'
				  when engrade ='13' then 'Post-secondary / technological institute'
				  when engrade ='14' then 'Vocational'
				  when engrade ='15' then 'University degree (graduate)'
				  when engrade ='16' then 'University degree (postgraduate)'
				  when engrade ='100' then 'Pre-primary'
				  when engrade ='28' then 'Adult literacy'
				  when engrade ='29' then 'Religious education'
				  when engrade ='77' then 'NK'
				end as engrade,
				case 
				  when entype ='1' then 'private'
				  when entype ='2' then 'ngo/charity/religious (not-for-profit)'
				  when entype ='3' then 'public (government)'
				  when entype ='4' then 'informal or non-formal community'
				  when entype ='5' then 'vocational school'
				  when entype ='6' then 'charitable trust'
				  when entype ='7' then 'bridge school'
				  when entype ='8' then 'mix of public and pirvate'
				  when entype ='9' then 'branch school'
				  when entype ='10' then 'main school'
				  when entype ='11' then 'other'
				  when entype ='77' then 'nk'
				  when entype ='99' then 'missing'
				  when entype ='88' then 'n/a'
				end as entype,
				case 
				  when hghgrade ='0' then 'None'
				  when hghgrade ='1' then 'Grade 1'
				  when hghgrade ='2' then 'Grade 2'
				  when hghgrade ='3' then 'Grade 3'
				  when hghgrade ='4' then 'Grade 4'
				  when hghgrade ='5' then 'Grade 5'
				  when hghgrade ='6' then 'Grade 6'
				  when hghgrade ='7' then 'Grade 7'
				  when hghgrade ='8' then 'Grade 8'
				  when hghgrade ='9' then 'Grade 9'
				  when hghgrade ='10' then 'Grade 10'
				  when hghgrade ='11' then 'Grade 11'
				  when hghgrade ='12' then 'Grade 12'
				  when hghgrade ='13' then 'Vocational, technical college'
				  when hghgrade ='14' then 'University'
				  when hghgrade ='15' then 'Masters, doctorate'
				  when hghgrade ='28' then 'Adult literacy'
				  when hghgrade ='29' then 'Religious education'
				  when hghgrade ='30' then 'Other'
				end as hghgrade,
				timesch,
				case 
				  when levlread ='1' then 'cant read anything'
				  when levlread ='2' then 'reads letters'
				  when levlread ='3' then 'reads word'
				  when levlread ='4' then 'reads sentence'
				end as levlread,
				case 
				  when levlwrit ='1' then 'no'
				  when levlwrit ='2' then 'yes with difficulty or errors'
				  when levlwrit ='3' then ' yes without difficulty or errors'
				end as levlwrit,
				case 
				  when literate ='0' then 'no'
				  when literate ='1' then 'yes'
				end as literate
		into child_education_in
		FROM dbo.india_constructed

		select * from child_education_in order by childid

	--creating table child_health from already existing INDIAN database
		SELECT  childid,
				roundnumber,
				chweight,
				chheight,
				chhealth,
				bmi,
				case 
				  when underweight ='0' then 'not underweight'
				  when underweight ='1' then 'moderately underweight'
				  when underweight ='2' then 'severely underweight'
				end as underweight,
				case 
				  when stunting ='0' then 'not stunted'
				  when stunting ='1' then 'moderately stunted'
				  when stunting ='2' then 'severely stunted'
				end as stunting,
				case 
				  when thinness ='0' then 'not thin'
				  when thinness ='1' then 'moderately thin'
				  when thinness ='2' then 'severely thin'
				end as thinness
		into child_health_in
		FROM dbo.india_constructed

		select * from child_health_in order by childid

	--creating table child_basicaminities from already existing INDIAN database
		SELECT childid,
			roundnumber,
			case 
				  when drwaterq ='0' then 'no'
				  when drwaterq ='1' then 'yes'
			end as drwaterq,
			case 
				  when toiletq ='0' then 'no'
				  when toiletq ='1' then 'yes'
			end as toiletq,
			case 
				  when elecq ='0' then 'no'
				  when elecq ='1' then 'yes'
			end as	elecq,
			case 
				  when cookingq ='0' then 'no'
				  when cookingq ='1' then 'yes'
			end as cookingq
		into child_basicaminities_in
		FROM dbo.india_constructed

		select * from child_basicaminities_in order by childid

	--creating table child_householddetails from already existing INDIAN database
		SELECT childid,
			roundnumber,
			case 
				when headedu ='0' then 'None'
				when headedu ='1' then 'Grade 1'
				when headedu ='2' then 'Grade 2'
				when headedu ='3' then 'Grade 3'
				when headedu ='4' then 'Grade 4'
				when headedu ='5' then 'Grade 5'
				when headedu ='6' then 'Grade 6'
				when headedu ='7' then 'Grade 7'
				when headedu ='8' then 'Grade 8'
				when headedu ='9' then 'Grade 9'
				when headedu ='10' then 'Grade 10'
				when headedu ='11' then 'Grade 11'
				when headedu ='12' then 'Grade 12'
				when headedu ='13' then 'Vocational, technical college'
				when headedu ='14' then 'University'
				when headedu ='15' then 'Masters, doctorate'
				when headedu ='28' then 'Adult literacy'
				when headedu ='29' then 'Religious education'
				when headedu ='30' then 'Other'
			end as headedu,
			headage,
			case 
				when headsex ='0' then 'male'
				when headsex ='1' then 'female'
			end as headsex,
			case 
				when headrel ='0' then 'YL child'
				when headrel ='1' then 'Biological parent'
				when headrel ='2' then 'Non-biological parent'
				when headrel ='3' then 'Grandparent'
				when headrel ='4' then 'Uncle/aunt'
				when headrel ='5' then 'Sibling'
				when headrel ='6' then 'Other-relative'
				when headrel ='7' then 'Other-nonrelative'
				when headrel ='8' then 'Partner/spouse of YL child'
				when headrel ='9' then 'Father-in-law/mother-in-law'
			end as headrel,
			hhsize,
			wi as wealth_index,
			hq as housing_quality 
		into child_householddetails_in
		FROM dbo.india_constructed

		select * from child_householddetails_in order by childid

	--linking tables using childid
		CREATE or alter PROCEDURE foreignkey_in @table nVarchar(50)
		AS
		begin
			declare @abc nvarchar(100);
				set @abc='ALTER TABLE '+@table+' ADD FOREIGN KEY (childid) REFERENCES child_details_in(childid);';
			exec (@abc);
		end;

		exec foreignkey_in @table='child_health_in';
		exec foreignkey_in @table='child_education_in';
		exec foreignkey_in @table='child_basicaminities_in';
		exec foreignkey_in @table='child_caregiver_chara_in';
		exec foreignkey_in @table='child_householddetails_in';


	--creating composite primary key in all tables
	   CREATE or alter PROCEDURE notnull_in @table nVarchar(50)
		AS
		begin
			declare @abc nvarchar(200);
				set @abc='ALTER TABLE '+@table+'
							ALTER COLUMN childid varchar(50) NOT NULL;
							ALTER TABLE '+@table+'
							ALTER COLUMN roundnumber varchar(50) NOT NULL;';
			exec (@abc);
		end;

		exec notnull_in @table='child_health_in';
		exec notnull_in @table='child_education_in';
		exec notnull_in @table='child_basicaminities_in';
		exec notnull_in @table='child_caregiver_chara_in';
		exec notnull_in @table='child_householddetails_in';

	--procedure for making primary key.
		CREATE or alter PROCEDURE primary_in @table nVarchar(50)
		AS
		begin
			declare @abc nvarchar(200);
				set @abc='ALTER TABLE '+@table+' ADD PRIMARY KEY(childid, roundnumber);';
			exec (@abc);
		end;

		exec primary_in @table='child_health_in';
		exec primary_in @table='child_education_in';
		exec primary_in @table='child_basicaminities_in';
		exec primary_in @table='child_caregiver_chara_in';
		exec primary_in @table='child_householddetails_in';

--ETHIOPIA

	-- creating table child_details from already existing ETIOPIAN database
		SELECT distinct(childid),
		case 
		  when chsex ='1' then 'male'
		  when chsex ='2' then 'female'
		  end as chsex,
		case 
		  when chlang ='1' then 'afarigna'
		  when chlang ='2' then 'amarigna'
		  when chlang ='3' then 'agewigna'
		  when chlang ='4' then 'dawerogna'
		  when chlang ='5' then 'gedeogna'
		  when chlang ='6' then 'guraghigna'
		  when chlang ='7' then 'hadiyigna'
		  when chlang ='8' then 'harari'
		  when chlang ='9' then 'kefigna'
		  when chlang ='10' then 'kembategna'
		  when chlang ='11' then 'oromifa'
		  when chlang ='12' then 'sidamigna'
		  when chlang ='13' then 'siltigna'
		  when chlang ='14' then 'somaligna'
		  when chlang ='15' then 'tigrigna'
		  when chlang ='16' then 'welayitegna'
		  when chlang ='17' then 'zayigna'
		  when chlang ='20' then 'other'
		  when chlang ='88' then 'n/a'
		  when chlang ='79' then 'refused to answer'
		  when chlang ='99' then 'missing'
		  when chlang ='77' then 'nk'
		end as chlang
		into child_details_et
		FROM dbo.ethiopia_constructed;

	--making childid notnull and then the primary key
		ALTER TABLE child_details_et ALTER COLUMN childid VARCHAR(50) NOT NULL;
		ALTER TABLE child_details_et ADD PRIMARY KEY(childid);

	--adding country id to the table child_details
		ALTER TABLE child_details_et
		ADD country_id numeric,
		FOREIGN KEY(country_id) REFERENCES country(countryid);

		Select * from child_details_et;

	--updating country_id values
		UPDATE child_details_et
		SET country_id = 1
		WHERE childid like'ET%';

	--adding alive/dead status to the child_details table
		CREATE VIEW partition_ethiopia AS
		select childid,roundnumber,deceased,
		count(1) over (partition by childid) as number_of_rounds
		from dbo.ethiopia_constructed
		where deceased='1'

		select * from partition_ethiopia

		CREATE VIEW round_deceased_et AS
		select distinct(childid),(5-number_of_rounds) as round_died_in
		from partition_ethiopia
		where deceased='1'

		select * from round_deceased_et;

		ALTER TABLE child_details_et
		ADD deceased_round varchar(3);

		UPDATE child_details_et
		SET deceased_round =(
		SELECT round_died_in
		FROM round_deceased_et
		WHERE round_deceased_et.childid = child_details_et.childid);

		select * from child_details_et

		ALTER TABLE child_details_et
		ADD alive varchar(3);

		update child_details_et
		set alive='yes' where deceased_round is null

		update child_details_et
		set alive='no' where deceased_round is not null


	--creating table child_caregiver_chara from already existing ETIOPIAN database
		SELECT	childid,
				roundnumber,
				dadage,
				dadyrdied,
				case 
				  when dadedu ='0' then 'None'
				  when dadedu ='1' then 'Grade 1'
				  when dadedu ='2' then 'Grade 2'
				  when dadedu ='3' then 'Grade 3'
				  when dadedu ='4' then 'Grade 4'
				  when dadedu ='5' then 'Grade 5'
				  when dadedu ='6' then 'Grade 6'
				  when dadedu ='7' then 'Grade 7'
				  when dadedu ='8' then 'Grade 8'
				  when dadedu ='9' then 'Grade 9'
				  when dadedu ='10' then 'Grade 10'
				  when dadedu ='11' then 'Grade 11'
				  when dadedu ='12' then 'Grade 12'
				  when dadedu ='13' then 'Vocational, technical college'
				  when dadedu ='14' then 'University'
				  when dadedu ='15' then 'Masters, doctorate'
				  when dadedu ='28' then 'Adult literacy'
				  when dadedu ='29' then 'Religious education'
				  when dadedu ='30' then 'Other'
				end as dadedu,
				momage,
				momyrdied,
				case 
				  when momedu ='0' then 'None'
				  when momedu ='1' then 'Grade 1'
				  when momedu ='2' then 'Grade 2'
				  when momedu ='3' then 'Grade 3'
				  when momedu ='4' then 'Grade 4'
				  when momedu ='5' then 'Grade 5'
				  when momedu ='6' then 'Grade 6'
				  when momedu ='7' then 'Grade 7'
				  when momedu ='8' then 'Grade 8'
				  when momedu ='9' then 'Grade 9'
				  when momedu ='10' then 'Grade 10'
				  when momedu ='11' then 'Grade 11'
				  when momedu ='12' then 'Grade 12'
				  when momedu ='13' then 'Vocational, technical college'
				  when momedu ='14' then 'University'
				  when momedu ='15' then 'Masters, doctorate'
				  when momedu ='28' then 'Adult literacy'
				  when momedu ='29' then 'Religious education'
				  when momedu ='30' then 'Other'
				end as momedu,
				careage,
				caresex,
				case 
				  when carerel ='0' then 'YL child'
				  when carerel ='1' then 'Biological parent'
				  when carerel ='2' then 'Non-biological parent'
				  when carerel ='3' then 'Grandparent'
				  when carerel ='4' then 'Uncle/aunt'
				  when carerel ='5' then 'Sibling'
				  when carerel ='6' then 'Other-relative'
				  when carerel ='7' then 'Other-nonrelative'
				  when carerel ='8' then 'Partner/spouse of YL child'
				  when carerel ='9' then 'Father-in-law/mother-in-law'
				end as carerel,
				case 
				  when caredu ='0' then 'None'
				  when caredu ='1' then 'Grade 1'
				  when caredu ='2' then 'Grade 2'
				  when caredu ='3' then 'Grade 3'
				  when caredu ='4' then 'Grade 4'
				  when caredu ='5' then 'Grade 5'
				  when caredu ='6' then 'Grade 6'
				  when caredu ='7' then 'Grade 7'
				  when caredu ='8' then 'Grade 8'
				  when caredu ='9' then 'Grade 9'
				  when caredu ='10' then 'Grade 10'
				  when caredu ='11' then 'Grade 11'
				  when caredu ='12' then 'Grade 12'
				  when caredu ='13' then 'Vocational, technical college'
				  when caredu ='14' then 'University'
				  when caredu ='15' then 'Masters, doctorate'
				  when caredu ='28' then 'Adult literacy'
				  when caredu ='29' then 'Religious education'
				  when caredu ='30' then 'Other'
				end as caredu
		into child_caregiver_chara_et
		FROM dbo.ethiopia_constructed

		select * from child_caregiver_chara_et

	--creating table child_education from already existing ETIOPIAN database
		SELECT	childid,
				roundnumber,
				case 
				  when preprim ='0' then 'No'
				  when preprim ='1' then 'Yes'
				end as preprim,
				agegr1,
				case 
				  when enrol ='0' then 'No'
				  when enrol ='1' then 'Yes'
				  when enrol ='99' then 'missing'
				  when enrol ='77' then 'nk'
				  when enrol ='88' then 'n/a'
				end as enrol,
				case 
				  when engrade ='0' then 'None'
				  when engrade ='1' then 'Grade 01'
				  when engrade ='2' then 'Grade 02'
				  when engrade ='3' then 'Grade 03'
				  when engrade ='4' then 'Grade 04'
				  when engrade ='5' then 'Grade 05'
				  when engrade ='6' then 'Grade 06'
				  when engrade ='7' then 'Grade 07'
				  when engrade ='8' then 'Grade 08'
				  when engrade ='9' then 'Grade 09'
				  when engrade ='10' then 'Grade 10'
				  when engrade ='11' then 'Grade 11(Secondary Second Cycle Preparatory Programme)'
				  when engrade ='12' then 'Grade 12 (Secondary Second Cycle Preparatory Programme)'
				  when engrade ='13' then 'First cycle of primary teaching certificate (grade 1-4)/1st year'
				  when engrade ='14' then 'First cycle of primary teaching certificate (grade 1-4)/2nd year'
				  when engrade ='16' then 'Second cycle of primary teaching certificate (grades 5-8)/2nd year)'
				  when engrade ='17' then 'Second cycle of primary teaching certificate (grades 5-8)/1st year'
				  when engrade ='21' then 'TVET/1st year/level (include diplomas such as accounting diploma)'
				  when engrade ='22' then 'TVET/2nd year/level (include diplomas such as accounting diploma)'
				  when engrade ='23' then 'TVET/3rd year/level (include diplomas such as accounting diploma)'
				  when engrade ='24' then 'TVET/4rd year/level (include diplomas such as accounting diploma)'
				  when engrade ='25' then 'Secondary education, teacher (diploma holder)/1st year'
				  when engrade ='26' then 'Secondary education, teacher (diploma holder)/2nd year'
				  when engrade ='27' then 'Secondary education, teacher (bachelors degree holder and above)/1st year'
				  when engrade ='28' then 'Secondary education, teacher (bachelors degree holder and above)/2nd year'
				  when engrade ='29' then 'Secondary education, teacher (bachelors degree holder and above)/3rd year'
				  when engrade ='31' then 'Preschool teacher certificate (6 months to one year)'
				  when engrade ='32' then 'Undergraduate degree (1st year, regular (R))'
				  when engrade ='33' then 'Undergraduate degree (2nd year, regular (R))'
				  when engrade ='34' then 'Undergraduate degree (3rd year, regular (R))'
				  when engrade ='35' then 'Undergraduate degree (4th year, regular (R))'
				  when engrade ='36' then 'Undergraduate degree (1st year or equivalent, non-regular (NR), summer/distant/evening/weekend student)'
				  when engrade ='37' then 'Undergraduate degree (2nd year or equivalent, non-regular (NR), summer/distant/evening/weekend student)'
				  when engrade ='38' then 'Undergraduate degree (3rd year or equivalent, non-regular (NR), summer/distant/evening/weekend student)'
				  when engrade ='39' then 'Undergraduate degree (4th year or equivalent, non-regular (NR), summer/distant/evening/weekend student)
'
				  when engrade ='40' then 'Masters or doctoral at university'
				  when engrade ='41' then 'Others'
				  when engrade ='77' then 'nk'
				  when engrade ='79' then 'Refused to answer'
				  when engrade ='88' then 'None'
				  when engrade ='100' then 'Pre-primary'
				end as engrade,
				case 
				  when entype ='1' then 'private'
				  when entype ='2' then 'Public (part student fees, part government funded)'
				  when entype ='3' then 'Community (NGO/Charity/Religious)'
				  when entype ='4' then 'Government funded'
				  when entype ='5' then 'Others'
				  when entype ='77' then 'nk'
				  when entype ='79' then 'Refused to answer'
				  when entype ='88' then 'n/a'
				end as entype,
				case 
				  when hghgrade ='0' then 'None'
				  when hghgrade ='1' then 'Grade 1'
				  when hghgrade ='2' then 'Grade 2'
				  when hghgrade ='3' then 'Grade 3'
				  when hghgrade ='4' then 'Grade 4'
				  when hghgrade ='5' then 'Grade 5'
				  when hghgrade ='6' then 'Grade 6'
				  when hghgrade ='7' then 'Grade 7'
				  when hghgrade ='8' then 'Grade 8'
				  when hghgrade ='9' then 'Grade 9'
				  when hghgrade ='10' then 'Grade 10'
				  when hghgrade ='11' then 'Grade 11'
				  when hghgrade ='12' then 'Grade 12'
				  when hghgrade ='13' then 'Vocational, technical college'
				  when hghgrade ='14' then 'University'
				  when hghgrade ='15' then 'Masters, doctorate'
				  when hghgrade ='28' then 'Adult literacy'
				  when hghgrade ='29' then 'Religious education'
				  when hghgrade ='30' then 'Other'
				end as hghgrade,
				timesch,
				case 
				  when levlread ='1' then 'cant read anything'
				  when levlread ='2' then 'reads letters'
				  when levlread ='3' then 'reads word'
				  when levlread ='4' then 'reads sentence'
				end as levlread,
				case 
				  when levlwrit ='1' then 'no'
				  when levlwrit ='2' then 'yes with difficulty or errors'
				  when levlwrit ='3' then ' yes without difficulty or errors'
				end as levlwrit,
				case 
				  when literate ='0' then 'no'
				  when literate ='1' then 'yes'
				end as literate
		into child_education_et
		FROM dbo.ethiopia_constructed

		select * from child_education_in order by childid

	--creating table child_health from already existing ETIOPIAN database
		SELECT  childid,
				roundnumber,
				chweight,
				chheight,
				chhealth,
				bmi,
				case 
				  when underweight ='0' then 'not underweight'
				  when underweight ='1' then 'moderately underweight'
				  when underweight ='2' then 'severely underweight'
				end as underweight,
				case 
				  when stunting ='0' then 'not stunted'
				  when stunting ='1' then 'moderately stunted'
				  when stunting ='2' then 'severely stunted'
				end as stunting,
				case 
				  when thinness ='0' then 'not thin'
				  when thinness ='1' then 'moderately thin'
				  when thinness ='2' then 'severely thin'
				end as thinness
		into child_health_et
		FROM dbo.ethiopia_constructed

		select * from child_health_et order by childid

	--creating table child_basicaminities from already existing ETIOPIAN database
		SELECT childid,
			roundnumber,
			case 
				  when drwaterq_new ='0' then 'no'
				  when drwaterq_new ='1' then 'yes'
			end as drwaterq,
			case 
				  when toiletq_new ='0' then 'no'
				  when toiletq_new ='1' then 'yes'
			end as toiletq,
			case 
				  when elecq_new ='0' then 'no'
				  when elecq_new ='1' then 'yes'
			end as	elecq,
			case 
				  when cookingq_new ='0' then 'no'
				  when cookingq_new ='1' then 'yes'
			end as cookingq
		into child_basicaminities_et
		FROM dbo.ethiopia_constructed

		select * from child_basicaminities_et order by childid

	--creating table child_householddetails from already existing ETIOPIAN database
		SELECT childid,
			roundnumber,
			case 
				when headedu ='0' then 'None'
				when headedu ='1' then 'Grade 1'
				when headedu ='2' then 'Grade 2'
				when headedu ='3' then 'Grade 3'
				when headedu ='4' then 'Grade 4'
				when headedu ='5' then 'Grade 5'
				when headedu ='6' then 'Grade 6'
				when headedu ='7' then 'Grade 7'
				when headedu ='8' then 'Grade 8'
				when headedu ='9' then 'Grade 9'
				when headedu ='10' then 'Grade 10'
				when headedu ='11' then 'Grade 11'
				when headedu ='12' then 'Grade 12'
				when headedu ='13' then 'Vocational, technical college'
				when headedu ='14' then 'University'
				when headedu ='15' then 'Masters, doctorate'
				when headedu ='28' then 'Adult literacy'
				when headedu ='29' then 'Religious education'
				when headedu ='30' then 'Other'
			end as headedu,
			headage,
			case 
				when headsex ='1' then 'male'
				when headsex ='2' then 'female'
			end as headsex,
			case 
				when headrel ='0' then 'YL child'
				when headrel ='1' then 'Biological parent'
				when headrel ='2' then 'Non-biological parent'
				when headrel ='3' then 'Grandparent'
				when headrel ='4' then 'Uncle/aunt'
				when headrel ='5' then 'Sibling'
				when headrel ='6' then 'Other-relative'
				when headrel ='7' then 'Other-nonrelative'
				when headrel ='8' then 'Partner/spouse of YL child'
				when headrel ='9' then 'Father-in-law/mother-in-law'
			end as headrel,
			hhsize,
			wi_new as wealth_index,
			hq_new as housing_quality 
		into child_householddetails_et
		FROM dbo.ethiopia_constructed

		select * from child_householddetails_in order by childid

--linking tables using childid
		
		CREATE or alter PROCEDURE foreignkey_et @table nVarchar(50)
		AS
		begin
			declare @abc nvarchar(100);
				set @abc='ALTER TABLE '+@table+' ADD FOREIGN KEY (childid) REFERENCES child_details_et(childid);';
			exec (@abc);
		end;

		exec foreignkey_et @table='child_health_et';
		exec foreignkey_et @table='child_education_et';
		exec foreignkey_et @table='child_basicaminities_et';
		exec foreignkey_et @table='child_caregiver_chara_et';
		exec foreignkey_et @table='child_householddetails_et';

--creating composite primary key in all tables
	   CREATE or alter PROCEDURE notnull_et @table nVarchar(50)
		AS
		begin
			declare @abc nvarchar(200);
				set @abc='ALTER TABLE '+@table+'
							ALTER COLUMN childid varchar(50) NOT NULL;
							ALTER TABLE '+@table+'
							ALTER COLUMN roundnumber varchar(50) NOT NULL;';
			exec (@abc);
		end;

		exec notnull_et @table='child_health_et';
		exec notnull_et @table='child_education_et';
		exec notnull_et @table='child_householddetails_et';
		exec notnull_et @table='child_basicaminities_et';
		exec notnull_et @table='child_caregiver_chara_et';

--procedure for making primary key.
		CREATE or alter PROCEDURE primary_et @table nVarchar(50)
		AS
		begin
			declare @abc nvarchar(100);
				set @abc='ALTER TABLE '+@table+' ADD PRIMARY KEY(childid, roundnumber);';
			exec (@abc);
		end;

		exec primary_et @table='child_health_et';
		exec primary_et @table='child_education_et';
		exec primary_et @table='child_householddetails_et';
		exec primary_et @table='child_basicaminities_et';
		exec primary_et @table='child_caregiver_chara_et';

--PERU

	-- creating table child_details from already existing PERU database
		SELECT distinct(childid),
		case 
		  when chsex ='1' then 'male'
		  when chsex ='2' then 'female'
		  end as chsex,
		case 
		  when chlang ='32' then 'quechua'
		  when chlang ='33' then 'aymara'
		  when chlang ='34' then 'native from jungle'
		  when chlang ='35' then 'spanish & quechua'
		  when chlang ='36' then 'spanish & aymara'
		  when chlang ='37' then 'nomatsiguenga'
		  when chlang ='10' then 'other'
		  when chlang ='77' then 'nk'
		  when chlang ='79' then 'refused to answer'
		  when chlang ='50' then 'mute or difficulty speaking'
		  when chlang ='99' then 'missing'
		  when chlang ='88' then 'n/a'
		  when chlang ='31' then 'spanish'
		  end as chlang
		into child_details_pr
		FROM dbo.peru_constructed;

	--making childid notnull and then the primary key
		ALTER TABLE child_details_pr ALTER COLUMN childid VARCHAR(50) NOT NULL;
		ALTER TABLE child_details_pr ADD PRIMARY KEY(childid);

	--adding country id to the table child_details
		ALTER TABLE child_details_pr
		ADD country_id numeric,
		FOREIGN KEY(country_id) REFERENCES country(countryid);

		Select * from child_details_pr;

	--updating country_id values
		UPDATE child_details_pr
		SET country_id = 3
		WHERE childid like'PE%';

	--adding alive/dead status to the child_details table
		CREATE VIEW partition_peru AS
		select childid,roundnumber,deceased,
		count(1) over (partition by childid) as number_of_rounds
		from dbo.peru_constructed
		where deceased='1'

		select * from partition_india

		CREATE VIEW round_deceased_pr AS
		select distinct(childid),(5-number_of_rounds) as round_died_in
		from partition_peru
		where deceased='1'

		select * from round_deceased;

		ALTER TABLE child_details_pr
		ADD deceased_round varchar(3);

		UPDATE child_details_pr
		SET deceased_round =(
		SELECT round_died_in
		FROM round_deceased_in
		WHERE round_deceased_in.childid = child_details_pr.childid);

		select * from child_details_pr

		ALTER TABLE child_details_pr
		ADD alive varchar(3);

		update child_details_pr
		set alive='yes' where deceased_round is null

		update child_details_pr
		set alive='no' where deceased_round is not null


	--creating table child_caregiver_chara from already existing PERU database
		SELECT	childid,
				roundnumber,
				dadage,
				dadyrdied,
				case 
				  when dadedu ='0' then 'None'
				  when dadedu ='1' then 'Grade 1'
				  when dadedu ='2' then 'Grade 2'
				  when dadedu ='3' then 'Grade 3'
				  when dadedu ='4' then 'Grade 4'
				  when dadedu ='5' then 'Grade 5'
				  when dadedu ='6' then 'Grade 6'
				  when dadedu ='7' then 'Grade 7'
				  when dadedu ='8' then 'Grade 8'
				  when dadedu ='9' then 'Grade 9'
				  when dadedu ='10' then 'Grade 10'
				  when dadedu ='11' then 'Grade 11'
				  when dadedu ='12' then 'Grade 12'
				  when dadedu ='13' then 'Vocational, technical college'
				  when dadedu ='14' then 'University'
				  when dadedu ='15' then 'Masters, doctorate'
				  when dadedu ='28' then 'Adult literacy'
				  when dadedu ='29' then 'Religious education'
				  when dadedu ='30' then 'Other'
				end as dadedu,
				momage,
				momyrdied,
				case 
				  when momedu ='0' then 'None'
				  when momedu ='1' then 'Grade 1'
				  when momedu ='2' then 'Grade 2'
				  when momedu ='3' then 'Grade 3'
				  when momedu ='4' then 'Grade 4'
				  when momedu ='5' then 'Grade 5'
				  when momedu ='6' then 'Grade 6'
				  when momedu ='7' then 'Grade 7'
				  when momedu ='8' then 'Grade 8'
				  when momedu ='9' then 'Grade 9'
				  when momedu ='10' then 'Grade 10'
				  when momedu ='11' then 'Grade 11'
				  when momedu ='12' then 'Grade 12'
				  when momedu ='13' then 'Vocational, technical college'
				  when momedu ='14' then 'University'
				  when momedu ='15' then 'Masters, doctorate'
				  when momedu ='28' then 'Adult literacy'
				  when momedu ='29' then 'Religious education'
				  when momedu ='30' then 'Other'
				end as momedu,
				careage,
				caresex,
				case 
				  when carerel ='0' then 'YL child'
				  when carerel ='1' then 'Biological parent'
				  when carerel ='2' then 'Non-biological parent'
				  when carerel ='3' then 'Grandparent'
				  when carerel ='4' then 'Uncle/aunt'
				  when carerel ='5' then 'Sibling'
				  when carerel ='6' then 'Other-relative'
				  when carerel ='7' then 'Other-nonrelative'
				  when carerel ='8' then 'Partner/spouse of YL child'
				  when carerel ='9' then 'Father-in-law/mother-in-law'
				end as carerel,
				case 
				  when caredu ='0' then 'None'
				  when caredu ='1' then 'Grade 1'
				  when caredu ='2' then 'Grade 2'
				  when caredu ='3' then 'Grade 3'
				  when caredu ='4' then 'Grade 4'
				  when caredu ='5' then 'Grade 5'
				  when caredu ='6' then 'Grade 6'
				  when caredu ='7' then 'Grade 7'
				  when caredu ='8' then 'Grade 8'
				  when caredu ='9' then 'Grade 9'
				  when caredu ='10' then 'Grade 10'
				  when caredu ='11' then 'Grade 11'
				  when caredu ='12' then 'Grade 12'
				  when caredu ='13' then 'Vocational, technical college'
				  when caredu ='14' then 'University'
				  when caredu ='15' then 'Masters, doctorate'
				  when caredu ='28' then 'Adult literacy'
				  when caredu ='29' then 'Religious education'
				  when caredu ='30' then 'Other'
				end as caredu
		into child_caregiver_chara_pr
		FROM dbo.peru_constructed

		select * from child_caregiver_chara_pr

	--creating table child_education from already existing PERU database
		SELECT	childid,
				roundnumber,
				case 
				  when preprim ='0' then 'No'
				  when preprim ='1' then 'Yes'
				end as preprim,
				agegr1,
				case 
				  when enrol ='0' then 'No'
				  when enrol ='1' then 'Yes'
				  when enrol ='99' then 'missing'
				  when enrol ='77' then 'nk'
				  when enrol ='88' then 'n/a'
				end as enrol,
				case 
				  when engrade ='0' then 'None'
				  when engrade ='1' then 'grade 1 (Primary, Grade 1)'
				  when engrade ='2' then 'grade 2 (Primary, Grade 2)'
				  when engrade ='3' then 'grade 3 (Primary, Grade 3)'
				  when engrade ='4' then 'grade 4 (Primary, Grade 4)'
				  when engrade ='5' then 'grade 5 (Primary, Grade 5)'
				  when engrade ='6' then 'grade 6 (Primary, Grade 6)'
				  when engrade ='7' then 'grade 7 (Secondary, Year 1)'
				  when engrade ='8' then 'grade 8 (Secondary, Year 2)'
				  when engrade ='9' then 'grade 9 (Secondary, Year 3)'
				  when engrade ='10' then 'grade 10 (Secondary, Year 4)'
				  when engrade ='11' then 'grade 11 (Secondary, Year 5)'
				  when engrade ='13' then 'Incomplete technical or pedagogical institute'
				  when engrade ='14' then 'Complete technical or pedagogical institute'
				  when engrade ='15' then 'Incomplete university'
				  when engrade ='16' then 'Complete university'
				  when engrade ='17' then 'Adult literacy program'
				  when engrade ='18' then 'Other'
				  when engrade ='19' then 'Masters or doctoral at university'
				  when engrade ='20' then 'Some form of formal or informal preschool'
				  when engrade ='21' then 'Incomplete Cent. Tecnico Productivo CETPRO/ Cent. Edu. Ocupacional CEO'
				  when engrade ='22' then 'Complete Cent. Tecnico Productivo CETPRO/ Cent. Edu. Ocupacional CEO'
				  when engrade ='88' then 'missing'
				  when engrade ='100' then 'Pre-primary'
				  when engrade ='79' then 'n/a'
				  when engrade ='77' then 'nk'
				end as engrade,
				case 
				  when entype ='1' then 'private'
				  when entype ='2' then 'Public'
				  when entype ='3' then 'Half public/half private'
				  when entype ='4' then 'Other'
				  when entype ='88' then 'NA'
				end as entype,
				timesch,
				case 
				  when levlread ='1' then 'cant read anything'
				  when levlread ='2' then 'reads letters'
				  when levlread ='3' then 'reads word'
				  when levlread ='4' then 'reads sentence'
				  when levlread ='79' then 'Refused to answer'
				end as levlread,
				case 
				  when levlwrit ='1' then 'no'
				  when levlwrit ='2' then 'yes with difficulty or errors'
				  when levlwrit ='3' then ' yes without difficulty or errors'
				  when levlwrit ='79' then 'Refused to answer'
				end as levlwrit,
				case 
				  when literate ='0' then 'no'
				  when literate ='1' then 'yes'
				end as literate
		into child_education_pr
		FROM dbo.peru_constructed

		select * from child_education_pr order by childid

	--creating table child_health from already existing PERU database
		SELECT  childid,
				roundnumber,
				chweight,
				chheight,
				chhealth,
				bmi,
				case 
				  when underweight ='0' then 'not underweight'
				  when underweight ='1' then 'moderately underweight'
				  when underweight ='2' then 'severely underweight'
				end as underweight,
				case 
				  when stunting ='0' then 'not stunted'
				  when stunting ='1' then 'moderately stunted'
				  when stunting ='2' then 'severely stunted'
				end as stunting,
				case 
				  when thinness ='0' then 'not thin'
				  when thinness ='1' then 'moderately thin'
				  when thinness ='2' then 'severely thin'
				end as thinness
		into child_health_pr
		FROM dbo.peru_constructed

		select * from child_health_pr order by childid

	--creating table child_basicaminities from already existing PERU database
		SELECT childid,
			roundnumber,
			case 
				  when drwaterq ='0' then 'no'
				  when drwaterq ='1' then 'yes'
			end as drwaterq,
			case 
				  when toiletq ='0' then 'no'
				  when toiletq ='1' then 'yes'
			end as toiletq,
			case 
				  when elecq ='0' then 'no'
				  when elecq ='1' then 'yes'
			end as	elecq,
			case 
				  when cookingq ='0' then 'no'
				  when cookingq ='1' then 'yes'
			end as cookingq
		into child_basicaminities_pr
		FROM dbo.peru_constructed

		select * from child_basicaminities_pr order by childid

	--creating table child_householddetails from already existing PERU database
		SELECT childid,
			roundnumber,
			case 
				when headedudu ='0' then 'None'
				when headedudu ='1' then 'Grade 1'
				when headedudu ='2' then 'Grade 2'
				when headedudu ='3' then 'Grade 3'
				when headedudu ='4' then 'Grade 4'
				when headedudu ='5' then 'Grade 5'
				when headedudu ='6' then 'Grade 6'
				when headedudu ='7' then 'Grade 7'
				when headedudu ='8' then 'Grade 8'
				when headedudu ='9' then 'Grade 9'
				when headedudu ='10' then 'Grade 10'
				when headedudu ='11' then 'Grade 11'
				when headedudu ='13' then 'Technical, pedagogical, CETPRO (incomplete)'
				when headedudu ='14' then 'Technical, pedagogical, CETPRO (complete)'
				when headedudu ='15' then 'University (incomplete)'
				when headedudu ='16' then 'University (complete)'
				when headedudu ='28' then 'Adult literacy'
				when headedudu ='30' then 'Other'
			end as headedu,
			headage,
			case 
				when headsex ='1' then 'male'
				when headsex ='2' then 'female'
			end as headsex,
			case 
				when headrel ='0' then 'YL child'
				when headrel ='1' then 'Biological parent'
				when headrel ='2' then 'Non-biological parent'
				when headrel ='3' then 'Grandparent'
				when headrel ='4' then 'Uncle/aunt'
				when headrel ='5' then 'Sibling'
				when headrel ='6' then 'Other-relative'
				when headrel ='7' then 'Other-nonrelative'
				when headrel ='8' then 'Partner/spouse of YL child'
				when headrel ='9' then 'Father-in-law/mother-in-law'
			end as headrel,
			hhsize,
			wi as wealth_index,
			hq as housing_quality 
		into child_householddetails_pr
		FROM dbo.peru_constructed

		select * from child_householddetails_pr order by childid

		
  --linking tables using childid
		CREATE or alter PROCEDURE foreignkey_pr @table nVarchar(50)
		AS
		begin
			declare @abc nvarchar(100);
				set @abc='ALTER TABLE '+@table+' ADD FOREIGN KEY (childid) REFERENCES child_details_pr(childid);';
			exec (@abc);
		end;

		exec foreignkey_pr @table='child_health_pr';
		exec foreignkey_pr @table='child_education_pr';
		exec foreignkey_pr @table='child_basicaminities_pr';
		exec foreignkey_pr @table='child_caregiver_chara_pr';
		exec foreignkey_pr @table='child_householddetails_pr';


	--creating composite primary key in all tables
	   CREATE or alter PROCEDURE notnull_pr @table nVarchar(50)
		AS
		begin
			declare @abc nvarchar(200);
				set @abc='ALTER TABLE '+@table+'
							ALTER COLUMN childid varchar(50) NOT NULL;
							ALTER TABLE '+@table+'
							ALTER COLUMN roundnumber varchar(50) NOT NULL;';
			exec (@abc);
		end;

		exec notnull_pr @table='child_health_pr';
		exec notnull_pr @table='child_education_pr';
		exec notnull_pr @table='child_basicaminities_pr';
		exec notnull_pr @table='child_caregiver_chara_pr';
		exec notnull_pr @table='child_householddetails_pr';

	--procedure for making primary key.
		CREATE or alter PROCEDURE primary_pr @table nVarchar(50)
		AS
		begin
			declare @abc nvarchar(200);
				set @abc='ALTER TABLE '+@table+' ADD PRIMARY KEY(childid, roundnumber);';
			exec (@abc);
		end;

		exec primary_pr @table='child_health_pr';
		exec primary_pr @table='child_education_pr';
		exec primary_pr @table='child_basicaminities_pr';
		exec primary_pr @table='child_caregiver_chara_pr';
		exec primary_pr @table='child_householddetails_pr';


--VIETNAM

	-- creating table child_details from already existing VIETNAM database
		SELECT distinct(childid),
		case 
		  when chsex ='1' then 'male'
		  when chsex ='2' then 'female'
		  end as chsex,
		case 
		  when chlang ='99' then 'missing'
		  when chlang ='41' then 'vietnamese'
		  when chlang ='10' then 'other'
		  when chlang ='43' then 'tay'
		  when chlang ='44' then 'h.mong'
		  when chlang ='77' then 'nk'
		  when chlang ='46' then 'ede'
		  when chlang ='45' then 'nung'
		  when chlang ='48' then 'dao'
		  when chlang ='49' then 'giay'
		  when chlang ='79' then 'refused to answer'
		  when chlang ='88' then 'n/a'
		  when chlang ='47' then 'thai'
		  when chlang ='42' then 'chinese'
		  end as chlang
		into child_details_vi
		FROM dbo.vietnam_constructed;

	--making childid notnull and then the primary key
		ALTER TABLE child_details_vi ALTER COLUMN childid VARCHAR(50) NOT NULL;
		ALTER TABLE child_details_vi ADD PRIMARY KEY(childid);

	--adding country id to the table child_details
		ALTER TABLE child_details_vi
		ADD country_id numeric,
		FOREIGN KEY(country_id) REFERENCES country(countryid);

		Select * from child_details_vi;

	--updating country_id values
		UPDATE child_details_vi
		SET country_id = 4
		WHERE childid like'VN%';

	--adding alive/dead status to the child_details table
		CREATE VIEW partition_vietnam AS
		select childid,roundnumber,deceased,
		count(1) over (partition by childid) as number_of_rounds
		from dbo.vietnam_constructed
		where deceased='1'

		select * from partition_india

		CREATE VIEW round_deceased_vi AS
		select distinct(childid),(5-number_of_rounds) as round_died_in
		from partition_vietnam
		where deceased='1'

		select * from round_deceased;

		ALTER TABLE child_details_vi
		ADD deceased_round varchar(3);

		UPDATE child_details_vi
		SET deceased_round =(
		SELECT round_died_in
		FROM round_deceased_vi
		WHERE round_deceased_vi.childid = child_details_vi.childid);

		select * from child_details_vi

		ALTER TABLE child_details_vi
		ADD alive varchar(3);

		update child_details_vi
		set alive='yes' where deceased_round is null

		update child_details_vi
		set alive='no' where deceased_round is not null


	--creating table child_caregiver_chara from already existing VIETNAM database
		SELECT	childid,
				roundnumber,
				dadage,
				dadyrdied,
				case 
				  when dadedu ='0' then 'None'
				  when dadedu ='1' then 'Grade 1'
				  when dadedu ='2' then 'Grade 2'
				  when dadedu ='3' then 'Grade 3'
				  when dadedu ='4' then 'Grade 4'
				  when dadedu ='5' then 'Grade 5'
				  when dadedu ='6' then 'Grade 6'
				  when dadedu ='7' then 'Grade 7'
				  when dadedu ='8' then 'Grade 8'
				  when dadedu ='9' then 'Grade 9'
				  when dadedu ='10' then 'Grade 10'
				  when dadedu ='11' then 'Grade 11'
				  when dadedu ='12' then 'Grade 12'
				  when dadedu ='13' then 'Vocational, technical college'
				  when dadedu ='14' then 'University'
				  when dadedu ='15' then 'Masters, doctorate'
				  when dadedu ='28' then 'Adult literacy'
				  when dadedu ='29' then 'Religious education'
				  when dadedu ='30' then 'Other'
				end as dadedu,
				momage,
				momyrdied,
				case 
				  when momedu ='0' then 'None'
				  when momedu ='1' then 'Grade 1'
				  when momedu ='2' then 'Grade 2'
				  when momedu ='3' then 'Grade 3'
				  when momedu ='4' then 'Grade 4'
				  when momedu ='5' then 'Grade 5'
				  when momedu ='6' then 'Grade 6'
				  when momedu ='7' then 'Grade 7'
				  when momedu ='8' then 'Grade 8'
				  when momedu ='9' then 'Grade 9'
				  when momedu ='10' then 'Grade 10'
				  when momedu ='11' then 'Grade 11'
				  when momedu ='12' then 'Grade 12'
				  when momedu ='13' then 'Vocational, technical college'
				  when momedu ='14' then 'University'
				  when momedu ='15' then 'Masters, doctorate'
				  when momedu ='28' then 'Adult literacy'
				  when momedu ='29' then 'Religious education'
				  when momedu ='30' then 'Other'
				end as momedu,
				careage,
				caresex,
				case 
				  when carerel ='0' then 'YL child'
				  when carerel ='1' then 'Biological parent'
				  when carerel ='2' then 'Non-biological parent'
				  when carerel ='3' then 'Grandparent'
				  when carerel ='4' then 'Uncle/aunt'
				  when carerel ='5' then 'Sibling'
				  when carerel ='6' then 'Other-relative'
				  when carerel ='7' then 'Other-nonrelative'
				  when carerel ='8' then 'Partner/spouse of YL child'
				  when carerel ='9' then 'Father-in-law/mother-in-law'
				end as carerel,
				case 
				  when caredu ='0' then 'None'
				  when caredu ='1' then 'Grade 1'
				  when caredu ='2' then 'Grade 2'
				  when caredu ='3' then 'Grade 3'
				  when caredu ='4' then 'Grade 4'
				  when caredu ='5' then 'Grade 5'
				  when caredu ='6' then 'Grade 6'
				  when caredu ='7' then 'Grade 7'
				  when caredu ='8' then 'Grade 8'
				  when caredu ='9' then 'Grade 9'
				  when caredu ='10' then 'Grade 10'
				  when caredu ='11' then 'Grade 11'
				  when caredu ='12' then 'Grade 12'
				  when caredu ='13' then 'Vocational, technical college'
				  when caredu ='14' then 'University'
				  when caredu ='15' then 'Masters, doctorate'
				  when caredu ='28' then 'Adult literacy'
				  when caredu ='29' then 'Religious education'
				  when caredu ='30' then 'Other'
				end as caredu
		into child_caregiver_chara_vi
		FROM dbo.vietnam_constructed

		select * from child_caregiver_chara_pr

	--creating table child_education from already existing VIETNAM database
		SELECT	childid,
				roundnumber,
				case 
				  when preprim ='0' then 'No'
				  when preprim ='1' then 'Yes'
				end as preprim,
				agegr1,
				case 
				  when enrol ='0' then 'No'
				  when enrol ='1' then 'Yes'
				end as enrol,
				case 
				  when engrade ='0' then 'None'
				  when engrade ='1' then 'Grade 1'
				  when engrade ='2' then 'Grade 2'
				  when engrade ='3' then 'Grade 3'
				  when engrade ='4' then 'Grade 4'
				  when engrade ='5' then 'Grade 5'
				  when engrade ='6' then 'Grade 6'
				  when engrade ='7' then 'Grade 7'
				  when engrade ='8' then 'Grade 8'
				  when engrade ='9' then 'Grade 9'
				  when engrade ='10' then 'Grade 10'
				  when engrade ='11' then 'Grade 11'
				  when engrade ='12' then 'Grade 12'
				  when engrade ='13' then 'Short term Vocational Training'
				  when engrade ='14' then 'Vocational Secondary School (1st year)'
				  when engrade ='15' then 'Vocational Secondary School (2nd year)'
				  when engrade ='16' then 'Vocational Secondary School completion'
				  when engrade ='17' then 'Professional Secondary (1st years)'
				  when engrade ='18' then 'Professional Secondary (2nd years)'
				  when engrade ='19' then 'Professional Secondary (3rd years)'
				  when engrade ='20' then 'Professional Secondary completion'
				  when engrade ='21' then 'Vocational College (1st year)'
				  when engrade ='22' then 'Vocational College (2nd year)'
				  when engrade ='23' then 'Vocational college completion'
				  when engrade ='24' then 'College education (1st year)'
				  when engrade ='25' then 'College education (2nd year)'
				  when engrade ='26' then 'College education completion'
				  when engrade ='27' then 'In the job, evening/weekend college education'
				  when engrade ='28' then 'In the job, evening/weekend undergraduate in university'
				  when engrade ='29' then 'University education (undergraduate 1st year)'
				  when engrade ='30' then 'University education (undergraduate 2nd year)'
				  when engrade ='31' then 'University education (undergraduate 3rd year)'
				  when engrade ='32' then 'University education (undergraduate 4th year)'
				  when engrade ='33' then 'University education (undergraduate 5th year)'
				  when engrade ='34' then 'University education completion'
				  when engrade ='35' then 'Post-graduate education'
				  when engrade ='36' then 'Post-graduate completion'
				  when engrade ='37' then 'Centre for continued education (non-formal student)'
				  when engrade ='38' then 'Other'
				  when engrade ='50' then 'Any pre-primary grade'
				  when engrade ='77' then 'NK'
				end as engrade,
				case 
				  when entype ='1' then 'private'
				  when entype ='2' then 'NGO/Charity/ Religious (not for profit)'
				  when entype ='3' then 'Half public/half private'
				  when entype ='4' then 'Public'
				  when entype ='5' then 'Other'
				  when entype ='6' then 'Informal'
				  when entype ='7' then 'Half public/Half Private'
				  when entype ='8' then 'Centre for continuing education'
				  when entype ='9' then 'NK'
				  when entype ='10' then 'NA'
				end as entype,
				timesch,
				case 
				  when levlread ='1' then 'cant read anything'
				  when levlread ='2' then 'reads letters'
				  when levlread ='3' then 'reads word'
				  when levlread ='4' then 'reads sentence'
				end as levlread,
				case 
				  when levlwrit ='1' then 'no'
				  when levlwrit ='2' then 'yes with difficulty or errors'
				  when levlwrit ='3' then ' yes without difficulty or errors'
				end as levlwrit,
				case 
				  when literate ='0' then 'no'
				  when literate ='1' then 'yes'
				end as literate
		into child_education_vi
		FROM dbo.vietnam_constructed

		select * from child_education_vi order by childid

	--creating table child_health from already existing VIETNAM database
		SELECT  childid,
				roundnumber,
				chweight,
				chheight,
				chhealth,
				bmi,
				case 
				  when underweight ='0' then 'not underweight'
				  when underweight ='1' then 'moderately underweight'
				  when underweight ='2' then 'severely underweight'
				end as underweight,
				case 
				  when stunting ='0' then 'not stunted'
				  when stunting ='1' then 'moderately stunted'
				  when stunting ='2' then 'severely stunted'
				end as stunting,
				case 
				  when thinness ='0' then 'not thin'
				  when thinness ='1' then 'moderately thin'
				  when thinness ='2' then 'severely thin'
				end as thinness
		into child_health_vi
		FROM dbo.vietnam_constructed

		select * from child_health_vi order by childid

	--creating table child_basicaminities from already existing VIETNAM database
		SELECT childid,
			roundnumber,
			case 
				  when drwaterq_new ='0' then 'no'
				  when drwaterq_new ='1' then 'yes'
			end as drwaterq,
			case 
				  when toiletq_new ='0' then 'no'
				  when toiletq_new ='1' then 'yes'
			end as toiletq,
			case 
				  when elecq_new ='0' then 'no'
				  when elecq_new ='1' then 'yes'
			end as	elecq,
			case 
				  when cookingq_new ='0' then 'no'
				  when cookingq_new ='1' then 'yes'
			end as cookingq
		into child_basicaminities_vi
		FROM dbo.vietnam_constructed

		select * from child_basicaminities_vi order by childid

	--creating table child_householddetails from already existing VIETNAM database
		SELECT childid,
			roundnumber,
			case 
				when headedu ='0' then 'None'
				when headedu ='1' then 'Grade 1'
				when headedu ='2' then 'Grade 2'
				when headedu ='3' then 'Grade 3'
				when headedu ='4' then 'Grade 4'
				when headedu ='5' then 'Grade 5'
				when headedu ='6' then 'Grade 6'
				when headedu ='7' then 'Grade 7'
				when headedu ='8' then 'Grade 8'
				when headedu ='9' then 'Grade 9'
				when headedu ='10' then 'Grade 10'
				when headedu ='11' then 'Grade 11'
				when headedu ='12' then 'Grade 12'
				when headedu ='13' then 'Post-secondary, vocational'
				when headedu ='14' then 'University'
				when headedu ='15' then 'Masters, doctorate'
				when headedu ='28' then 'Adult literacy'
				when headedu ='29' then 'Religious education'
				when headedu ='30' then 'Other'
			end as headedu,
			headage,
			case 
				when headsex ='1' then 'male'
				when headsex ='2' then 'female'
			end as headsex,
			case 
				when headrel ='0' then 'YL child'
				when headrel ='1' then 'Biological parent'
				when headrel ='2' then 'Non-biological parent'
				when headrel ='3' then 'Grandparent'
				when headrel ='4' then 'Uncle/aunt'
				when headrel ='5' then 'Sibling'
				when headrel ='6' then 'Other-relative'
				when headrel ='7' then 'Other-nonrelative'
				when headrel ='8' then 'Partner/spouse of YL child'
				when headrel ='9' then 'Father-in-law/mother-in-law'
			end as headrel,
			hhsize,
			wi_new as wealth_index,
			hq_new as housing_quality 
		into child_householddetails_vi
		FROM dbo.vietnam_constructed

		select * from child_householddetails_vi order by childid
	

		--linking tables using childid
		CREATE or alter PROCEDURE foreignkey_vi @table nVarchar(50)
		AS
		begin
			declare @abc nvarchar(100);
				set @abc='ALTER TABLE '+@table+' ADD FOREIGN KEY (childid) REFERENCES child_details_vi(childid);';
			exec (@abc);
		end;

		exec foreignkey_vi @table='child_health_vi';
		exec foreignkey_vi @table='child_education_vi';
		exec foreignkey_vi @table='child_basicaminities_vi';
		exec foreignkey_vi @table='child_caregiver_chara_vi';
		exec foreignkey_vi @table='child_householddetails_vi';


	--creating composite primary key in all tables
	   CREATE or alter PROCEDURE notnull_vi @table nVarchar(50)
		AS
		begin
			declare @abc nvarchar(200);
				set @abc='ALTER TABLE '+@table+'
							ALTER COLUMN childid varchar(50) NOT NULL;
							ALTER TABLE '+@table+'
							ALTER COLUMN roundnumber varchar(50) NOT NULL;';
			exec (@abc);
		end;

		exec notnull_vi @table='child_health_vi';
		exec notnull_vi @table='child_education_vi';
		exec notnull_vi @table='child_basicaminities_vi';
		exec notnull_vi @table='child_caregiver_chara_vi';
		exec notnull_vi @table='child_householddetails_vi';

	--procedure for making primary key.
		CREATE or alter PROCEDURE primary_vi @table nVarchar(50)
		AS
		begin
			declare @abc nvarchar(200);
				set @abc='ALTER TABLE '+@table+' ADD PRIMARY KEY(childid, roundnumber);';
			exec (@abc);
		end;

		exec primary_vi @table='child_health_vi';
		exec primary_vi @table='child_education_vi';
		exec primary_vi @table='child_basicaminities_vi';
		exec primary_vi @table='child_caregiver_chara_vi';
		exec primary_vi @table='child_householddetails_vi';

	