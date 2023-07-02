/*

Bureau of Transportation Statistics: Marketing Carrier On-Time Performance Analysis
Analyzing airline data from American Airlines, Delta Airlines, Frontier Airlines, and Southwest Airlines
Focused on Bill & Hillary Clinton National Airport (LIT) Located in Little Rock, Arkansas

Skills displayed; Join, Subqueries, Case, CTE, Cast, Aggregate Functions, Views

*/

-- Combined all tables into one query to make data accessibility easier
CREATE VIEW lr_airport_data AS
	SELECT * FROM OCT_2022_T_ONTIME_REPORTING oct
	WHERE oct.OP_UNIQUE_CARRIER IN ('AA', 'DL' ,'WN' ,'F9') AND oct.ORIGIN = 'LIT'
	UNION 
	SELECT * FROM NOV_2022_T_ONTIME_REPORTING nov
	WHERE nov.OP_UNIQUE_CARRIER IN ('AA', 'DL' ,'WN' ,'F9') AND nov.ORIGIN = 'LIT'
	UNION 
	SELECT * FROM DEC_2022_T_ONTIME_REPORTING dec
	WHERE dec.OP_UNIQUE_CARRIER IN ('AA', 'DL' ,'WN' ,'F9') AND dec.ORIGIN = 'LIT'
	UNION 
	SELECT * FROM JAN_2023_T_ONTIME_REPORTING jan
	WHERE jan.OP_UNIQUE_CARRIER IN ('AA', 'DL' ,'WN' ,'F9') AND jan.ORIGIN = 'LIT'
	UNION 
	SELECT * FROM FEB_2023_T_ONTIME_REPORTING feb
	WHERE feb.OP_UNIQUE_CARRIER IN ('AA', 'DL' ,'WN' ,'F9') AND feb.ORIGIN = 'LIT'
	UNION 
	SELECT * FROM lr_airport_data mar 
	WHERE mar.OP_UNIQUE_CARRIER IN ('AA', 'DL' ,'WN' ,'F9') AND mar.ORIGIN = 'LIT'

-- Select Data that we are going to be starting with, relevant columns for the below analysis calculations 
-- Joined tables together to get the full name of the Airline, & cancellation code descriptions
SELECT fl_date, op_unique_carrier, carriers.description, distance, origin, origin_state_nm, dest, dest_city_name, dest_state_nm, dep_delay_new, dep_del15, 
	arr_delay_new, arr_del15, carrier_delay, weather_delay, nas_delay, security_delay, late_aircraft_delay, cancelled, CANCELLATION_CODE, cancel_reason.Code
FROM lr_airport_data AS airline_data
LEFT JOIN unique_carriers AS carriers ON airline_data.OP_UNIQUE_CARRIER = carriers.Code
LEFT JOIN L_CANCELLATION AS cancel_reason ON cancel_reason.Code = airline_data.CANCELLATION_CODE
WHERE airline_data.OP_UNIQUE_CARRIER IN ('AA', 'DL' ,'WN' ,'F9') AND airline_data.ORIGIN = 'LIT'
ORDER BY airline_data.OP_UNIQUE_CARRIER DESC

-- Total number of flights by Year
SELECT YEAR(airline_data.FL_DATE) as Year ,carriers.Description AS airline, COUNT(airline_data.flights) AS '# of Flights in airline_data' 
FROM lr_airport_data AS airline_data
LEFT JOIN unique_carriers AS carriers ON airline_data.OP_UNIQUE_CARRIER = carriers.Code
LEFT JOIN L_CANCELLATION AS cancel_reason ON cancel_reason.Code = airline_data.CANCELLATION_CODE
WHERE airline_data.OP_UNIQUE_CARRIER IN ('AA', 'DL' ,'WN' ,'F9') AND airline_data.ORIGIN = 'LIT'
GROUP BY YEAR(airline_data.FL_DATE), carriers.Description, OP_UNIQUE_CARRIER
ORDER BY YEAR(airline_data.FL_DATE) ASC

-- Number of flights to each State
SELECT YEAR(airline_data.FL_DATE) as Year, carriers.description AS airline, dest_state_nm, COUNT(dest_state_nm) AS 'Number of Flights'
FROM lr_airport_data AS airline_data
LEFT JOIN unique_carriers AS carriers ON airline_data.OP_UNIQUE_CARRIER = carriers.Code
LEFT JOIN L_CANCELLATION AS cancel_reason ON cancel_reason.Code = airline_data.CANCELLATION_CODE
WHERE airline_data.OP_UNIQUE_CARRIER IN ('AA', 'DL' , 'WN' ,'F9') AND airline_data.ORIGIN = 'LIT'
GROUP BY YEAR(airline_data.FL_DATE), OP_UNIQUE_CARRIER, carriers.Description, DEST_STATE_NM;

-- Most frequently visited state for each Airline (CTE)
WITH max_counts AS (
    SELECT airline, dest_state_nm, MAX(destination) AS max_dest
    FROM (
        SELECT COUNT(dest_state_nm) AS destination, dest_state_nm, carriers.description AS airline 
        FROM lr_airport_data AS airline_data
        LEFT JOIN unique_carriers AS carriers ON airline_data.OP_UNIQUE_CARRIER = carriers.Code
        LEFT JOIN L_CANCELLATION AS cancel_reason ON cancel_reason.Code = airline_data.CANCELLATION_CODE
        WHERE airline_data.OP_UNIQUE_CARRIER IN ('AA', 'DL', 'UA', 'WN', 'B6', 'NK', 'F9') AND airline_data.ORIGIN = 'LIT'
        GROUP BY dest_state_nm, OP_UNIQUE_CARRIER, carriers.description
    ) AS count_dest
    GROUP BY airline, dest_state_nm
)
SELECT mc.airline, mc.dest_state_nm AS 'State', mc.max_dest AS 'Total flights'
FROM max_counts AS mc
JOIN (
    SELECT airline, MAX(max_dest) AS max_count
    FROM max_counts
    GROUP BY airline
) AS max_airline ON mc.airline = max_airline.airline AND mc.max_dest = max_airline.max_count
ORDER BY 'Total flights' DESC

--Number of Departure Delays 15 minutes or more 
SELECT airline_data.op_unique_carrier, carriers.description, SUM(CAST (DEP_DEL15 AS INT)) AS total_departure_delays, ROUND(AVG(DEP_DELAY_NEW), 2) AS avg_length_delays_mins, ROUND((AVG(DEP_DELAY_NEW) / 60), 2) AS avg_length_delays_hours
FROM lr_airport_data AS airline_data
LEFT JOIN unique_carriers AS carriers ON airline_data.OP_UNIQUE_CARRIER = carriers.Code
LEFT JOIN L_CANCELLATION AS cancel_reason ON cancel_reason.Code = airline_data.CANCELLATION_CODE
WHERE airline_data.OP_UNIQUE_CARRIER IN ('AA', 'DL' ,'WN' ,'F9') AND airline_data.ORIGIN = 'LIT' AND DEP_DELAY_NEW >= 15
GROUP BY airline_data.OP_UNIQUE_CARRIER, carriers.Description

--Number of Arrival Delays 15 minutes or more 
SELECT airline_data.op_unique_carrier, carriers.description, SUM(CAST (ARR_DEL15 AS INT)) AS total_arrival_delays, ROUND(AVG(ARR_DELAY_NEW), 2) AS avg_length_delays_mins, ROUND((AVG(ARR_DELAY_NEW) / 60), 2) AS avg_length_delays_hours
FROM lr_airport_data AS airline_data
LEFT JOIN unique_carriers AS carriers ON airline_data.OP_UNIQUE_CARRIER = carriers.Code
LEFT JOIN L_CANCELLATION AS cancel_reason ON cancel_reason.Code = airline_data.CANCELLATION_CODE
WHERE airline_data.OP_UNIQUE_CARRIER IN ('AA', 'DL' ,'WN' ,'F9') AND airline_data.ORIGIN = 'LIT' AND ARR_DELAY_NEW >= 15
GROUP BY airline_data.OP_UNIQUE_CARRIER, carriers.Description

-- Count of Delay Reasons for each Carrier 
-- delay_reason column give the type of delay. 1 = Carrier Delay, 2 = Weather Delay, 3= Security Delay, 4= Late Aircraft Delay
SELECT
    airline_data.op_unique_carrier, carriers.description,
    CASE
        WHEN CARRIER_DELAY > 0 THEN 'Carrier Delay'
        WHEN WEATHER_DELAY > 0 THEN 'Weather Delay'
        WHEN SECURITY_DELAY > 0 THEN 'Security'
        WHEN LATE_AIRCRAFT_DELAY > 0 THEN 'Late Aircraft Delay'
        ELSE 'Unknown'
    END AS delay_reason, COUNT(*) AS delay_reason_count
FROM lr_airport_data AS airline_data
LEFT JOIN unique_carriers AS carriers 
	ON airline_data.OP_UNIQUE_CARRIER = carriers.Code
LEFT JOIN L_CANCELLATION AS cancel_reason 
	ON cancel_reason.Code = airline_data.CANCELLATION_CODE
WHERE airline_data.OP_UNIQUE_CARRIER IN ('AA', 'DL', 'UA', 'WN', 'B6', 'NK', 'F9') 
	AND airline_data.ORIGIN = 'LIT'
    AND (airline_data.CARRIER_DELAY > 0 OR airline_data.WEATHER_DELAY > 0 OR airline_data.SECURITY_DELAY > 0 OR airline_data.LATE_AIRCRAFT_DELAY > 0)
GROUP BY airline_data.op_unique_carrier, carriers.description,
    CASE
        WHEN CARRIER_DELAY > 0 THEN 'Carrier Delay'
        WHEN WEATHER_DELAY > 0 THEN 'Weather Delay'
        WHEN SECURITY_DELAY > 0 THEN 'Security'
        WHEN LATE_AIRCRAFT_DELAY > 0 THEN 'Late Aircraft Delay'
        ELSE 'Unknown'
    END
ORDER BY description, delay_reason_count DESC


-- Number of cancellations (Having clause)
SELECT carriers.description, COUNT(cancelled) AS number_of_cancellations, cancel_reason.Description
FROM lr_airport_data AS airline_data
LEFT JOIN unique_carriers AS carriers ON airline_data.OP_UNIQUE_CARRIER = carriers.Code
LEFT JOIN L_CANCELLATION AS cancel_reason ON cancel_reason.Code = airline_data.CANCELLATION_CODE
GROUP BY airline_data.op_unique_carrier, origin, carriers.description, cancellation_code, cancel_reason.Description
HAVING airline_data.OP_UNIQUE_CARRIER IN ('AA', 'DL' ,'WN' ,'F9') AND airline_data.ORIGIN = 'LIT' AND CANCELLATION_CODE IS NOT NULL
ORDER BY carriers.description

-- Average distance traveled per flight in miles 
SELECT YEAR(airline_data.FL_DATE) as Year, carriers.description, ROUND(AVG(distance), 2) AS distance_miles
FROM lr_airport_data AS airline_data
LEFT JOIN unique_carriers AS carriers ON airline_data.OP_UNIQUE_CARRIER = carriers.Code
LEFT JOIN L_CANCELLATION AS cancel_reason ON cancel_reason.Code = airline_data.CANCELLATION_CODE
WHERE airline_data.OP_UNIQUE_CARRIER IN ('AA', 'DL' ,'WN' ,'F9') AND airline_data.ORIGIN = 'LIT'
GROUP BY YEAR(airline_data.FL_DATE), OP_UNIQUE_CARRIER, carriers.Description
ORDER BY year, airline_data.OP_UNIQUE_CARRIER DESC

 -- Total Number of Incidents
SELECT YEAR(airline_data.FL_DATE) as Year, carriers.Description AS airline, COUNT(*) as total_incidents
FROM lr_airport_data AS airline_data
LEFT JOIN unique_carriers AS carriers ON airline_data.OP_UNIQUE_CARRIER = carriers.Code
LEFT JOIN L_CANCELLATION AS cancel_reason ON cancel_reason.Code = airline_data.CANCELLATION_CODE
WHERE airline_data.OP_UNIQUE_CARRIER IN ('AA', 'DL' ,'WN' ,'F9') AND airline_data.ORIGIN = 'LIT'
	AND (CANCELLED LIKE '1.00' OR ARR_DELAY > 0 OR DEP_DELAY > 0) 
GROUP BY YEAR(airline_data.FL_DATE), carriers.Description
ORDER BY year

