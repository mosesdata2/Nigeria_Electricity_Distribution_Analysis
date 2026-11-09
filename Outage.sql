DROP TABLE IF EXISTS nigeria_energy_outage

SELECT * FROM nigeria_energy_outage

CREATE TABLE nigeria_energy_outage(
   outage_id TEXT,
   disco VARCHAR(20),
   feeder_id TEXT,
   start_time TIMESTAMP,
   end_time TIMESTAMP,
   duration_min INTEGER,
   cause VARCHAR(30),
   customer_affected INTEGER,
   status VARCHAR(30),
   lat NUMERIC(9,6),
   lon NUMERIC(9,6)
 ); 


--checking data_type and column_name
SELECT data_type,column_name
FROM inforamtion_schema.columns
WHERE table_name = 'nigeria_energy_outage'

--sample the dataset
SELECT * FROM nigeria_energy_outage
LIMIT 20

-- count total data
SELECT COUNT(*) FROM nigeria_energy_outage

-- checking for duplicates
SELECT outage_id,disco,duration_min,
COUNT(*) AS total_count
FROM nigeria_energy_outage
GROUP BY outage_id,disco,duration_min
HAVING COUNT(*) > 1

SELECT disco,SUM(duration_min) AS total_duration_min
FROM nigeria_energy_outage
GROUP BY disco
ORDER BY total_duration_min DESC

SELECT DISTINCT cause FROM nigeria_energy_outage

SELECT disco,COUNT(cause) AS total_count
FROM nigeria_energy_outage
GROUP BY disco
ORDER BY total_count DESC

WITH total_count AS(
SELECT disco,SUM(duration_min) AS total_duration_min
FROM nigeria_energy_outage ne
GROUP BY disco
ORDER BY total_duration_min DESC)
SELECT *,
ROW_NUMBER() OVER(ORDER BY tc.total_duration_min DESC) AS count_of_row
FROM total_count tc

SELECT disco,ROUND(AVG(duration_min),2) AS avg_duration
FROM nigeria_energy_outage
GROUP BY disco
ORDER BY avg_duration DESC

SELECT disco,
   COUNT(*) AS total_count,
   SUM(duration_min) AS total_duration_min,
   ROUND(AVG(duration_min)) AS avg_duration_min,
   MAX(duration_min) AS max_duration_min,
   MIN(duration_min) AS min_duration_min
FROM nigeria_energy_outage
GROUP BY disco

SELECT DISTINCT cause,disco,COUNT(customers_affected) AS count_customers
FROM nigeria_energy_outage
GROUP BY cause,disco
ORDER BY count_customers DESC;

SELECT 
  COUNT(*) AS total_records,
  COUNT(lon) AS lon_available,
  COUNT(lat) AS lat_available
FROM nigeria_energy_outage

SELECT *
FROM nigeria_energy_outage
WHERE lon < 2
  OR lon > 16
  OR lat < 3
  OR lat > 15

SELECT * FROM nigeria_energy_outage
LIMIT 20;

SELECT cause,SUM(customers_affected) AS count_of_customers
FROM nigeria_energy_outage
GROUP BY cause
ORDER BY count_of_customers DESC;

SELECT DISTINCT cause
FROM nigeria_energy_outage
WHERE disco = 'Eko'

SELECT disco,SUM(duration_min) AS total_min
FROM nigeria_energy_outage
WHERE disco = 'Eko' OR
disco = 'ibadan'

SELECT 
 disco, EXTRACT(MONTH FROM start_time) AS outage_time
FROM nigeria_energy_outage

-- which disco have the average highest duration mins and why?
WITH avg_duration AS(
  SELECT disco,ROUND(AVG(duration_min),2) AS avg_duration_min
  FROM nigeria_energy_outage
  GROUP BY disco
  ORDER BY avg_duration_min DESC
)
SELECT *
FROM avg_duration

-- cumulative outage duration
SELECT disco,SUM(duration_min) AS total_outage
FROM nigeria_energy_outage
GROUP BY disco
ORDER BY total_outage DESC;

-- which disco have the highest number of recorded outage?
SELECT disco, COUNT(*) AS total_count
FROM nigeria_energy_outage
GROUP BY disco
ORDER BY total_count DESC;

-- Frequently occured causes
SELECT DISTINCT cause, COUNT(cause) AS highest_cause_recorded
FROM nigeria_energy_outage
GROUP BY cause
ORDER BY highest_cause_recorded DESC;

-- customers that is been affected most with the highest causes
WITH number_causes AS (
SELECT cause,SUM(customers_affected) AS cumulated_causes
FROM nigeria_energy_outage
GROUP BY cause
ORDER BY cumulated_causes DESC)
SELECT *,
ROW_NUMBER () OVER(ORDER BY cumulated_causes DESC)
FROM number_causes;

SELECT DISTINCT cause,SUM(duration_min) AS total_duration
FROM nigeria_energy_outage
GROUP BY cause
ORDER BY total_duration DESC

SELECT * FROM nigeria_energy_outage

SELECT start_time,end_time FROM nigeria_energy_outage


SELECT 
  disco, COUNT(*) AS total_outages,
  COUNT(DISTINCT feeder_id) AS total_feeders,
  ROUND(
  COUNT(*):: NUMERIC  /
  NULLIF(COUNT(DISTINCT feeder_id),0),2
  ) AS outage_per_feeder
FROM nigeria_energy_outage

SELECT 
  MIN(lat) AS min_lat,MAX(lat) AS max_lat,
  MIN(lon) AS min_
GROUP BY disco
ORDER BY outage_per_feeder DESC;

SELECT DISTINCT feeder_id FROM nigeria_energy_outage
WHERE disco = 'Eko'

SELECT * FROM nigeria_energy_outage
LIMIT 20;

SELECT DISTINCT cause, COUNT(status) AS causes_count
FROM nigeria_energy_outage
GROUP BY cause
ORDER BY causes_count DESC;

SELECT DISTINCT(TO_CHAR(start_time,'Mon')) AS month, 
 (EXTRACT(YEAR FROM start_time)) AS year FROM nigeria_energy_outage

SELECT lat,lon,COUNT(*) AS total_outage
FROM nigeria_energy_outage
GROUP BY 1,2
ORDER BY 1,2

SELECT ROUND(lat::numeric,2) AS lat_area,
 ROUND(lon::numeric,2) AS lon_area,
COUNT(*) AS total_outage
FROM nigeria_energy_outage
GROUP BY 1,2
ORDER BY total_outage DESC;

SELECT 
 MIN(lat) AS min_lat, MAX(lat) AS max_lat,
 MIN(lon) AS min_lon, MAX(lon) AS min_lon
FROM nigeria_energy_outage

SELECT 
 COUNT(*) AS total_records,
 COUNT(DISTINCT lat) AS unique_lat,
 COUNT(DISTINCT lon) AS unique_lon,
 COUNT(*) FILTER(
  WHERE lat IS NULL OR lon IS NULL
 ) AS missing_coordinates
 FROM nigeria_energy_outage

SELECT SUM(duration_min) FROM nigeria_energy_outage

SELECT COUNT(DISTINCT(disco)) FROM nigeria_energy_outage

SELECT * FROM nigeria_energy_outage
LIMIT 20

SELECT disco,SUM(duration_min) AS total_outage
FROM nigeria_energy_outage
GROUP BY disco
ORDER BY total_outage DESC;

SELECT SUM(duration_min) / 60 AS total_outage
FROM nigeria_energy_outage

SELECT DISTINCT cause,ROUND(AVG(customers_affected),2) AS avg_customer_affected
FROM nigeria_energy_outage
GROUP BY cause
ORDER BY avg_customer_affected

SELECT disco,SUM(customers_affected) AS total_customer_affected
FROM nigeria_energy_outage
GROUP BY disco
ORDER BY total_customer_affected DESC;

SELECT * FROM nigeria_energy_outage
LIMIT 20;

SELECT COUNT(DISTINCT feeder_id) FROM nigeria_energy_outage

SELECT SUM(customers_affected) AS total_customer_affected FROM nigeria_energy_outage

SELECT ROUND(AVG(duration_min),2) FROM nigeria_energy_outage

WITH customer_affected AS (
SELECT disco,SUM(customers_affected) AS total_customer_affected
FROM nigeria_energy_outage
GROUP BY disco
ORDER BY total_customer_affected DESC)
SELECT *,
ROW_NUMBER () OVER(ORDER BY total_customer_affected DESC)
FROM customer_affected

SELECT disco,
ROUND(SUM(duration_min)/ 60.0,2)AS highest_outage
FROM nigeria_energy_outage
GROUP BY disco
ORDER BY highest_outage DESC

SELECT * FROM nigeria_energy_outage
LIMIT 20;

SELECT lat,lon FROM nigeria_energy_outage
LIMIT 20;

SELECT DISTINCT feeder_id,SUM(duration_min) AS total_outage
FROM nigeria_energy_outage
GROUP BY feeder_id
ORDER BY total_outage DESC
LIMIT 10;

SELECT 
  COUNT(*) AS total_records,
  COUNT(DISTINCT(lat,lon)) AS unique_location
FROM nigeria_energy_outage

SELECT COUNT(*) AS total_records,
COUNT(*) FILTER(
  WHERE lat IS NULL OR lon IS NULL
 ) AS missing_coordinates,

MIN(lat) AS minimum_latitude,
MAX(lat) AS maximum_lontitude,

MIN(lon) AS minimum_lontitude,
MAX(lon) AS maximum_lontitude
FROM nigeria_energy_outage

SELECT 
  FLOOR(lat * 100) / 100.0 AS latitude_cell,
  FLOOR(lon * 100) / 100.0 AS longitude_cell,

COUNT(*) AS total_outages,
ROUND(AVG(duration_min)::numeric,2)
 AS avg_outage_duration,

SUM(customers_affected) AS recorded_customer_impact
FROM nigeria_energy_outage
WHERE lat IS NOT NULL
 AND lon IS NOT NULL
GROUP BY 
 FLOOR(lat * 100),
 FLOOR(lon * 100)
ORDER BY total_outages DESC
LIMIT 20;

SELECT * FROM nigeria_energy_outage
LIMIT 20;

SELECT TO_DATE(start_time)