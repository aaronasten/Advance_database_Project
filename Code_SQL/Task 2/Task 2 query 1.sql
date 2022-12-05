--Different work related reason why the student was not able to attend school in vietnam;
create view Reason_attendenceshortage as 
	SELECT 'paid work' as Reason, count(STRSNMS3) as count
	FROM child_schooldetails
	where STRSNMS3 = 'yes' AND  STRSNMS4 = 'NO' AND STRSNMS5 = 'NO' 
UNION ALL
	SELECT 'family business' as Reason, count(STRSNMS4) as count
	FROM child_schooldetails
	where STRSNMS4 = 'yes' AND  STRSNMS3 = 'NO' AND STRSNMS5 = 'NO'
UNION ALL
	SELECT 'house chores' as Reason,count(STRSNMS5) as count
	FROM child_schooldetails
	where STRSNMS5 = 'yes' AND  STRSNMS4 = 'NO' AND STRSNMS3 = 'NO';

select * from Reason_attendenceshortage order by count;
