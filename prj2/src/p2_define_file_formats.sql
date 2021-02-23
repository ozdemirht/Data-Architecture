---
--
--
use DATABASE UDACITY_PRJ2;
use SCHEMA WEATHER;

--
-- Define CSV File Format
--
create or replace file format p2_csv_format 
 type = csv 
 FIELD_DELIMITER = ',' 
 RECORD_DELIMITER = '\n' 
 skip_header = 1 
 null_if = ('NULL', 'null') 
 empty_field_as_null = true 
 compression = gzip 
 error_on_column_count_mismatch=false;

--
-- Define JSON File Format
--
create or replace file format p2_json_format 
  type = 'JSON' 
  strip_outer_array=true;


