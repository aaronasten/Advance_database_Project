--creating a procedure to create a view containing the different caregory wise count of parents death
CREATE or alter PROCEDURE parent_died @country nVarchar(50)
	AS
	begin
		declare @abc nvarchar(4000);
			set @abc='create or alter view Parent_died_'+@country+' as 
						 select ''dad died'' as category, count(distinct(childid)) as count 
						 from child_caregiver_chara_'+@country+' 
						 where dadyrdied is not null
						UNION ALL
						 select ''Both died'' as category, count(distinct(childid)) as count 
						 from child_caregiver_chara_'+@country+'
						 where dadyrdied is not null and momyrdied is not null
						UNION ALL
						 select ''Mom died'' as category, count(distinct(childid)) as count 
						 from child_caregiver_chara_'+@country+'
						 where momyrdied is not null;';
		exec (@abc);
	end;

--creating views using the procedure created

exec parent_died @country='in';
exec parent_died @country='pr';
exec parent_died @country='vi';
exec parent_died @country='et';

--use combine procedure to combine all 4 parent_died results
exec combine @table='parent_died';

select * from complete_parent_died;