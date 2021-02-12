-- select the park name, campground name, open_from_mm, open_to_mm & daily_fee ordered by park name and then campground name
SELECT park.name ParkName, campground.name CampName, campground.open_from_mm, campground.open_to_mm, campground.daily_fee
	FROM park
		JOIN campground ON park.park_id=campground.park_id
	ORDER by park.name, campground.name;

-- select the park name and the total number of campgrounds for each park ordered by park name
SELECT park.name, COUNT(campground.campground_id) #OfCamps
	From park
		JOIN campground ON park.park_id=campground.park_id
	GROUP by park.name
	ORDER by park.name;

-- select the park name, campground name, site number, max occupancy, accessible, max rv length, utilities where the campground name is 'Blackwoods'
SELECT park.name ParkName, campground.name CampName, site.site_number, site.max_occupancy, site.max_rv_length, site.utilities
	From park
		JOIN campground ON park.park_id=campground.park_id
		JOIN site ON campground.campground_id=site.campground_id
	WHERE campground.name='Blackwoods'; 


/*
  select park name, campground, total number of sites (column alias 'number_of_sites') ordered by park
  data should look like below:*/
  SELECT park.name park, campground.name campground, COUNT(site.site_id) number_of_sites
	From park
		JOIN campground ON park.park_id=campground.park_id
		JOIN site ON campground.campground_id=site.campground_id
	GROUP by park.name, campground.name
	ORDER by park.name ASC, number_of_sites DESC;
  /*
  -------------------------------------------------
    park				campground							number_of_sites
	Acadia				Blackwoods							12
    Acadia				Seawall								12
    Acadia				Schoodic Woods						12
    Arches				"Devil's Garden"					8
    Arches				Canyon Wren Group Site				1
    Arches				Juniper Group Site					1
    Cuyahoga Valley		The Unnamed Primitive Campsites		5
  -------------------------------------------------
*/

-- select site number, reservation name, reservation from and to date ordered by reservation from date

SELECT site.site_number, reservation.name ReservationName, CONCAT(reservation.from_date,' to ',reservation.to_date) ReservationDates
	FROM site
		JOIN reservation ON site.site_id=reservation.site_id
	ORDER by reservation.from_date ASC;


/*
  select campground name, total number of reservations for each campground ordered by total reservations desc*/
 SELECT campground.name, COUNT(reservation.reservation_id) total_reservations
	FROM campground
		JOIN site ON campground.campground_id=site.campground_id
		JOIN reservation ON site.site_id=reservation.site_id
	GROUP by site.campground_id, campground.name
	ORDER by total_reservations DESC;
 

 /* data should look like below:
  -------------------------------------------------
    name								total_reservations
	Seawall								13
    Blackwoods							9
    "Devil's Garden"					7
    Schoodic Woods						7
    Canyon Wren Group Site				4
    Juniper Group Site					4
  -------------------------------------------------
*/

SELECT *
	FROM park;

