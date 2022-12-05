--students access to different important to education items
create or alter view Access_to_imp_items as 
		select 'Desk' as Important_Items, count(STHVDESK) as count
		from childaccessto_usefulitems 
		where STHVDESK='yes'
	UNION ALL
		select 'Chair' as Important_Items, count(STHVCHR) as count
		from childaccessto_usefulitems 
		where STHVCHR='yes'
	UNION ALL
		select 'Lamp' as Important_Items, count(STHVLAMP) as count
		from childaccessto_usefulitems 
		where STHVLAMP='yes'
	UNION ALL
		select 'Computer' as Important_Items, count(STHVCOMP) as count
		from childaccessto_usefulitems
		where STHVCOMP='yes'
	UNION ALL
		select 'Internet' as Important_Items, count(STHVINTR) as count
		from childaccessto_usefulitems
		where STHVINTR='yes'
		
select * from Access_to_imp_items order by count desc;