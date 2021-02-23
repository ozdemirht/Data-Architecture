--
--
--
use DATABASE UDACITY_PRJ2;
use SCHEMA WEATHER;


--
-- The SQL query should include a 
-- WHERE clause that joins the review, temperature, and precipitation tables on the date field.
--
SELECT   r.review_date
       , b.name
       , r.stars
       , p.precipitation_normal
       , t.normal_min, t.normal_max
  FROM  UDACITY_PRJ2.WEATHER.YELP_REVIEW as r 
        , UDACITY_PRJ2.WEATHER.YELP_BUSINESS as b
        , (SELECT DATEADD('year',35,t1.PREP_DATE) as PREP_DATE
                , AVG(t1.PRECIPITATION_NORMAL) as PRECIPITATION_NORMAL
           FROM UDACITY_PRJ2.WEATHER.CLIMATE_PRECIPITATION as t1 GROUP BY 1) as p
        , (SELECT DATEADD(year,35,t1.TEMP_DATE) as TEMP_DATE
                  , MIN(t1.normal_min) as normal_min
                  , MAX(t1.normal_max) as normal_max 
           FROM UDACITY_PRJ2.WEATHER.CLIMATE_TEMPERATURE as t1 GROUP BY TEMP_DATE) as t
 WHERE b.state = 'NV' 
       and r.business_id = b.business_id 
       and r.review_date = p.prep_date 
       and r.review_date = t.temp_date

	