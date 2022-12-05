--Health issues of students
create view Healthissue_frequency as 
		select 'Sight Problem' as Health_issue, count(STDHLTH1) as count
		from childhealth 
		where STDHLTH1='yes'
	UNION ALL
		select 'Hearing Problem' as Health_issue, count(STDHLTH2) as count
		from childhealth
		where STDHLTH2='yes'
	UNION ALL
		select 'Headache' as Health_issue, count(STDHLTH3) as count
		from childhealth
		where STDHLTH3='yes'
	UNION ALL
		select 'Fever' as Health_issue, count(STDHLTH4) as count
		from childhealth
		where STDHLTH4='yes'
	UNION ALL
		select 'Stomatch' as Health_issue, count(STDHLTH5) as count
		from childhealth
		where STDHLTH5='yes'
	UNION ALL
		select 'No issue' as Health_issue, count(STDHLTH0) as count
		from childhealth
		where STDHLTH0='yes'

select * from Healthissue_frequency order by count desc;