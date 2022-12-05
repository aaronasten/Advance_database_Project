--creating a procedure to create a view containing the different caregory wise count of litrate and illitrate childrens;
CREATE or alter PROCEDURE weight @country nVarchar(50)
	AS
	begin
		declare @abc nvarchar(4000);
			set @abc='create or alter view weight_'+@country+' as 
					   select ''not underweight'' as category, count(distinct(childid)) as count 
					   from child_health_'+@country+' 
					   where underweight=''not underweight''
					  UNION ALL
					   select ''moderately underweight'' as category, count(distinct(childid)) as count 
					   from child_health_'+@country+' 
					   where underweight=''moderately underweight''
					  Union All
					   select ''severely underweight'' as category, count(distinct(childid)) as count 
					   from child_health_'+@country+' 
					   where underweight=''severely underweight'';';
		exec (@abc);
	end;

--creating views using the procedure created;

exec weight @country='in';
exec weight @country='pr';
exec weight @country='vi';
exec weight @country='et';


--use combine procedure to combine all 4 weight results;
exec combine @table='weight';

--displaying the result;
select * from complete_weight;