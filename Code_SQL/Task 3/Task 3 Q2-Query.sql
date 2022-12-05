
--create view containg distinct lsoa code, latitude, longitude
create view vehicle_crime as 
	select distinct(lsoa_code), count(*) as no_of_crimes, round(avg(latitude),3) as latitude, round(avg(longitude),3) as longitude 
	from greater_manchester_street
	where crime_type like '%vehicle%'
	group by lsoa_code

--create table containg from the view created above.
SELECT  *
	INTO   vehicle_crimetb
	FROM   vehicle_crime;

--Adding geoloaction column to the Vehicle crime table.
ALTER TABLE vehicle_crimetb
	ADD [GeoLocation] GEOGRAPHY;

ALTER TABLE vehicle_crimetb
	ADD ID INT IDENTITY;
ALTER TABLE vehicle_crimetb
	ADD CONSTRAINT PK_Id PRIMARY KEY NONCLUSTERED (ID);

--Adding Geoloaction data to the vehicle crime table.
UPDATE vehicle_crimetb
SET [GeoLocation] = geography::Point(latitude, longitude, 4326)
WHERE   longitude IS NOT NULL
		AND latitude IS NOT NULL
		AND CAST(latitude AS decimal(10, 6)) BETWEEN -90 AND 90
		AND CAST(longitude AS decimal(10, 6)) BETWEEN -90 AND 90;

select * from vehicle_crimetb
