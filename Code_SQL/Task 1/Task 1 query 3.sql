--creating a procedure to create a view containing the different caregory wise count of litrate and illitrate childrens
CREATE or alter PROCEDURE literate @country nVarchar(50)
	AS
	begin
		declare @abc nvarchar(4000);
			set @abc='create or alter view literate_'+@country+' as 
						 select ''Literate'' as category,count(distinct(childid)) as ''Count'' 
						 from child_education_'+@country+' 
						 where literate=''yes''
						UNION ALL
						 select ''illiterate'' as category,count(distinct(childid)) as ''Count'' 
						 from child_education_'+@country+' 
						 where literate=''no'';';
		exec (@abc);
	end;

--creating views using the procedure created

exec literate @country='in';
exec literate @country='pr';
exec literate @country='vi';
exec literate @country='et';

--use combine procedure to combine all 4 literate results
exec combine @table = 'literate';

select * from complete_literate;
