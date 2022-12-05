--creating a procedure to create a view containing the different caregory wise count of acces to basic necessities
CREATE or alter PROCEDURE basicaminities @country nVarchar(50)
	AS
	begin
		declare @abc nvarchar(4000);
			set @abc='create or alter view basic_aminities_'+@country+' as
						 select ''water'' as category, count(distinct(childid)) as count 
						 from child_basicaminities_'+@country+' 
						 where drwaterq=''yes''
						UNION ALL
						 select ''electricty'' as category,count(distinct(childid))as count  
						 from child_basicaminities_'+@country+' 
						 where elecq=''yes''
						UNION ALL
						 select ''toilet'' as category, count(distinct(childid)) as count 
						 from child_basicaminities_'+@country+' 
						 where toiletq=''yes''
						UNION ALL
						 select ''cooking'' as category, count(distinct(childid)) as count  
						 from child_basicaminities_'+@country+' 
						 where cookingq=''yes'';';
		exec (@abc);
	end;

--creating views using the procedure created

exec basicaminities @country='in';
exec basicaminities @country='pr';
exec basicaminities @country='vi';
exec basicaminities @country='et';

--use combine procedure to combine all 4 basic_aminities results
exec combine @table = 'basic_aminities';

select * from complete_basic_aminities;