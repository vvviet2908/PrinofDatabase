/* Name:Vo Van Viet - ID: ITDSIU18043
B.SQL Queries
*/
-- Question 1:
-- Find the distinct flight numbers of all flights from Seattle to Boston by Alaska Airlines Inc. on Mondays.
-- Also notice that, in the database, the city names include the state. 
-- So Seattle appears as Seattle WA. [3 rows] 

SELECT DISTINCT f.flight_num
FROM Flights AS f, Carriers AS c, Weekdays AS w
WHERE f.carrier_id = c.cid
AND f.day_of_week_id = w.did
AND f.origin_city = 'Seattle WA'
AND f.dest_city = 'Boston MA'
AND c.name = 'Alaska Airlines Inc.'
AND w.day_of_week = 'Monday';

--Question2: 
--Find all flights from Seattle to Boston on July 15th 2015. 
--Search only for itineraries that have one stop. Both legs of the flight must have occurred on the same day and must be with the same carrier. 
--The total flight time (actual_time) of the entire itinerary should be less than 7 hours (but notice that actual_time is in minutes). 
--For each itinerary, the query should return the name of the carrier, the first flight number, the origin and destination of that first flight, 
--the flight time, the second flight number, the origin and destination of the second flight, the second flight time, and finally the total flight time. [488 rows] 

--Also, put the first 20 rows of your result right after your query as a comment
SELECT c.name,f1.flight_num, f1.origin_city, f1.dest_city, f1.actual_time, f2.flight_num, f2.origin_city,
	f2.dest_city, f2.actual_time, f1.actual_time + f2.actual_time
FROM Flights AS f1, Flights AS f2, Carriers as c, Months as m
WHERE f2.carrier_id = c.cid
AND f1.carrier_id = c.cid
AND f1.month_id = m.mid
-- Specify origin and final destination and that the transfer was at the same city
AND f1.origin_city = 'Seattle WA'
AND f2.dest_city = 'Boston MA'
AND f1.dest_city = f2.origin_city
-- Ensure the carriers are the same between transfers
AND f1.carrier_id = f2.carrier_id
-- Specify the date As July 15 2015
AND f2.year = 2015
AND f1.year = 2015
AND m.month = 'July'
AND f1.day_of_month = 15
AND f2.day_of_month = 15
-- Flight time less than 7 hours
AND f1.actual_time + f2.actual_time < 420;


/*
The first twenty rows of the 488 results
name                    flight_num  origin_city  dest_city   actual_time  flight_num  origin_city  dest_city   actual_time  f1.actual_time + f2.actual_time
----------------------  ----------  -----------  ----------  -----------  ----------  -----------  ----------  -----------  -------------------------------
American Airlines Inc.  42          Seattle WA   Chicago IL  228          26          Chicago IL   Boston MA   150          378
American Airlines Inc.  42          Seattle WA   Chicago IL  228          186         Chicago IL   Boston MA   137          365
American Airlines Inc.  42          Seattle WA   Chicago IL  228          288         Chicago IL   Boston MA   137          365
American Airlines Inc.  42          Seattle WA   Chicago IL  228          366         Chicago IL   Boston MA   150          378
American Airlines Inc.  42          Seattle WA   Chicago IL  228          1205        Chicago IL   Boston MA   128          356
American Airlines Inc.  42          Seattle WA   Chicago IL  228          1240        Chicago IL   Boston MA   130          358
American Airlines Inc.  42          Seattle WA   Chicago IL  228          1299        Chicago IL   Boston MA   133          361
American Airlines Inc.  42          Seattle WA   Chicago IL  228          1435        Chicago IL   Boston MA   133          361
American Airlines Inc.  42          Seattle WA   Chicago IL  228          1557        Chicago IL   Boston MA   122          350
American Airlines Inc.  42          Seattle WA   Chicago IL  228          2503        Chicago IL   Boston MA   127          355
American Airlines Inc.  44          Seattle WA   New York N  322          84          New York NY  Boston MA   74           396
American Airlines Inc.  44          Seattle WA   New York N  322          199         New York NY  Boston MA   80           402
American Airlines Inc.  44          Seattle WA   New York N  322          235         New York NY  Boston MA   91           413
American Airlines Inc.  44          Seattle WA   New York N  322          1443        New York NY  Boston MA   80           402
American Airlines Inc.  44          Seattle WA   New York N  322          2118        New York NY  Boston MA                322
American Airlines Inc.  44          Seattle WA   New York N  322          2121        New York NY  Boston MA   74           396
American Airlines Inc.  44          Seattle WA   New York N  322          2122        New York NY  Boston MA   65           387
American Airlines Inc.  44          Seattle WA   New York N  322          2126        New York NY  Boston MA   60           382
American Airlines Inc.  44          Seattle WA   New York N  322          2128        New York NY  Boston MA   83           405
American Airlines Inc.  44          Seattle WA   New York N  322          2131        New York NY  Boston MA   70           392
*/

-- Question 3
--Find the day of the week with the longest average arrival delay. 
--Return the name of the day and the average delay. [1 row]
SELECT w.day_of_week, avg(f.arrival_delay)
FROM Weekdays AS w, Flights AS f
WHERE f.day_of_week_id = w.did
GROUP BY w.day_of_week
ORDER BY avg(f.arrival_delay) DESC
LIMIT 1;

-- Question 4
--Find the names of all airlines that ever flew more than 1000 flights in one day. Return only the names. 
--Do not return any duplicates. [11 rows] 
SELECT DISTINCT c.name
FROM Carriers AS c, Flights AS f
WHERE f.carrier_id = c.cid
GROUP BY c.name, f.day_of_month, f.year, f.month_id
HAVING count(*) > 1000;

-- Question 5
 --Find all airlines that had more than 0.5 percent of their flights out of Seattle be canceled. 
 --Return the name of the airline and the percentage of canceled flight out of Seattle. 
 --Order the results by the percentage of canceled flights in ascending order. [6 rows] 
SELECT c.name, (sum(f.canceled) * 1.0) / (count(*) * 1.0)
FROM Carrier AS c, Flights AS f
WHERE f.carrier_id = c.cid
AND f.origin_city = 'Seattle WA'
GROUP BY c.name
HAVING (sum(f.canceled) * 1.0) / (count(*) * 1.0) > .005
ORDER BY (sum(f.canceled) * 1.0) / (count(*) * 1.0) ASC;