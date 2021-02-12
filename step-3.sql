-- CAMPGROUND TABLE
-----------------------------------------------

-- select name and daily fee of all campgrounds
SELECT name, daily_fee
	From campground;
	
-- select name and daily fee of all campgrounds ordered by campground name
SELECT name, daily_fee
	From campground
	Order By name;

-- select name, open from month, open to month, and daily fee of the campgrounds where daily fee is less than $100
SELECT name, open_from_mm, open_to_mm, daily_fee
	From campground
	Where daily_fee<100.0;

-- select name and daily fee of the campgrounds where the campground is open all year long
SELECT name, daily_fee
	From campground
	Where open_from_mm=1 AND open_to_mm=12;

-- PARK TABLE
-----------------------------------------------
SELECT *
	FROM park;
-- select name and description of all parks order by established date in descending order
SELECT name, description
	From park
	Order by establish_date Desc;

-- select name and description of all parks in Ohio
SELECT name, description--, location
	From park
	Where location='Ohio';

-- select name and description of all parks NOT in Ohio
SELECT name, description--, location
	From park
	Where location<>'Ohio'

-- select the total number of visitors for all parks
SELECT SUM(visitors) AS TotalVisitors
	From park;

-- select the average number of visitors for all parks
SELECT AVG(CAST(visitors AS decimal(10,2))) AS AvgVisitors
	From park;

-- SITE TABLE
-----------------------------------------------
SELECT*
	From site;
-- select all columns from site that have utilities hook up and order by max RV length with the largest coming first
SELECT*
	From site
	Where utilities=1
	Order By max_rv_length Desc;  

-- select total number of sites that have utilities hook up
SELECT COUNT(*) AS SitesWithUtilities
	From site
	Where utilities=1;


-- RESERVATION TABLE
-----------------------------------------------
SELECT *
	FROM reservation
	Order by from_date ASC;
-- select reservation id, site id, name, from date, to date of the reservations where the checkin date is between the first and last day of the current month (hard coded month is ok)
SELECT reservation_id, site_id,name, from_date, to_date
	FROM reservation
	Where from_date>=(Select	DATEFROMPARTS(YEAR(GETDATE()),month(GETDATE()),'01') AS FirstDayOfMonth) AND
	      from_date<= (Select	EOMONTH(GETDATE()) AS LastDayOfMonth); 
	--Order by from_date ASC;

-- select all columns from reservation where name includes 'Reservation'
SELECT *
	FROM reservation
	Where name LIKE ('%reservation%');

-- select the total number of reservations in the reservation table
SELECT COUNT(*) AS TotalReservations
	FROM reservation;

-- select reservation id, site id, name of the reservations where site id is in the list 9, 20, 24, 45, 46
SELECT reservation_id, site_id, name
	FROM reservation
	Where site_id IN (9, 20, 24, 45, 46);

-- select the date and number of reservations for each date orderd by from_date in ascending order
SELECT CONCAT(from_date,' to ',to_date) AS ReservationDates, COUNT(reservation_id) AS #OfReservations
	From reservation
	GROUP by CONCAT(from_date,' to ',to_date)
	ORDER by CONCAT(from_date,' to ',to_date) asc;
