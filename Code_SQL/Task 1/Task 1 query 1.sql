--creating a procedure to create a view containing the different caregorywise count of BMI
CREATE or alter PROCEDURE bmi @country nVarchar(50)
		AS
		begin
			declare @abc nvarchar(4000);
				set @abc='create or alter view bmi_'+@country+' as 
								select ''normal'' as category, count(distinct(childid)) as count 
								from child_health_'+@country+'	
								where CAST(BMI AS numeric(10,2)) between 18.5 and 24.9 and bmi!='''' and bmi is not null
							UNION ALL
								select ''under'' as category, count(distinct(childid)) as count 
								from child_health_'+@country+' 
								where CAST(BMI AS numeric(10,2)) < 18.5 and bmi!='''' and bmi is not null
							UNION ALL
								select ''over'' as category, count(distinct(childid)) as count 
								from child_health_'+@country+' 
								where CAST(BMI AS numeric(10,2)) between 25 and 29.9 and bmi!='''' and bmi is not null
							UNION ALL
								select ''obese'' as category, count(distinct(childid)) as count 
								from child_health_'+@country+'
								where CAST(BMI AS numeric(10,2)) >30 and bmi!='''' and bmi is not null;';
			exec (@abc);
		end;

--using the created procedure to create different bmi wise count of different countries
	exec bmi @country = 'in';
	exec bmi @country = 'et';
	exec bmi @country = 'pr';
	exec bmi @country = 'vi';

--use combine procedure to combine all 4 bmi results
exec combine @table = 'bmi';

select * from complete_bmi;