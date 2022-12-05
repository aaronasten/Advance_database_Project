
create view crimes as
	select (LEFT(lsoa_name, len(lsoa_name) -4)) as county ,count(*) as no_of_crimes
	from greater_manchester_street
	group by LSOA_name;

create view crimes_by_county as
	select county, sum(no_of_crimes) as count
	from crimes
	group by county;

create view county as 
	select LEFT(column3, len(column3) -4) as county,column4 as count
	from person 
	where (column3 is not null) and (column3 !='LSOA');

create view county_population as
	select distinct(county), SUM(cast(replace(count,',','') as integer)) as population
	from county
	group by county;

create view  population_to_crime_ratio as
	select c.county, c.count, p.population, count * 100/population as population_to_crime_ratio
	from crimes_by_county as c, county_population as p
	where c.county=p.county


select * from population_to_crime_ratio order by population_to_crime_ratio desc