--
--
--
use DATABASE UDACITY_PRJ2;
use SCHEMA WEATHER;

--
-- Load yelp_business from Staging into table
--
copy into yelp_business(business_id,name,address,city,state,postal_code,latitude,longitude,
                        stars,review_count,is_open,attributes,categories,hours) 
from ( select $1:business_id, $1:name, $1:address, $1:city, $1:state, $1:postal_code, $1:latitude, 
              $1:longitude, $1:stars, $1:review_count, $1:is_open, $1:attributes, $1:categories,
              $1:hours			  
		from @p2_json_stage/yelp_academic_dataset_business.json.gz t);

--
-- Load yelp_checkin from Staging into table
--
copy into yelp_checkin(business_id,date) 
	from ( 	select $1:business_id, $1:date		
			from @p2_json_stage/yelp_academic_dataset_checkin.json.gz t);


--
-- Load yelp_user from Staging into table
--
copy into yelp_user(user_id, name, review_count, yelping_since, friends, useful, funny, cool, 
                    fans, elite, average_stars,
                    compliment_hot, compliment_more, compliment_profile, compliment_cute, compliment_list,
					compliment_note, compliment_plain, compliment_cool, compliment_funny, compliment_writer,
					compliment_photos) 
from ( select $1:user_id, $1:name, $1:review_count, $1:yelping_since, $1:friends, $1:useful, $1:funny, $1:cool, 
              $1:fans, $1:elite, $1:average_stars,
              $1:compliment_hot, $1:compliment_more, $1:compliment_profile, $1:compliment_cute, $1:compliment_list,
				$1:compliment_note, $1:compliment_plain, $1:compliment_cool, $1:compliment_funny, $1:compliment_writer,
				$1:compliment_photos			  
		from @p2_json_stage/yelp_academic_dataset_user.json.gz t);

--
-- Load yelp_tip from Staging into table
--
copy into yelp_tip(text, date, compliment_count, business_id, user_id) 
from ( select $1:text, $1:date, $1:compliment_count, $1:business_id,  $1:user_id			  
		from @p2_json_stage/yelp_academic_dataset_tip.json.gz t);

--
-- Load yelp_review from Staging into table
--
copy into yelp_review(review_id, user_id, business_id, stars, date, text, useful, funny, cool) 
from ( 	select $1:review_id, $1:user_id, $1:business_id, $1:stars, $1:date, $1:text, $1:useful, $1:funny, $1:cool
		from @p2_json_stage/yelp_academic_dataset_review.json.gz.001 t);		

copy into yelp_review(review_id, user_id, business_id, stars, date, text, useful, funny, cool) 
from ( 	select $1:review_id, $1:user_id, $1:business_id, $1:stars, $1:date, $1:text, $1:useful, $1:funny, $1:cool
		from @p2_json_stage/yelp_academic_dataset_review.json.gz.002 t);		

copy into yelp_review(review_id, user_id, business_id, stars, date, text, useful, funny, cool) 
from ( 	select $1:review_id, $1:user_id, $1:business_id, $1:stars, $1:date, $1:text, $1:useful, $1:funny, $1:cool
		from @p2_json_stage/yelp_academic_dataset_review.json.gz.003 t);		

--
-- Load yelp_covid_features from Staging into table
--
copy into yelp_covid_features(business_id, highlights, delivery_or_takeout, Grubhub_enabled, Call_To_Action_enabled, 
                              Request_a_Quote_Enabled, Covid_Banner, Temporary_Closed_Until, Virtual_Services_Offered) 
from ( select $1:business_id, $1:highlights, $1:"delivery or takeout", $1:"Grubhub enabled", $1:"Call To Action enabled",
              $1:"Request a Quote Enabled", $1:"Covid Banner", $1:"Temporary Closed Until", $1:"Virtual Services Offered"	  
		from @p2_json_stage/yelp_academic_dataset_covid_features.json.gz t);
		
		
