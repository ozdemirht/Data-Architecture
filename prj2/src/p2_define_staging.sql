--
--
--
use DATABASE UDACITY_PRJ2;
use SCHEMA WEATHER;

--
-- Define Staging for JSON File
--
create or replace stage p2_json_stage file_format = p2_json_format ;


--
-- Define Stagin for Climate CSV files
--
create or replace stage p2_csv_stage file_format = p2_csv_format;


