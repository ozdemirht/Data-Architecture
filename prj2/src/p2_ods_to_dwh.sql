--
--
--
use role accountadmin;
use DATABASE UDACITY_PRJ2;
use SCHEMA WEATHER;

--
--
--
DROP VIEW IF EXISTS UDACITY_PRJ2.WEATHER.V_CLIMATE_TEMPERATURE ;
DROP VIEW IF EXISTS UDACITY_PRJ2.WEATHER.V_CLIMATE_PRECIPITATION ;
DROP VIEW IF EXISTS UDACITY_PRJ2.WEATHER.V_CLIMATE_TEMPERATURE_DAY ;
DROP VIEW IF EXISTS UDACITY_PRJ2.WEATHER.V_CLIMATE_PRECIPITATION_DAY ;

--
--
--
create or replace view UDACITY_PRJ2.WEATHER.V_CLIMATE_TEMPERATURE (temp_ts, temp_date, t_min,t_max, t_min_normal, t_max_normal) 
  as ( select dateadd(year,35,t.temp_ts) as temp_ts,
              dateadd(year,35,t.temp_date) as temp_date, 
              t.min, t.max, t.normal_min, t.normal_max
         from UDACITY_PRJ2.WEATHER.CLIMATE_TEMPERATURE as t
     );

create or replace view UDACITY_PRJ2.WEATHER.V_CLIMATE_TEMPERATURE_DAY (temp_date, t_min, t_max, t_min_normal, t_max_normal) 
  as ( select t.temp_date, MIN(t.t_min), MAX(t.t_max), MIN(t.t_min_normal), MAX(t.t_max_normal)
			from UDACITY_PRJ2.WEATHER.V_CLIMATE_TEMPERATURE as t
				group by 1
     );

create or replace view UDACITY_PRJ2.WEATHER.V_CLIMATE_PRECIPITATION (prep_ts, prep_date, precipitation, precipitation_normal) 
  as ( select dateadd(year,35,p.prep_ts) as prep_ts,
              dateadd(year,35,p.prep_date) as prep_date, 
              p.precipitation::float, p.precipitation_normal
         from UDACITY_PRJ2.WEATHER.CLIMATE_PRECIPITATION as p
        where precipitation is not NULL and precipitation!='T'
     );

create or replace view UDACITY_PRJ2.WEATHER.V_CLIMATE_PRECIPITATION_DAY (prep_date, precipitation, precipitation_normal) 
  as ( select p.prep_date, AVG(p.precipitation), AVG(p.precipitation_normal)
			from UDACITY_PRJ2.WEATHER.V_CLIMATE_PRECIPITATION as p
				GROUP BY 1
		);


use SCHEMA DWH;
--
--
--
create or replace table UDACITY_PRJ2.DWH.DIM_CLIMATE_TEMPERATURE (
  temp_date date primary key, 
  t_min float, 
  t_max float,
  t_min_normal float, 
  t_max_normal float
);

insert into UDACITY_PRJ2.DWH.DIM_CLIMATE_TEMPERATURE(temp_date, t_min, t_max, t_min_normal, t_max_normal) 
    select t.temp_date, t.t_min, t.t_max, t.t_min_normal, t.t_max_normal
         from UDACITY_PRJ2.WEATHER.V_CLIMATE_TEMPERATURE_DAY as t;
     
--
--
--
create or replace table UDACITY_PRJ2.DWH.DIM_CLIMATE_PRECIPITATION (
  prep_date date primary key, 
  precipitation float, 
  precipitation_normal float
);

insert into UDACITY_PRJ2.DWH.DIM_CLIMATE_PRECIPITATION (prep_date, precipitation, precipitation_normal) 
    select p.prep_date, p.precipitation, p.precipitation_normal
			from UDACITY_PRJ2.WEATHER.V_CLIMATE_PRECIPITATION_DAY as p;

--
--
--
create or replace table UDACITY_PRJ2.DWH.DIM_YELP_BUSINESS (
  business_id 	string primary key, 
  name 			string,
  state         string
);

insert into UDACITY_PRJ2.DWH.DIM_YELP_BUSINESS (business_id, name,state) 
   select b.business_id, b.name, b.state from UDACITY_PRJ2.WEATHER.YELP_BUSINESS as b;
--
--
--
create or replace table UDACITY_PRJ2.DWH.DIM_YELP_USER (
  user_id 	string primary key, 
  name 		string
);
insert into UDACITY_PRJ2.DWH.DIM_YELP_USER (user_id, name) 
   select u.user_id, u.name from UDACITY_PRJ2.WEATHER.YELP_USER as u;

--
--
--
create or replace table UDACITY_PRJ2.DWH.DIM_YELP_REVIEW (
  review_id string primary key, 
  stars 	integer,
  review_date date
);
insert into UDACITY_PRJ2.DWH.DIM_YELP_REVIEW (review_id, stars, review_date) 
   select r.review_id, r.stars, r.review_date from UDACITY_PRJ2.WEATHER.YELP_REVIEW as r;

--
-- Create facts_review table
--
create or replace table UDACITY_PRJ2.DWH.FACTS_REVIEW(
  -- string, 22 character unique review id
  review_id 	string primary key,
  -- string, 22 character unique user id, maps to the user in user.json
  user_id 		string, 
  -- string, 22 character business id, maps to business in business
  business_id 	string,
  -- string, date formatted YYYY-MM-DD
  review_date 	date,
  -- constraints
  constraint fkey_1 foreign key(business_id) 
					references UDACITY_PRJ2.DWH.DIM_YELP_BUSINESS (business_id) not enforced,
  constraint fkey_2 foreign key(user_id) 
					references UDACITY_PRJ2.DWH.DIM_YELP_USER (user_id) not enforced,
  constraint fkey_3 foreign key(review_id) 
					references UDACITY_PRJ2.DWH.DIM_YELP_REVIEW (review_id) not enforced
);
  
insert into UDACITY_PRJ2.DWH.FACTS_REVIEW (review_id, user_id, business_id, review_date) 
    select r.review_id, r.user_id, r.business_id, r.review_date
        from UDACITY_PRJ2.WEATHER.YELP_REVIEW r;
