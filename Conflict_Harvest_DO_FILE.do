********************************************************************************
********************************************************************************
*********************Step 1: General Data Preperation***************************
********************************************************************************
********************************************************************************

cd "C:\Users\nicol\Desktop\Nicole\Research\No time for conflict\Geodata\"
import delimited "Database Conflict Harvest.csv", clear

********************************************************************************
//Labeling and Organizing variables
********************************************************************************

label variable fid "ID of each grid cell"
label variable left "Geolocation of grid cell (left part)"
label variable top "Geolocation of grid cell (top part)"
label variable right "Geolocation of grid cell (right part)"
label variable bottom "Geolocation of grid cell (bottom part)"

//Generated Agricultural data
label variable _count "How many pixels are in one grid cell"
label variable _sum  "Total amount of harvest areas in pixels within one grid cell"
label variable _mean "Average of harvested areas within one grid cell"
label variable _median "Median of harvested areas within one grid cell"

//Conflict Data
label variable data_id "Conflict database: id"
label variable iso "Conflict database: id"
label variable event_id_cnty "Conflict database: id incl country letters"
label variable event_id_no_cnty "Conflict database: id without country letters"
label variable event_date "Conflict database: date"
label variable year "Conflict database: year"
label variable time_precision "Conflict database: precision of event time"
label variable event_type "Conflict database: type of event"
label variable sub_event_type "Conflict database: broader explanation of event type"
label variable actor1 "Conflict database: actor 1 in conflict"
label variable assoc_actor_1 "Conflict database: association related to the conflict and actor 1"
label variable inter1 "Conflict database: ? (number between 1 and 8)"
label variable actor2 "Conflict database: actor 2 in conflict"
label variable assoc_actor_2 "Conflict database: association related to the conflict and actor 2 "
label variable inter2 "Conflict database: ? (number between 1 and 8)"
label variable interaction "Conflict database: ?"
label variable region "Conflict database: Region"
label variable country "Conflict database: Country"
label variable admin1 "Conflict database: Administrative area 1 (province)"
label variable admin2 "Conflict database: Administrative area 2 (district)"
label variable admin3 "Conflict database: Administrative area 3 (sub district)"
label variable location "Conflict database: Location "
label variable latitude "Conflict database: Latitude coordinate"
label variable longitude "Conflict database: Longitude coordinate"
label variable geo_precision "Conflict database: precision of georeference "
label variable source "Conflict database: source of data about conflict"
label variable source_scale "Conflict database: scale of the source e.g. National"
label variable notes "Conflict database: additional information"
label variable fatalities "Conflict database: Fatalities"
label variable timestamp "Conflict database: Time stemp"
label variable iso3 "Conflict database: iso code of a country (Kenya = KEN)"

//Das sind quasi die gleichen Variablen aus dem Conflict database nur dass hier ebenfalls noch Konflikte in die Grid cells einbezogen werden, die einen Buffer von 5 km haben und somit die Grid cell geschnitten wird
//Habe ich vorerst in den Regressionen rausgelassen, da wir hier überlegen sollten in wie fern Konflikte eine Reichweite haben 1km, 5 km, 10km etc.
label variable data_id_2 "Conflict database: id"
label variable iso_2 "Conflict database: within 5 km buffer id"
label variable event_id_cnty_2 "Conflict database: within 5 km buffer id incl country letters"
label variable event_id_no_cnty_2 "Conflict database: within 5 km buffer id without country letters"
label variable event_date_2 "Conflict database: within 5 km buffer date"
label variable year_2 "Conflict database: within 5 km buffer year"
label variable time_precision_2 "Conflict database: within 5 km buffer precision of event time"
label variable event_type_2 "Conflict database: within 5 km buffer type of event"
label variable sub_event_type_2 "Conflict database: within 5 km buffer broader explanation of event type"
label variable actor1_2 "Conflict database: within 5 km buffer actor 1 in conflict"
label variable assoc_actor_1_2 "Conflict database: within 5 km buffer association related to the conflict and actor 1"
label variable inter1_2 "Conflict database: within 5 km buffer ? (number between 1 and 8)"
label variable actor2_2 "Conflict database: within 5 km buffer actor 2 in conflict"
label variable assoc_actor_2_2 "Conflict database: within 5 km buffer association related to the conflict and actor 2 "
label variable inter2_2 "Conflict database: within 5 km buffer ? (number between 1 and 8)"
label variable interaction_2 "Conflict database: within 5 km buffer ?"
label variable admin3_2 "Conflict database: within 5 km buffer Administrative area 3 (sub district)"
label variable location_2 "Conflict database: within 5 km buffer Location "
label variable latitude_2 "Conflict database: within 5 km buffer Latitude coordinate"
label variable longitude_2 "Conflict database: within 5 km buffer Longitude coordinate"
label variable geo_precision_2 "Conflict database: within 5 km buffer precision of georeference "
label variable source_2 "Conflict database: within 5 km buffer source of data about conflict"
label variable source_scale_2 "Conflict database: within 5 km buffer scale of the source e.g. National"
label variable notes_2 "Conflict database: within 5 km buffer additional information"
label variable fatalities_2 "Conflict database: within 5 km buffer Fatalities"
label variable timestamp_2 "Conflict database: within 5 km buffer Time stemp"

*Drop unnecessary variabales
drop varname_1 nl_name_1 type_1 engtype_1 cc_1 hasc_1 iso_1 gid_0 iso3_2 gid_1 id region_2 country_2 admin1_2 admin2_2 country_3

*rename variables
rename fid grid_cell_id
rename fid_3 district_id
rename name_1 district_name
rename fid_2 buffer_5_km_id
rename _count total_pixels
rename _sum harvest_sum
rename _mean harvest_mean
rename _median harvest_median 

********************************************************************************
//Additional Data Generation
********************************************************************************

//Harvest months indicator 
*Vielleicht hast du eine bessere Idee wie wir die Harvest Daten mit den Konflikt Daten verbinden. Habe jetzt variablen generieret und geschaut wann die Monate von Konflikt mit Harvest übereinstimmen
gen Harvest_Okt = "Oct" if strpos(harvestbarley,"Okt")>0 
replace Harvest_Okt = "Oct" if strpos(harvestcorn,"Okt")>0 
replace Harvest_Okt = "Oct" if strpos(harvestcorn2,"Okt")>0 
replace Harvest_Okt = "Oct" if strpos(harvestmillet,"Okt")>0 
replace Harvest_Okt = "Oct" if strpos(harvestsorghum,"Okt")>0 
replace Harvest_Okt = "Oct" if strpos(harvestwheat,"Okt")>0 
replace Harvest_Okt = "Oct" if strpos(harvestcotton,"Oct")>0 
replace Harvest_Okt = "Oct" if strpos(harvestrice,"Oct")>0 

gen harvest_nov = "Nov" if strpos(harvestbarley,"Nov")>0 
replace harvest_nov = "Nov" if strpos(harvestcorn,"Okt - Dez")>0 
replace harvest_nov = "Nov" if strpos(harvestcorn2,"Nov")>0 
replace harvest_nov = "Nov" if strpos(harvestmillet,"Nov")>0 
replace harvest_nov = "Nov" if strpos(harvestsorghum,"Nov")>0 
replace harvest_nov = "Nov" if strpos(harvestwheat,"Nov")>0 
replace harvest_nov = "Nov" if strpos(harvestcotton,"Nov")>0 
replace harvest_nov = "Nov" if strpos(harvestrice,"Nov")>0 

gen harvest_dec = "Dec" if strpos(harvestbarley,"Dez")>0 
replace harvest_dec = "Dec" if strpos(harvestcorn,"Dez")>0 
replace harvest_dec = "Dec" if strpos(harvestcorn2,"Dez")>0 
replace harvest_dec = "Dec" if strpos(harvestmillet,"Dez")>0 
replace harvest_dec = "Dec" if strpos(harvestsorghum,"Dez")>0 
replace harvest_dec = "Dec" if strpos(harvestwheat,"Dez")>0 
replace harvest_dec = "Dec" if strpos(harvestcotton,"Dez")>0 
replace harvest_dec = "Dec" if strpos(harvestrice,"Dez")>0 

gen harvest_mar = "Mar" if strpos(harvestcorn2,"Mar")>0 
gen harvest_apr = "Apr" if strpos(harvestcorn2,"Apr")>0 


gen conflict_month = "Jan" if strpos(event_date,"January")>0 
replace conflict_month = "Feb" if strpos(event_date,"February")>0 
replace conflict_month = "Mar" if strpos(event_date,"March")>0 
replace conflict_month = "Apr" if strpos(event_date,"April")>0 
replace conflict_month = "Jun" if strpos(event_date,"June")>0 
replace conflict_month = "Jul" if strpos(event_date,"July")>0 
replace conflict_month = "Aug" if strpos(event_date,"August")>0 
replace conflict_month = "Sep" if strpos(event_date,"September")>0 
replace conflict_month = "Oct" if strpos(event_date,"October")>0 
replace conflict_month = "Nov" if strpos(event_date,"November")>0 
replace conflict_month = "Dec" if strpos(event_date,"December")>0 

/*
//Rausgenommen da unklar ist wie wir mit den 5km buffern umgehen
gen conflict_month_2 = "Jan" if strpos(event_date_2,"January")>0 
replace conflict_month_2 = "Feb" if strpos(event_date_2,"February")>0 
replace conflict_month_2 = "Mar" if strpos(event_date_2,"March")>0 
replace conflict_month_2 = "Apr" if strpos(event_date_2,"April")>0 
replace conflict_month_2 = "Jun" if strpos(event_date_2,"June")>0 
replace conflict_month_2 = "Jul" if strpos(event_date_2,"July")>0 
replace conflict_month_2 = "Aug" if strpos(event_date_2,"August")>0 
replace conflict_month_2 = "Sep" if strpos(event_date_2,"September")>0 
replace conflict_month_2 = "Oct" if strpos(event_date_2,"October")>0 
replace conflict_month_2 = "Nov" if strpos(event_date_2,"November")>0 
replace conflict_month_2 = "Dec" if strpos(event_date_2,"December")>0 
*/

gen Conflict_during_harvest = 1 if conflict_month == Harvest_Okt
replace Conflict_during_harvest = 1 if  conflict_month == harvest_nov
replace Conflict_during_harvest = 1 if  conflict_month == harvest_dec
replace Conflict_during_harvest = 1 if  conflict_month == harvest_mar
replace Conflict_during_harvest = 1 if  conflict_month == harvest_apr
/*
//Rausgenommen da unklar ist wie wir mit den 5km buffern umgehen
replace Conflict_during_harvest = 1 if  conflict_month_2 == Harvest_Okt
replace Conflict_during_harvest = 1 if  conflict_month_2 == harvest_nov
replace Conflict_during_harvest = 1 if  conflict_month_2 == harvest_dec
replace Conflict_during_harvest = 1 if  conflict_month_2 == harvest_mar
replace Conflict_during_harvest = 1 if  conflict_month_2 == harvest_apr
*/
replace Conflict_during_harvest = 0 if Conflict_during_harvest==.

/*
**Falls wir noch was anderes generieren wollen, sollten wir diese variablen drin behalten
//Dropping Indicators of harvest crop periods
drop harvestbarley harvestcorn harvestcorn2 harvestmillet harvestsorghum harvestwheat harvestrice harvestcotton
*Bessere idee wie man die intensität messen kann. Derzeit nur addiert miteinander. Wahrscheinlich sinnvoller die intensität pro monat zu haben und nicht auf totaler ebene
gen intensity_harvest = intensityofharvest + intensitycorn + intensitymillet + intensitysorghum + intensitywheat
*Dropping harvest intensity indicators 
drop intensityofharvest intensitycorn intensitymillet intensitysorghum intensitywheat


*Drop generated month variables
drop Harvest_Okt harvest_nov harvest_dec conflict_month  harvest_mar harvest_apr
*drop conflict_month_2
*/


//Ab wann handelt sich bei einer grid cell um  Agricultural grid cells? 20%, 30%?!
*define agricultural grid cell if agriculture is more than 20%
gen agricultural = 1 if harvest_mean>=0.2
replace agricultural=0 if agricultural==.

save "Database Conflict Harvest Project.dta", replace

********************************************************************************
********************************************************************************
*********************Step 2: Generate Panel Database****************************
********************************************************************************
********************************************************************************

********************************************************************************
//Generate a monthly panel database
********************************************************************************
cd "C:\Users\nicol\Desktop\Nicole\Research\No time for conflict\Geodata\Analysis\Panel Generation"

keep grid_cell_id
duplicates drop

generate year = 2022
save "year2022.dta", replace

gen month = "Jan"
save "year2022_1.dta", replace

use "year2022.dta", clear
gen month = "Feb"
save "year2022_2.dta", replace


use "year2022.dta", clear
gen month = "Mar"
save "year2022_3.dta", replace

use "year2022.dta", clear
gen month = "Apr"
save "year2022_4.dta", replace

use "year2022.dta", clear
gen month = "May"
save "year2022_5.dta", replace

use "year2022.dta", clear
gen month = "Jun"
save "year2022_6.dta", replace

use "year2022.dta", clear
gen month = "Jul"
save "year2022_7.dta", replace

use "year2022.dta", clear
gen month = "Jul"
save "year2022_7.dta", replace

//2021
use "year2022.dta", clear
drop year
generate year = 2021
save "year2021.dta", replace

use "year2021.dta", clear
gen month = "Jan"
save "year2021_1.dta", replace

use "year2021.dta", clear
gen month = "Feb"
save "year2021_2.dta", replace

use "year2021.dta", clear
gen month = "Mar"
save "year2021_3.dta", replace

use "year2021.dta", clear
gen month = "Apr"
save "year2021_4.dta", replace

use "year2021.dta", clear
gen month = "May"
save "year2021_5.dta", replace

use "year2021.dta", clear
gen month = "Jun"
save "year2021_6.dta", replace

use "year2021.dta", clear
gen month = "Jul"
save "year2021_7.dta", replace

use "year2021.dta", clear
gen month = "Jul"
save "year2021_7.dta", replace

use "year2021.dta", clear
gen month = "Aug"
save "year2021_8.dta", replace

use "year2021.dta", clear
gen month = "Sep"
save "year2021_9.dta", replace

use "year2021.dta", clear
gen month = "Oct"
save "year2021_10.dta", replace

use "year2021.dta", clear
gen month = "Nov"
save "year2021_11.dta", replace

use "year2021.dta", clear
gen month = "Dec"
save "year2021_12.dta", replace


//2020
use "year2022.dta", clear
drop year
generate year = 2020
save "year2020.dta", replace

use "year2020.dta", clear
gen month = "Jan"
save "year2020_1.dta", replace

use "year2020.dta", clear
gen month = "Feb"
save "year2020_2.dta", replace

use "year2020.dta", clear
gen month = "Mar"
save "year2020_3.dta", replace

use "year2020.dta", clear
gen month = "Apr"
save "year2020_4.dta", replace

use "year2020.dta", clear
gen month = "May"
save "year2020_5.dta", replace

use "year2020.dta", clear
gen month = "Jun"
save "year2020_6.dta", replace

use "year2020.dta", clear
gen month = "Jul"
save "year2020_7.dta", replace

use "year2020.dta", clear
gen month = "Jul"
save "year2020_7.dta", replace

use "year2020.dta", clear
gen month = "Aug"
save "year2020_8.dta", replace

use "year2020.dta", clear
gen month = "Sep"
save "year2020_9.dta", replace

use "year2020.dta", clear
gen month = "Oct"
save "year2020_10.dta", replace

use "year2020.dta", clear
gen month = "Nov"
save "year2020_11.dta", replace

use "year2020.dta", clear
gen month = "Dec"
save "year2020_12.dta", replace


//2019
use "year2022.dta", clear
drop year
generate year = 2019
save "year2019.dta", replace

use "year2019.dta", clear
gen month = "Jan"
save "year2019_1.dta", replace

use "year2019.dta", clear
gen month = "Feb"
save "year2019_2.dta", replace

use "year2019.dta", clear
gen month = "Mar"
save "year2019_3.dta", replace

use "year2019.dta", clear
gen month = "Apr"
save "year2019_4.dta", replace

use "year2019.dta", clear
gen month = "May"
save "year2019_5.dta", replace

use "year2019.dta", clear
gen month = "Jun"
save "year2019_6.dta", replace

use "year2019.dta", clear
gen month = "Jul"
save "year2019_7.dta", replace

use "year2019.dta", clear
gen month = "Jul"
save "year2019_7.dta", replace

use "year2019.dta", clear
gen month = "Aug"
save "year2019_8.dta", replace

use "year2019.dta", clear
gen month = "Sep"
save "year2019_9.dta", replace

use "year2019.dta", clear
gen month = "Oct"
save "year2019_10.dta", replace

use "year2019.dta", clear
gen month = "Nov"
save "year2019_11.dta", replace

use "year2019.dta", clear
gen month = "Dec"
save "year2019_12.dta", replace

//Append data
use  "year2019_1.dta", clear
append using "year2019_2.dta" "year2019_3.dta" "year2019_4.dta" "year2019_5.dta" "year2019_6.dta" "year2019_7.dta" "year2019_8.dta" "year2019_9.dta" "year2019_10.dta" "year2019_11.dta" "year2019_12.dta"
append using "year2020_1.dta" "year2020_2.dta" "year2020_3.dta" "year2020_4.dta" "year2020_5.dta" "year2020_6.dta" "year2020_7.dta" "year2020_8.dta" "year2020_9.dta" "year2020_10.dta" "year2020_11.dta" "year2020_12.dta"
append using "year2021_1.dta" "year2021_2.dta" "year2021_3.dta" "year2021_4.dta" "year2021_5.dta" "year2021_6.dta" "year2021_7.dta" "year2021_8.dta" "year2021_9.dta" "year2021_10.dta" "year2021_11.dta" "year2021_12.dta"
append using "year2022_1.dta" "year2022_2.dta" "year2022_3.dta" "year2022_4.dta" "year2022_5.dta" "year2022_6.dta" "year2022_7.dta" 

cd "C:\Users\nicol\Desktop\Nicole\Research\No time for conflict\Geodata\Analysis"
save "Panel_Grids.dta"

********************************************************************************
//Generate single databases (to combine them later in the panel)
********************************************************************************
// Grid cell information on agriculture
use  "Database Conflict Harvest Project.dta", clear
keep grid_cell_id total_pixels harvest_sum harvest_mean harvest_median
duplicates drop 
save "Agricultural_Info.dta"

// Grid cell information on conflict 
use  "Database Conflict Harvest Project.dta", clear
keep grid_cell_id data_id iso event_id_cnty event_id_no_cnty event_date year time_precision event_type sub_event_type actor1 assoc_actor_1 inter1 actor2 assoc_actor_2 inter2 interaction region country admin1 admin2 admin3 location latitude longitude geo_precision source source_scale notes fatalities timestamp iso3

gen date = date(event_date, "DMY")
format date %td

gen monthlyDate=mofd(date)
format monthlyDate %tm

save "Conflict_Info.dta", replace

// Grid cell information on harvest 
use  "Database Conflict Harvest Project.dta", clear
rename intensityofharvest intensitbarley
keep grid_cell_id district_id district_name intensitbarley intensitycorn   intensitymillet intensitysorghum  intensitywheat Harvest_Okt harvest_nov harvest_dec harvest_mar harvest_apr 
duplicates drop

save "Harvest_Info.dta", replace

//Rearrange Panel_Grids

use "Panel_Grids.dta", clear
tostring year, replace
gen day = "1"
gen date2 = day + month + year
gen date = date(date2, "DMY")
format date %td

gen monthlyDate=mofd(date)
format monthlyDate %tm
drop year month day date2 date

save "Panel_Grids2.dta", replace

********************************************************************************
//Combine data
********************************************************************************
use "Panel_Grids2.dta", clear
merge m:1 grid_cell_id  using "Agricultural_Info.dta"
drop _merge
merge m:m grid_cell_id  using "Harvest_Info.dta"
drop _merge
merge m:m grid_cell_id monthlyDate using "Conflict_Info.dta"
drop if _merge == 2

sort grid_cell_id monthlyDate
save "Final_Data.dta", replace //Final database!


********************************************************************************
********************************************************************************
***************************Step 3: Rearrange Database***************************
********************************************************************************
********************************************************************************

use "Final_Data.dta", clear 

********************************************************************************
//Additional Data Generation
********************************************************************************
drop _merge

//Different kind of conflicts
gen Battles = 1 if event_type == "Battles" // | event_type_2 == "Battles"
gen Explosions = 1 if event_type == "Explosions/Remote violence" // | event_type_2 == "Explosions/Remote violence"
gen Protests = 1 if event_type == "Protests" // | event_type_2 == "Protests"
gen Riots = 1 if event_type == "Riots" // | event_type_2 == "Riots"
gen Strategic_dev = 1 if event_type == "Strategic developments" // | event_type_2 == "Strategic developments"
gen Violence_civil = 1 if event_type == "Violence against civilians" // | event_type_2 == "Violence against civilians"

replace Battles = 0 if Battles ==.
replace Explosions = 0 if Explosions ==.    
replace Protests = 0 if Protests ==.    
replace Riots = 0 if Riots ==.    
replace Strategic_dev = 0 if Strategic_dev ==.    
replace Violence_civil = 0 if Violence_civil ==.    


//Need to combine data (sum per grid cell) because we have multiple events within one grid cell

********************************************************************************
*Conflict indicator
********************************************************************************
gen conflict = 1 if data_id != . 
replace conflict = 0 if conflict == .

********************************************************************************
*Conflcit intensity per grid cell
********************************************************************************

bysort grid_cell_id monthlyDate: egen total_conflicts =  sum(conflict) 
bysort grid_cell_id monthlyDate: egen total_battles =  sum(Battles) 
bysort grid_cell_id monthlyDate: egen total_explosions =  sum(Explosions) 
bysort grid_cell_id monthlyDate: egen total_protests =  sum(Protests) 
bysort grid_cell_id monthlyDate: egen total_riots =  sum(Riots) 
bysort grid_cell_id monthlyDate: egen total_strat =  sum(Strategic_dev)
bysort grid_cell_id monthlyDate: egen total_violen =  sum(Violence_civil) 
bysort grid_cell_id monthlyDate: egen total_fatalities =  sum(fatalities) 
  
*Need to combine information on actors, associ, actors, inter?!, interaction?! time precision, geo precision

drop data_id iso event_id_cnty event_id_no_cnty event_date year time_precision event_type sub_event_type actor1 assoc_actor_1 inter1 actor2 assoc_actor_2 inter2 interaction region country admin1 admin2 admin3 location latitude longitude geo_precision source source_scale notes fatalities timestamp iso3

drop Battles Explosions Protests Riots Strategic_dev Violence_civil conflict

drop date
duplicates drop

gen conflict = 1 if total_conflicts>0
replace conflict = 0 if conflict==.

gen agricultural = 1 if harvest_mean>=0.2
replace agricultural=0 if agricultural==.

********************************************************************************
*harvest period
********************************************************************************
gen month=month(monthlyDate)
gen october = 10 if Harvest_Okt == "Oct" 
gen november = 11 if harvest_nov == "Nov" 
gen december = 12 if harvest_dec == "Dec" 
gen march = 3 if harvest_mar == "Mar" 
gen april = 4 if harvest_apr == "Apr" 


gen harvesting = 1 if  month == october
replace harvesting = 1 if  month == november
replace harvesting = 1 if  month ==  december
replace harvesting = 1 if  month == march
replace harvesting = 1 if  month == april
replace harvesting = 0 if harvesting == .

drop Harvest_Okt harvest_nov harvest_dec harvest_mar harvest_apr october november december march april month

********************************************************************************
* intensity measure
********************************************************************************
gen intensity_harvest = intensitbarley + intensitycorn + intensitymillet + intensitysorghum + intensitywheat

gen intensity_average = (intensitbarley + intensitycorn + intensitymillet + intensitysorghum + intensitywheat)/5

********************************************************************************
********************************************************************************
************************Step 4: Descriptive Statistics**************************
********************************************************************************
********************************************************************************

hist harvest_mean if harvest_mean>0.01
sum harvest_mean  //mean is 7.8%
sum harvest_mean if harvest_mean>0 //mean is 12,9%
sum harvest_mean if harvest_mean>0.01  //mean is 27,3%


********************************************************************************
********************************************************************************
******************************Step 5: Regressions*******************************
********************************************************************************
********************************************************************************

*First set database to panel
xtset grid_cell_id monthlyDate


********************************************************************************
//Regressions
********************************************************************************
*Possible variables as dependent variable:
	* Conflict (1 or 0)
	* Conflcit intensity (how often do conflict appear)
	* Fatalities (How many people died during the conflict in one month)
	
*Possible independent variables
	* Harvesting Month is at place
	* Harvested area (mean)
	* Agricultural land (0 or 1) if harvested area is larger than 40%
	* Intensity of Harvest (total) per municipality
	* Intensity of Harvest (Average) per municipality
	
	
qui xtreg total_conflicts harvesting harvest_mean  , robust
est store harvest_mean_1
qui xtreg  total_conflicts harvesting intensity_harvest harvest_mean  , robust
est store harvest_mean_2
qui xtreg  total_conflicts harvesting intensity_harvest harvest_mean i.monthlyDate , robust
est store harvest_mean_3
qui xtreg  total_conflicts harvesting intensity_harvest harvest_mean i.monthlyDate i.district_id, robust
est store harvest_mean_4

qui xtreg total_conflicts harvesting harvest_mean  , robust
est store int_avg_1
qui xtreg  total_conflicts harvesting intensity_average harvest_mean  , robust
est store int_avg_2
qui xtreg  total_conflicts harvesting intensity_average harvest_mean i.monthlyDate , robust
est store int_avg_3
qui xtreg  total_conflicts harvesting intensity_average harvest_mean i.monthlyDate i.district_id, robust
est store int_avg_4

qui xtreg  total_conflicts harvesting agricultural , robust
est store agri_1
qui xtreg  total_conflicts , robust
est store agri_2
qui xtreg  total_conflicts  harvesting  intensity_harvest agricultural i.monthlyDate , robust
est store agri_3
qui xtreg  total_conflicts  harvesting  intensity_harvest agricultural i.monthlyDate i.district_id, robust
est store agri_4

qui xtreg  total_fatalities harvesting agricultural , robust
est store fatalities_1
qui xtreg  total_fatalities , robust
est store fatalities_2
qui xtreg  total_fatalities  harvesting  intensity_harvest agricultural i.monthlyDate , robust
est store fatalities_3
qui xtreg  total_fatalities  harvesting  intensity_harvest agricultural i.monthlyDate i.district_id, robust
est store fatalities_4

esttab harvest_mean_1 harvest_mean_2 harvest_mean_3 harvest_mean_4 ,  indicate("District FE = *.district_id" "Month FE = *.monthlyDate" `r(indicate_fe)')   cells(b(star fmt(4)) se(par fmt(4))) stats(r2 vce N) obslast compress  nocon  star(* 0.10 ** 0.05 *** 0.01) replace

esttab agri_1 agri_2 agri_3 agri_4 ,  indicate("District FE = *.district_id" "Month FE = *.monthlyDate" `r(indicate_fe)')   cells(b(star fmt(4)) se(par fmt(4))) stats(r2 vce N) obslast compress  nocon  star(* 0.10 ** 0.05 *** 0.01) replace

esttab fatalities_1 fatalities_2 fatalities_3 fatalities_4 ,  indicate("District FE = *.district_id" "Month FE = *.monthlyDate" `r(indicate_fe)')   cells(b(star fmt(4)) se(par fmt(4))) stats(r2 vce N) obslast compress  nocon  star(* 0.10 ** 0.05 *** 0.01) replace

esttab int_avg_1 int_avg_2 int_avg_3 int_avg_4 ,  indicate("District FE = *.district_id" "Month FE = *.monthlyDate" `r(indicate_fe)')   cells(b(star fmt(4)) se(par fmt(4))) stats(r2 vce N) obslast compress  nocon  star(* 0.10 ** 0.05 *** 0.01) replace

