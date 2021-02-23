--
--
--
use DATABASE UDACITY_PRJ2;
use SCHEMA WEATHER;

create or replace table raw_source (src variant);
  
copy into raw_source from @p2_json_stage/yelp_academic_dataset_checkin.json.gz;
--
-- Load yelp_checking from staging table into ODS table
--
create or replace table yelp_checkin(business_id string, date string) 
as select src:business_id::string as business_id, 
		 src:date::string as date			  
	from raw_source ,  lateral flatten( input => src );
		
--
--
--
create or replace table raw_source (src variant);

-- Load staging file into staging table
copy into raw_source from @p2_json_stage/yelp_academic_dataset_tip.json.gz;

--
-- Load yelp_checking from staging table into ODS table
--
create or replace table yelp_tip(text string, date string, compliment_count integer, business_id string, user_id string) 
as select src:text::string as text, 
		  src:date::string as date,
			src:compliment_count::string as compliment_count,
			src:business_id::string as business_id,
			src:user_id::string as user_id
	from raw_source ,  lateral flatten( input => src );
		
