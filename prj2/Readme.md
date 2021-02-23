
# Project: Effect of Weather on Restaurant Reviews

In this project, we are attempting to find out the impact of weather conditions on customers’ review of restaurants. 
As input, 
<ol>
 <li> YELP data 
 <li> climate datasets for temperature and precipitation observations are from the Global Historical Climatology Network-Daily (GHCN-D) database. 
</ol>
<a href="http://www.snowflake.com" target='_blank'>Snowflake</a> is used as a cloud-native data warehouse system.
This project  architects and designs a Data Warehouse DWH for the purpose of reporting and online analytical processing (OLAP).

## Data Architecture 
This project comprise of three major steps;
<ol>
 <li> Loading files to staging area
 <li> Extracting data in files on staging area into tables in ODS
 <li> Transforming data in ODS to OLAP representations in DWH for reporting and analysis.  
</ol>

<table>
<tr><td>
 <img src='./img/DFDiagram.png' width='800' height='260'>
 </td></tr>
 <tr><td>
  Figure: Data Architecture and Flow
  </td></tr>
</table>


## Staging 
Project defines the following staging areas
<ol>
 <li> p2_json_stage for staging JSON files (according to p2_json_format file format)
 <li> p2_csv_stage for staging CSV files (according to p2_csv_format file format)
</ol>

## Operational Data Store (ODS)
The following ER diagram depicts the tables in ODS.


<table>
<tr><td>
 <img src='./img/Prj2-ERD - Page 2.png' width='800' height='260'>
 </td></tr>
 <tr><td>
  Figure: ER Diagram of ODS
  </td></tr>
</table>


## Data Warehouse
The following flow is used to obtain a report having  the business name, temperature, precipitation, and ratings. All of these values are retrieved from dimension tables (dim_yelp_business, dim_climate_temperature, dim_climate_precipitation, dim_yelp_review) by using facts_review table in DWH schema. 

<table>
<tr><td>
 <img src='./img/Prj2-ERD - Page 4.png' width='800' height='260'>
 </td></tr>
 <tr><td>
  Figure: Migrate the data in ODS to the Data Warehouse
  </td></tr>
</table>

## References
<ul>
 <li> Yelp data sets, https://www.yelp.com/dataset/documentation/main
 <li> CLIMATE DATA, https://crt-climate-explorer.nemac.org/
</ul>
