/*
 STEP ONE: Add a new park with the following data:
  ------------------------------
  name: Ohiopyle State Park
  location: Pennsylvania
  establish date: 1965-01-01
  area: 19052
  visitors: 1000000
  description: Ohiopyle State Park is a Pennsylvania state park on 19,052 acres in Dunbar, Henry Clay and Stewart Townships, Fayette County, Pennsylvania in the United States. The focal point of the park is the more than 14 miles of the Youghiogheny River Gorge that passes through the park.
  ------------------------------
*/

SELECT *
	FROM park;

Insert Into park(name,location,establish_date,area,visitors,description)
	Values ('Ohiopyle State Park',
			'Pennsylvania',
			(CAST('1965-01-01' AS date)),
			19052,
			1000000,
			'Ohiopyle State Park is a Pennsylvania state park on 19,052 acres in Dunbar, Henry Clay and Stewart Townships, Fayette County, Pennsylvania in the United States. The focal point of the park is the more than 14 miles of the Youghiogheny River Gorge that passes through the park.'
			);

/*
  STEP TWO: You just found out that there was an error with the park data. Please update the park visitors to 1.5 million anually.

*/

UPDATE park
	SET visitors= 1500000
	WHERE name='Ohiopyle State Park';

/*
 STEP THREE: Insert new campground with the following data:
  ------------------------------------------------------------
  park_id: 4 (this should be the id of the new park you just added)
  name: Youghiogheny
  open_from_mm: 01
  open_to_mm: 12
  daily_fee: 95.00
  ------------------------------------------------------------
*/

Select *
	From campground;
-- campground.park_id
Select park_id	From park	where name='Ohiopyle State Park'

Insert Into campground(park_id,name, open_from_mm,open_to_mm,daily_fee)
	Values ((Select park_id	From park	where name='Ohiopyle State Park'),
			'Youghiogheny',
			01,
			12,
			95.00);

/*
 STEP FOUR: Insert 3 new sites with the following data:
 ------------------------------------------------------------
  site_number: 623, campground_id: 8
  site_number: 624, campground_id: 8
  site_number: 625, campground_id: 8
 ------------------------------------------------------------

 > campground_id 8 should be the id of the campground you just added 'Youghiogheny'
*/
--Check
Select *
From site
WHERE site_number IN (623,624,625,1);
-- campground_id
SELECT campground_id	FROM campground	Where name='Youghiogheny'
-- Insert
Insert Into site(site_number,campground_id)
	Values  (623,(SELECT campground_id	FROM campground	Where name='Youghiogheny')),
			(624,(SELECT campground_id	FROM campground	Where name='Youghiogheny')),
			(625,(SELECT campground_id	FROM campground	Where name='Youghiogheny'));
				
/*
 STEP FIVE: Insert 3 reservations, 1 for each site with the following data:
------------------------------------------------------------------------------------
  site_id: 52, name: Wayne Family, from_date: today + 10 days, to_date: today + 20 days
  site_id: 53, name: Parker Family, from_date: today + 11 days, to_date: today + 20 days
  site_id: 54, name: Kent Family, from_date: today + 12 days, to_date: today + 20 days
------------------------------------------------------------------------------------
*/
--Check
Select *
From reservation
WHERE site_id IN (52,53,54,1);
-- site_id
SELECT site_id	FROM site	Where site_number=623
SELECT site_id	FROM site	Where site_number=624
SELECT site_id	FROM site	Where site_number=625
-- ADDING DATE
Select DATEADD (day,10, getdate())
-- CAST
SELECT CAST(GETDATE() AS DATE)

-- Insert
Insert Into reservation(site_id,name,from_date,to_date)
	Values  ((SELECT site_id	FROM site	Where site_number=623),'Wayne Family',(select DATEADD(Day,10,CAST(GETDATE() AS DATE))),(select DATEADD(Day,20,CAST(GETDATE() AS DATE)))),
			((SELECT site_id	FROM site	Where site_number=624),'Parker Family',(select DATEADD(Day,11,CAST(GETDATE() AS DATE))),(select DATEADD(Day,20,CAST(GETDATE() AS DATE)))),
			((SELECT site_id	FROM site	Where site_number=625),'Kent Family',(select DATEADD(Day,12,CAST(GETDATE() AS DATE))),(select DATEADD(Day,20,CAST(GETDATE() AS DATE))));

/*
 STEP SIX: The Wayne Family called and asked if they could change their reservation to today. Update the from_date to today and the to_date to a week from today.
*/

-- Check
SELECT *
	FROM reservation
	WHERE name='Wayne Family'
-- Update
UPDATE reservation
	SET from_date=(CAST(GETDATE() AS Date)),
		to_date=(SELECT DATEADD(Day,7,CAST(GETDATE() AS Date)))
	WHERE reservation_id=(SELECT reservation_id FROM reservation JOIN site ON reservation.site_id=site.site_id WHERE site.site_id=52)
		AND name='Wayne Family'



/*
 STEP SEVEN: The Kent family called and they would like to cancel their reservation. Delete the reservation for Kent Family.
*/
-- Check
SELECT *
	From reservation
	WHERE name='Kent Family'
-- Delete
Delete
	From reservation
	Where name='Kent Family' AND reservation_id=(SELECT reservation_id FROM reservation JOIN site ON reservation.site_id=site.site_id WHERE site.site_id=54)


