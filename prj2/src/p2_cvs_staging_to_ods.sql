--
--
--
use DATABASE UDACITY_PRJ2;
use SCHEMA WEATHER;

--
-- Load precipitation data from staging file into climate_precipitation table
--
copy into climate_precipitation (prep_date,prep_ts,precipitation,precipitation_normal) 
     from ( select try_to_timestamp(t.$1),try_to_timestamp(t.$1),t.$2,t.$3 from @p2_csv_stage/USW00023169-LAS_VEGAS_MCCARRAN_INTL_AP-precipitation-inch.csv.gz t) 
	      file_format = (format_name = p2_csv_format) on_error = 'skip_file';


--
-- Load temperature data from staging file into climate_temperature table
--
copy into climate_temperature (temp_date, temp_ts,min,max,normal_min, normal_max) 
     from (select try_to_timestamp(t.$1), try_to_timestamp(t.$1),t.$2,t.$3,t.$4,t.$5 
			from @p2_csv_stage/USW00023169-temperature-degreeF.csv.gz t) 
	      file_format = (format_name = p2_csv_format) on_error = 'skip_file';
