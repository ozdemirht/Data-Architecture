
--
-- Create Yelp Tables
--

use DATABASE UDACITY_PRJ2;
use SCHEMA WEATHER;

--
-- Create yelp_business table
--
create or replace table yelp_business(
  -- string, 22 character unique string business id
  business_id string primary key,
  -- string, the business's name
  name string, 
  -- string, the full address of the business
  address string,
  -- string, the city
  city string,
  -- string, 2 character state code, if applicable
  state string,
  --  string, the postal code
  postal_code string,
  -- float, latitude
  latitude float,
  -- float, longitude
  longitude float,
  -- float, star rating, rounded to half-stars
  stars float,
  -- integer, number of reviews
  review_count integer,
  -- integer, 0 or 1 for closed or open, respectively
  is_open integer, 
  -- object, business attributes to values. note: some attribute values might be objects
  attributes object,
  -- an array of strings of business categories
  categories array,
  -- an object of key day to value hours, hours are using a 24hr clock
  hours variant
);

--
-- Create yelp_user table
--
create or replace table yelp_user(
  user_id string primary key,
  -- string, the user's first name
  name string,            
  -- integer, the number of reviews they've written 
  review_count integer,   
  -- string, when the user joined Yelp, formatted like YYYY-MM-DD
  yelping_since string,   
  -- array of strings, an array of the user's friend as user_ids
  friends array,        
  -- integer, number of useful votes sent by the user  
  useful integer,             
  -- integer, number of funny votes sent by the user
  funny integer,      
  -- integer, number of cool votes sent by the user        
  cool integer,  
  -- integer, number of fans the user has             
  fans integer,    
  -- array of integers, the years the user was elite           
  elite array,    
  -- float, average rating of all reviews            
  average_stars float,       
  -- integer, number of hot compliments received by the user 
  compliment_hot integer,    
  --  integer, number of more compliments received by the user
  compliment_more integer,    
  -- integer, number of profile compliments received by the user
  compliment_profile integer, 
  -- integer, number of cute compliments received by the user
  compliment_cute integer, 
  -- integer, number of list compliments received by the user  
  compliment_list integer,  
  -- integer, number of note compliments received by the user  
  compliment_note integer,    
  -- integer, number of plain compliments received by the user
  compliment_plain integer,   
  -- integer, number of cool compliments received by the user
  compliment_cool integer,    
  -- integer, number of funny compliments received by the user
  compliment_funny integer,   
  -- integer, number of writer compliments received by the user
  compliment_writer integer,  
  -- integer, number of photo compliments received by the user
  compliment_photos integer   
);

--
-- Create yelp_review table
--
create or replace table yelp_review(
  -- string, 22 character unique review id
  review_id 	string primary key,
  -- string, 22 character unique user id, maps to the user in user.json
  user_id 		string, 
  -- string, 22 character business id, maps to business in business
  business_id 	string,
  -- integer, star rating
  stars 		integer,
  -- string, date formatted YYYY-MM-DD
  review_date 	date,
  review_ts 	timestamp, 
  -- string, the review itself
  text 			string,
  -- integer, number of useful votes received
  useful 		integer,
  -- integer, number of funny votes received
  funny 		integer,
  -- integer, number of cool votes received
  cool 			integer,
  -- constraints
  constraint fkey_1 foreign key(business_id) references yelp_business (business_id) not enforced,
  constraint fkey_2 foreign key(user_id) references yelp_user (user_id) not enforced
);


--
-- Create yelp_checkin table
--
create or replace table yelp_checkin(
    -- string, 22 character business id, maps to business in business.json
    business_id string,
    -- string which is a comma-separated list of timestamps for each checkin, each with format YYYY-MM-DD HH:MM:SS
    date string,
 	-- constraints
	constraint fkey_1 foreign key(business_id) references yelp_business (business_id) not enforced
);

--
-- Create yelp_tip table
--
create or replace table yelp_tip(
    -- string, text of the tip
    text string,

    -- string, when the tip was written, formatted like YYYY-MM-DD
    date string,

    -- integer, how many compliments it has
	compliment_count integer,

    -- string, 22 character business id, maps to business in business.json
    business_id string,

    -- string, 22 character unique user id, maps to the user in user.json
    user_id string,
	-- constraints
	constraint fkey_1 foreign key(business_id) references yelp_business (business_id) not enforced,
    constraint fkey_2 foreign key(user_id) references yelp_user (user_id) not enforced
);


--
-- Create covid_features
-- 
create or replace table yelp_covid_features (
    -- string, 22 character unique string business id
    business_id string primary key,
    -- string, 
    highlights string,
    -- string, boolean, FALSE
    delivery_or_takeout string,
    -- string, boolean, FALSE 
    Grubhub_enabled string,
    -- string, boolean { FALSE, TRUE } 
    Call_To_Action_enabled string,
    -- string, boolean { FALSE, TRUE } 
    Request_a_Quote_Enabled string,
    -- string, text 
    Covid_Banner string,
    -- string, boolean { FALSE, TRUE } 
    Temporary_Closed_Until string,
    -- string, { 'offers_virtual_tours',  } 
    Virtual_Services_Offered string,
	-- constraints
	constraint fkey_1 foreign key(business_id) references yelp_business (business_id) not enforced
);


--
-- Create climate_precipitation
-- 
create or replace table climate_precipitation (
    -- integer, 
    prep_date date not null,
    prep_ts   timestamp not null,
    -- string, T=?
    precipitation string,
    -- float, 
    precipitation_normal float
);

--
-- Create climate_precipitation
-- 
create or replace table climate_temperature (
    -- date, 
    temp_date date not null,
    temp_ts timestamp not null,
    -- string, 
    min string,
    -- string, 
    max string,
    -- float, 
    normal_min float,
    -- float, 
    normal_max float
);

