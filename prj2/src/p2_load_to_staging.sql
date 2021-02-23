--
--
--
use DATABASE UDACITY_PRJ2;
use SCHEMA WEATHER;

--
-- Put USW00023169-LAS_VEGAS_MCCARRAN_INTL_AP-precipitation-inch into Staging 
--
put file:///local_disk/snowsql/p2/data/USW00023169-LAS_VEGAS_MCCARRAN_INTL_AP-precipitation-inch.csv @p2_csv_stage auto_compress=true; 

--
-- Put USW00023169-temperature-degreeF into Staging 
--
put file:///local_disk/snowsql/p2/data/USW00023169-temperature-degreeF.csv @p2_csv_stage auto_compress=true; 

--
-- Put yelp_academic_dataset_business.json into Staging 
--
put file:///local_disk/snowsql/p2/data/yelp_academic_dataset_business.json @p2_json_stage auto_compress=true; 


--
-- Put yelp_academic_dataset_checkin.json into Staging 
--
put file:///local_disk/snowsql/p2/data/yelp_academic_dataset_checkin.json @p2_json_stage auto_compress=true; 

--
-- Put yelp_academic_dataset_covid_features.json into Staging 
--
put file:///local_disk/snowsql/p2/data/yelp_academic_dataset_covid_features.json @p2_json_stage auto_compress=true; 

--
-- Put yelp_academic_dataset_user.json into Staging 
--
put file:///local_disk/snowsql/p2/data/yelp_academic_dataset_user.json @p2_json_stage auto_compress=true; 

--
-- Put yelp_academic_dataset_tip.json into Staging 
--
put file:///local_disk/snowsql/p2/data/yelp_academic_dataset_tip.json @p2_json_stage auto_compress=true;

--
-- Put yelp_academic_dataset_review.json into Staging 
--
put file:///local_disk/snowsql/p2/data/yelp_academic_dataset_review.json @p2_json_stage auto_compress=true; 



