--
--
--
use DATABASE UDACITY_PRJ2;

--
-- provide SQL queries that report business name, temperature, precipitation, and ratings.
--
SELECT   r.review_date
       , b.name
       , r.stars
       , p.precipitation, p.precipitation_normal
       , t.t_min , t.t_max, t.t_min_normal, t.t_max_normal
  FROM  UDACITY_PRJ2.DWH.FACTS_REVIEW as f
        JOIN UDACITY_PRJ2.DWH.DIM_YELP_REVIEW as r on f.review_id=r.review_id
        JOIN UDACITY_PRJ2.DWH.DIM_YELP_BUSINESS as b on f.business_id = b.business_id
        JOIN UDACITY_PRJ2.DWH.DIM_CLIMATE_PRECIPITATION as p on f.review_date = p.prep_date
        JOIN UDACITY_PRJ2.DWH.DIM_CLIMATE_TEMPERATURE as t  on f.review_date = t.temp_date
 WHERE b.state = 'NV'   
	   