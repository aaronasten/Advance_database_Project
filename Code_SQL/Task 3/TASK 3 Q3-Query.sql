--create view containg distinct lsoa code, latitude, longitude
create view social_crime as 
	select distinct(lsoa_code), count(*) as count, round(avg(latitude),3) as latitude, round(avg(longitude),3) as longitude  
	from greater_manchester_street 
	where crime_type like '%anti-social%' and  LSOA_name like '%salford%'
	group by lsoa_code

--create table containg from the view created above.
SELECT  *
	INTO    social_crimetb
	FROM    social_crime

--Adding geoloaction column to the social crime table.
ALTER TABLE social_crimetb
	ADD [GeoLocation] GEOGRAPHY

ALTER TABLE social_crimetb
	ADD ID INT IDENTITY;

--Adding Geoloaction data to the social crime table.
UPDATE social_crimetb
SET [GeoLocation] = geography::Point(latitude, longitude, 4326)
WHERE   longitude IS NOT NULL
		AND latitude IS NOT NULL
		AND CAST(latitude AS decimal(10, 6)) BETWEEN -90 AND 90
		AND CAST(longitude AS decimal(10, 6)) BETWEEN -90 AND 90


select * from social_crimetb

