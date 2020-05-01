/*Name: Vo Van Viet - ID:ITDSIU18043
A.Importing the Flights Database */
PRAGMA foreign_keys = ON;
	
-- Create carriers table
CREATE TABLE Carriers (
	cid varchar(10) PRIMARY KEY,
	name varchar(255)
);

-- Create months table
CREATE TABLE Months (
	mid integer PRIMARY KEY,
	month varchar(20)
); 

-- Create weekdays table
CREATE TABLE Weekdays (
	did integer PRIMARY KEY,
	day_of_week varchar(10)
);

-- Create flights table
CREATE TABLE Flights (
	fid integer PRIMARY KEY, 
	year integer, 
	month_id integer, 
	day_of_month integer,
	day_of_week_id integer,
	carrier_id varchar(10),
	flight_num integer,
	origin_city varchar(255),
	origin_state varchar(255),
	dest_city varchar(255),
	dest_state varchar(255),
	departure_delay integer,
	taxi_out integer,
	arrival_delay integer,
	canceled integer,
	actual_time integer,
	distance integer,
	FOREIGN KEY(carrier_id) REFERENCES CARRIERS(cid),
	FOREIGN KEY(month_id) REFERENCES MONTHS(mid),
	FOREIGN KEY(day_of_week_id) REFERENCES WEEKDAYS(did)
	);

-- Import the data from csv
.mode csv
.import carriers.csv Carriers
.import months.csv Months
.import weekdays.csv Weekdays
.import flights-small.csv Flights
