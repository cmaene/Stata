********************************************************************************
* PREPARATION 1
* create final respondents/resources data
* - all fall in the study area (SA - 3 counties + adjacent zip codes)
* - all must have the following codes
* - id, x, y, tr10fips, in3cnty (1 if in the 3 counties), insa (1 if in the study area)
********************************************************************************

cd /mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/

* MRRS 1
use mrrs_wave1_tract10spj, clear
rename mrrs1_geoid10 mrrs1_tr10fips
gen mrrs1_in3cnty=(substr(mrrs1_tr10fips,1,5)=="26099" | substr(mrrs1_tr10fips,1,5)=="26125" | substr(mrrs1_tr10fips,1,5)=="26163")
keep  mrrs1_vsamplelineid mrrs1_xfinal mrrs1_yfinal mrrs1_tr10fips mrrs1_in3cnty mrrs1_insa
order mrrs1_vsamplelineid mrrs1_xfinal mrrs1_yfinal mrrs1_tr10fips mrrs1_in3cnty mrrs1_insa
keep if mrrs1_insa==1
do program_labelvar
sort mrrs1_vsamplelineid
compress
save final_mrrs1, replace

* MRRS 2
use mrrs_wave2_tract10spj, clear
rename mrrs2_geoid10 mrrs2_tr10fips
gen mrrs2_in3cnty=(substr(mrrs2_tr10fips,1,5)=="26099" | substr(mrrs2_tr10fips,1,5)=="26125" | substr(mrrs2_tr10fips,1,5)=="26163")
keep  mrrs2_vsamplelineid mrrs2_xfinal mrrs2_yfinal mrrs2_tr10fips mrrs2_in3cnty mrrs2_insa
order mrrs2_vsamplelineid mrrs2_xfinal mrrs2_yfinal mrrs2_tr10fips mrrs2_in3cnty mrrs2_insa
keep if mrrs2_insa==1
do program_labelvar
sort mrrs2_vsamplelineid
compress
save final_mrrs2, replace

* SNAP retailers 2008
import excel "/mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/SNAP_Retailers08only_tr10spj.xls", sheet("temp") firstrow clear
rename id sr08_id
rename GEOID10 tr10fips
keep sr08_id tr10fips //some don't have tr10fips because they are not in the tracts whose centroids are not in SA
tostring sr08_id, replace
sort sr08_id
save SNAP_Retailers08only_tr10spj_short, replace
* new store type added in 3-30-14
import excel "/mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/SNAPretailers2008-FINAL_3_30_14.xls", sheet("Sheet1") firstrow clear
keep sr08_id GroceryStoreType sr08_insa
tostring sr08_id, replace
sort sr08_id
save SNAPretailers2008-FINAL_3_30_14_short, replace
use snapretailers2008_7_13_2, clear
sort sr08_id
merge 1:1 sr08_id using SNAP_Retailers08only_tr10spj_short
assert _merge==3
drop _merge
merge 1:1 sr08_id using SNAPretailers2008-FINAL_3_30_14_short
assert _merge==3
drop _merge
rename GroceryStoreType grocerystoretype08
rename tr10fips sr08_tr10fips
gen sr08_in3cnty=(substr(sr08_tr10fips,1,5)=="26099" | substr(sr08_tr10fips,1,5)=="26125" | substr(sr08_tr10fips,1,5)=="26163")
keep  sr08_id sr08_x sr08_y sr08_tr10fips sr08_in3cnty sr08_insa snapstoretype08rc grocerystoretype08
order sr08_id sr08_x sr08_y sr08_tr10fips sr08_in3cnty sr08_insa snapstoretype08rc grocerystoretype08
keep if sr08_insa==1
do program_labelvar
sort sr08_id
compress
save final_snapretailers08, replace

* SNAP retailers 2010
import excel "/mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/SNAP_Retailers10only_tr10spj.xls", sheet("temp") firstrow clear
rename id sr10_id
rename GEOID10 tr10fips
keep sr10_id tr10fips //some don't have tr10fips because they are not in the tracts whose centroids are not in SA
tostring sr10_id, replace
sort sr10_id
save SNAP_Retailers10only_tr10spj_short, replace
* new store type added in 3-30-14 - NOTE! 2010 data is slightly different from 2008, different sheet name, with tr10fips code, etc.
import excel "/mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/SNAPretailers2010_FINAL_4-9-14.xls", sheet("SNAPretailers2010_FINAL_inDetro") firstrow clear
rename sr_id sr10_id
keep sr10_id GroceryStoreType
tostring sr10_id, replace
sort sr10_id
save SNAPretailers2010-FINAL_3_30_14_short, replace
use snapretailers2010_7_13_2, clear
sort sr10_id
merge 1:1 sr10_id using SNAP_Retailers10only_tr10spj_short
keep if _merge==3 //using include extra 29 obs, which were removed in 7-13-13
drop _merge
merge 1:1 sr10_id using SNAPretailers2010-FINAL_3_30_14_short
keep if _merge==3 //using include extra 29 obs, which were removed in 7-13-13
drop _merge
rename GroceryStoreType grocerystoretype10
rename tr10fips sr10_tr10fips
gen sr10_in3cnty=(substr(sr10_tr10fips,1,5)=="26099" | substr(sr10_tr10fips,1,5)=="26125" | substr(sr10_tr10fips,1,5)=="26163")
gen sr10_insa=1
keep  sr10_id sr10_x sr10_y sr10_tr10fips sr10_in3cnty sr10_insa snapstoretype10rc grocerystoretype10
order sr10_id sr10_x sr10_y sr10_tr10fips sr10_in3cnty sr10_insa snapstoretype10rc grocerystoretype10
keep if sr10_insa==1
do program_labelvar
sort sr10_id
compress
save final_snapretailers10, replace

* Food retailers 2008
import excel "/mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/infousa2008_2818cases_tr10spj_inSA_2812cases.xls", sheet("temp") firstrow clear
rename GEOID10 fr08_tr10fips
gen fr08_in3cnty=(substr(fr08_tr10fips,1,5)=="26099" | substr(fr08_tr10fips,1,5)=="26125" | substr(fr08_tr10fips,1,5)=="26163")
gen fr08_insa=1
keep fr08_id fr08_tr10fips fr08_in3cnty fr08_insa
tostring fr08_id, replace
sort fr08_id
save infousa2008_2818cases_tr10spj_inSA_2812cases_short, replace
use infousa2008_nodup_foodonly7_13_premerge, clear
keep fr08_id fr08_x fr08_y fr08_primarynaicscode fr08_numsale 
sort fr08_id
merge 1:1 fr08_id using infousa2008_2818cases_tr10spj_inSA_2812cases_short
keep if _merge==3 // 4 (_merge==1) are not in SA, xy is slightly outside even though its zipcodes are supposedly in SA
drop _merge
keep  fr08_id fr08_x fr08_y fr08_tr10fips fr08_in3cnty fr08_insa fr08_primarynaicscode fr08_numsale
order fr08_id fr08_x fr08_y fr08_tr10fips fr08_in3cnty fr08_insa fr08_primarynaicscode fr08_numsale
keep if fr08_insa==1
do program_labelvar
label variable fr08_primarynaicscode "Primary NAICS code"
label variable fr08_numsale "Sales volume"
sort fr08_id
compress
* some don't have tr10fips because they are not in the tracts whose centroids are not in SA
save final_infousa08, replace

* Food retailers 2010
import excel "/mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/infousa2010_2860cases_tr10spj_inSA_2853cases.xls", sheet("temp") firstrow clear
rename GEOID10 fr10_tr10fips
gen fr10_in3cnty=(substr(fr10_tr10fips,1,5)=="26099" | substr(fr10_tr10fips,1,5)=="26125" | substr(fr10_tr10fips,1,5)=="26163")
gen fr10_insa=1
keep fr10_id fr10_tr10fips fr10_in3cnty fr10_insa
tostring fr10_id, replace
sort fr10_id
save infousa2010_2860cases_tr10spj_inSA_2853cases_short, replace
use infousa2010_nodup_foodonly7_13_premerge, clear
keep fr10_id fr10_x fr10_y fr10_primarynaicscode fr10_numsale 
sort fr10_id
merge 1:1 fr10_id using infousa2010_2860cases_tr10spj_inSA_2853cases_short
keep if _merge==3 // 5 (_merge==1) are not in SA, xy is slightly outside even though its zipcodes are supposedly in SA
drop _merge
keep  fr10_id fr10_x fr10_y fr10_tr10fips fr10_in3cnty fr10_insa fr10_primarynaicscode fr10_numsale
order fr10_id fr10_x fr10_y fr10_tr10fips fr10_in3cnty fr10_insa fr10_primarynaicscode fr10_numsale
keep if fr10_insa==1
do program_labelvar
label variable fr10_primarynaicscode "Primary NAICS code"
label variable fr10_numsale "Sales volume"
sort fr10_id
compress
* some don't have tr10fips because they are not in the tracts whose centroids are not in SA
save final_infousa10, replace

* Food pantries 2008
use detroit_food_pantry_provider_access2008_7_13_xy_odready, clear
tostring(studyid), replace
rename fp_x fp08_x
rename fp_y fp08_y
rename tr10fips fp08_tr10fips
gen fp08_in3cnty=(substr(fp08_tr10fips,1,5)=="26099" | substr(fp08_tr10fips,1,5)=="26125" | substr(fp08_tr10fips,1,5)=="26163")
gen fp08_insa=1
keep  studyid fp08_x fp08_y fp08_tr10fips fp08_in3cnty fp08_insa q12_rc q22_rc q25_rc
order studyid fp08_x fp08_y fp08_tr10fips fp08_in3cnty fp08_insa q12_rc q22_rc q25_rc
keep if fp08_insa==1
do program_labelvar
sort studyid
compress
save final_foodpantries08, replace

* Food pantries 2010
use detroit_food_pantry_provider_access2010_7_13_xy_odready, clear
tostring(studyid), replace
rename fp_x fp10_x
rename fp_y fp10_y
rename tr10fips fp10_tr10fips
gen fp10_in3cnty=(substr(fp10_tr10fips,1,5)=="26099" | substr(fp10_tr10fips,1,5)=="26125" | substr(fp10_tr10fips,1,5)=="26163")
gen fp10_insa=1
keep  studyid fp10_x fp10_y fp10_tr10fips fp10_in3cnty fp10_insa q12_rc q22_rc q25_rc
order studyid fp10_x fp10_y fp10_tr10fips fp10_in3cnty fp10_insa q12_rc q22_rc q25_rc
keep if fp10_insa==1
do program_labelvar
sort studyid
compress
save final_foodpantries10, replace

* SNAP offices 2011
use snapoffices11_tr10spj, clear
rename tr10fips so11_tr10fips
gen so11_in3cnty=(substr(so11_tr10fips,1,5)=="26099" | substr(so11_tr10fips,1,5)=="26125" | substr(so11_tr10fips,1,5)=="26163")
keep  so11_user_fld so11_x so11_y so11_tr10fips so11_in3cnty so11_insa
order so11_user_fld so11_x so11_y so11_tr10fips so11_in3cnty so11_insa
keep if so11_insa==1
do program_labelvar
sort so11_user_fld
compress
save final_snapoffices11, replace

* Social Services Providers 2013
use socserproviders13, clear
tostring(ss13_id), replace
rename tr10fips ss13_tr10fips
gen ss13_in3cnty=(substr(ss13_tr10fips,1,5)=="26099" | substr(ss13_tr10fips,1,5)=="26125" | substr(ss13_tr10fips,1,5)=="26163")
gen ss13_insa=1
keep  ss13_id ss13_x ss13_y ss13_tr10fips ss13_in3cnty ss13_insa Employment Food SubstanceAbuse_MentalHealth Education EmergencyAssistance
order ss13_id ss13_x ss13_y ss13_tr10fips ss13_in3cnty ss13_insa Employment Food SubstanceAbuse_MentalHealth Education EmergencyAssistance
keep if ss13_insa==1
do program_labelvar
sort ss13_id
compress
save final_socserproviders13, replace

* 2010 census tract centroid
use tract10centroid, clear
gen tr10_tr10fips=tr10fips
gen tr10_in3cnty=(substr(tr10_tr10fips,1,5)=="26099" | substr(tr10_tr10fips,1,5)=="26125" | substr(tr10_tr10fips,1,5)=="26163")
gen tr10_insa=1
keep  tr10fips tr10_x tr10_y tr10_tr10fips tr10_in3cnty tr10_insa
order tr10fips tr10_x tr10_y tr10_tr10fips tr10_in3cnty tr10_insa
do program_labelvar
sort tr10fips
compress
save final_tractcentroid10, replace

********************************************************************************
* GROUP 1
* MRRS 1 & 2 - find out which of GIS origin-destination matrix need to be corrected/run-again
********************************************************************************

* MRRS 1(2008) & 2(2010) SNAP retailers, Food retailers, Food pantries, SNAP offices
local requests A  B  C  D
local type     sr fr fp so
local years 2008 2010
forvalues i=1/4{
	local req: word `i' of `requests'
	local typ: word `i' of `type'
	forvalues i2=1/2{
		local v: word `i2' of `years'
		local yr2=substr("`v'",3,2)
		use result121613_tasksJuly13_rev/request`req'_`v', clear
		if "`typ'"=="fr"{
			gen repeat_d=1 if min_drive1==.
			gen repeat_w=1 if min_walk1==.
			gen repeat_p=1 if min_pubtrans1==.
			keep mrrs* min_distance1 min_drive1 min_walk1 min_pubtrans1 repeat_*
                }
		else {
			gen repeat_d=1 if min_drive==.
			gen repeat_w=1 if min_walk==.
			gen repeat_p=1 if  min_pubtrans==.
			keep mrrs`i2'_vsamplelineid min_distance min_drive min_walk min_pubtrans repeat_*
		}
		keep if repeat_d==1 | repeat_w==1 | repeat_p==1
		sort mrrs`i2'_vsamplelineid
		merge 1:1 mrrs`i2'_vsamplelineid using final_mrrs`i2'
		keep if _merge==3
		drop mrrs`i2'_xfinal-_merge
		save repeatlist/mrrs`i2'_`typ', replace
		clear all
	}
}
* MRRS 1(2008) & 2(2010) Social Services Providers
local type     ss
local years 2008 2010
forvalues i=1/1{
	local typ: word `i' of `type'
	forvalues i2=1/2{
		local v: word `i2' of `years'
		local yr2=substr("`v'",3,2)
		use result021814/task1_`v'_Feb2014, clear
		gen repeat_d=1 if min_drive==.
		gen repeat_w=1 if min_walk==.
		gen repeat_p=1 if min_pubtrans==.
		keep if repeat_d==1 | repeat_w==1 | repeat_p==1
		keep mrrs`i2'_vsamplelineid min_distance min_* repeat_*
		sort mrrs`i2'_vsamplelineid
		merge 1:1 mrrs`i2'_vsamplelineid using final_mrrs`i2'
		keep if _merge==3
		drop mrrs`i2'_xfinal-_merge
		save repeatlist/mrrs`i2'_`typ', replace
		clear all
	}
}
* print out the list of OD needs to be repeated...
log using repeatlist/list_repeat, text replace
local type     sr fr fp so ss
forvalues i=1/5{
	local typ: word `i' of `type'
	forvalues i2=1/2{
		use repeatlist/mrrs`i2'_`typ', clear
		describe, short
		if r(N)>0{
			local obs=r(N)
			list, table
		}
	}
}
log close

***********************
* use the log file (list of origins)
*  - to repeat OD matrix in ArcGIS
*  - to repeat Stata/Pubtransit calculation
***********************

*******************************************************************************
* CREATE ALL POSSIBLE PAIRS & THEN MERGE DRIVING/WARLKING/PUBTRANSIT CALC. FILES
*******************************************************************************

* MRRS AS ORIGINS **************************************************************
* local local final_mrrs1 final_mrrs2
#delimit ;
local datalist
final_snapretailers08
final_infousa08
final_foodpantries08
final_snapoffices11
final_socserproviders13
final_tractcentroid10
final_snapretailers10
final_infousa10
final_foodpantries10
final_snapoffices11
final_socserproviders13
final_tractcentroid10
;
#delimit cr
****** add mergeid 
forvalues i=1/12{
	local list: word `i' of `datalist'
	use `list', clear
	capture gen mergeid=1
	capture replace mergeid=1
	sort mergeid
	save `list', replace
}
local cnt=0
forvalues i=1/2{
	forvalues i2=1/6{
		local i3=`cnt'+`i2'
		local list: word `i3' of `datalist'
		use final_mrrs`i', clear
		* keep mrrs`i'_vsamplelineid mrrs`i'_xfinal mrrs`i'_yfinal
		gen mergeid=1
		sort mergeid
		joinby mergeid using `list'
		save final_mrrs`i'_`list', replace
	}
	local cnt=`cnt'+6
}

* create a list of "pubtransit" problem mrrs
* no problem with mrrs1
use repeatlist/mrrs2_sr, clear
keep if repeat_p==1
keep mrrs2_vsamplelineid
sort mrrs2_vsamplelineid
save repeatlist/repeat_mrrs2_pubtransit, replace

***** use MRRS wave 2
***** use snap retailer 2010
program repeatpubtrans
	use final_mrrs2_final_`1', clear
	sort  mrrs2_vsamplelineid
	merge m:1 mrrs2_vsamplelineid using repeatlist/repeat_mrrs2_pubtransit
	keep if _merge==3
	* only OD pubtransit problem ones..
	vincenty mrrs2_yfinal mrrs2_xfinal `2'_y `2'_x, vin(distance)
	sort mrrs2_vsamplelineid
	keep if distance<=15
	traveltime_pubtransit, start_x(mrrs2_xfinal) start_y(mrrs2_yfinal) end_x(`2'_x) end_y(`2'_y) date("9/26/12") time("9:00am")
	drop traveltime_dist
	gen totalmins =(hours*60)+mins
	foreach var of varlist date-totalmins {
		local newname="`var'_9am"
		rename `var' `newname'
	}
	rename totalmins_9am time_pubtrans9am
	replace time_pubtrans9am=. if time_pubtrans9am==1 & distance>0.06
	keep mrrs2_vsamplelineid `3' time_pubtrans9am
	sort mrrs2_vsamplelineid `3'
	save repeatlist/od2010`4'_step5_repeat, replace
end

repeatpubtrans snapretailers10 sr10 sr10_id sr
repeatpubtrans infousa10 fr10 fr10_id fr
repeatpubtrans foodpantries10 fp10 studyid fp
repeatpubtrans snapoffices11 so11 so11_user_fld so
repeatpubtrans socserproviders13 ss13 ss13_id ss

capture program drop repeatpubtrans

***** ?? calculate by_walk time for the pubtransit - distance <0.06 mile

* add the missing OD time - was run again in ArcGIS and saved in ODcsv_repeat
* no missing fro "length"

* save the original OD (before appending repeated OD ArcGIS matrix)
local group "sr fr fp so ss"
local year "08 10"
local type "time length"
forvalues i=1/5{
	local gp: word `i' of `group'
	forvalues num=1/2{
		local yr: word `num' of `year'
		forvalues num2=1/2{
			local tp: word `num2' of `type'
			use  od`gp'`yr'_`tp', clear
			save od`gp'`yr'_`tp'_old, replace
		}
	}
}

* append the repeated ArcGIS OD matrix
local group "sr fr fp so ss"
local ids   "sr10_id fr10_id studyid so11_user_fld ss13_id"
local year "10"
local type "time"
forvalues i=1/5{
	local gp: word `i' of `group'
	local id: word `i' of `ids'
	forvalues num=1/1{
		local yr: word `num' of `year'
		local tp: word `num' of `type'
		insheet using ODcsv_repeat/od`gp'`yr'_`tp'.csv, double comma clear
		keep name total_time total_length
		gen str12 mrrs2_vsamplelineid=substr(name,1,12)
		gen `id'=substr(name, 16,length(name)-15)
		if "`tp'"=="time"{
			rename total_time time_drive
			rename total_length length_drive
			destring time_drive, replace force
			destring length_drive, replace force
		}
		else if "`tp'"=="length"{
			drop total_time
			rename total_length length_walk
			destring length_walk, replace force
			gen double time_walk=length_walk/3*60 //using 3mph - average comfortable walking speed
		}
		keep  mrrs2_vsamplelineid `id' time_* length_*
		order mrrs2_vsamplelineid `id' time_* length_*
		compress
		sort mrrs2_vsamplelineid
		save ODcsv_repeat/od`gp'`yr'_`tp', replace
		use od`gp'`yr'_`tp'_old, clear
		append using ODcsv_repeat/od`gp'`yr'_`tp'
		sort mrrs2_vsamplelineid `id'
		save od`gp'`yr'_`tp', replace
	}
}

* social service provider only doesn't have xxxxx_step5
use ../mrrs_wave1_tract10spj_socserproviders13_traveltime, clear
replace totalmins_9am =. if totalmins_9am ==1 & distance>0.06
keep mrrs1_vsamplelineid ss13_id totalmins_9am
rename totalmins_9am time_pubtrans9am
save od2008ss_step5, replace

use ../mrrs_wave2_tract10spj_socserproviders13_traveltime, clear
replace totalmins_9am =. if totalmins_9am ==1 & distance>0.06
keep mrrs2_vsamplelineid ss13_id totalmins_9am
rename totalmins_9am time_pubtrans9am
save od2010ss_step5, replace

********* process od-matrix files *******************
program concat
	use od`1'`2'_time, clear
	sort mrrs`6'_vsamplelineid `3'
	merge 1:1 mrrs`6'_vsamplelineid `3' using od`1'`2'_length, update
	drop _merge
	order mrrs`6'_vsamplelineid `3' time_drive length_drive 
	sort mrrs`6'_vsamplelineid `3'
	save od`1'`2', replace
	
	use final_mrrs`6'_final_`4', clear
	* tostring(`3'), replace
	sort mrrs`6'_vsamplelineid `3'
	merge 1:1 mrrs`6'_vsamplelineid `3' using od`1'`2'
	* the final_ files are all in SA only!
	keep if _merge!=2
	drop _merge
	vincenty mrrs`6'_yfinal mrrs`6'_xfinal `5'_y `5'_x, vin(distance)
	
	* add public transportation travel time file
	sort mrrs`6'_vsamplelineid `3'
	merge 1:1 mrrs`6'_vsamplelineid `3' using od20`2'`1'_step5
	* there are a few cases (_merge==1) where distance is short (<=15 miles) but pubtransit time wasn't calculated
	drop if _merge==2
	drop _merge
	compress
	sort mrrs`6'_vsamplelineid `3'
	save od20`2'`1'_step6_orig, replace
end
/*concat sr 08 sr08_id snapretailers08 sr08 1
concat fr 08 fr08_id infousa08 fr08 1
concat fp 08 studyid foodpantries08 fp08 1
concat so 08 so11_user_fld snapoffices11 so11 1*/
concat ss 08 ss13_id socserproviders13 ss13 1

/*concat sr 10 sr10_id snapretailers10 sr10 2 1
concat fr 10 fr10_id infousa10 fr10 2
concat fp 10 studyid foodpantries10 fp10 2
concat so 10 so11_user_fld snapoffices11 so11 2*/
concat ss 10 ss13_id socserproviders13 ss13 2

capture program drop concat

* process SNAP retailers
do cr_snapretailers
do cr_foodretailers
do cr_foodpantries
do cr_snapoffices
do cr_socserproviders
do cr_2010censusdata

local var1 "08 10"
forvalue i=1/2{
	local v1: word `i' of `var1'
	use final_mrrs`i', clear
	sort mrrs`i'_vsamplelineid
	merge 1:1 mrrs`i'_vsamplelineid using request`v1'sr
	assert _merge!=2
	drop _merge
	merge 1:1 mrrs`i'_vsamplelineid using request`v1'fr
	assert _merge!=2
	drop _merge
	merge 1:1 mrrs`i'_vsamplelineid using request`v1'fp
	assert _merge!=2
	drop _merge
	merge 1:1 mrrs`i'_vsamplelineid using request`v1'so
	assert _merge!=2
	drop _merge
	merge 1:1 mrrs`i'_vsamplelineid using request`v1'ss
	assert _merge!=2
	drop _merge
	merge 1:1 mrrs`i'_vsamplelineid using request`v1'acs0711
	assert _merge!=2
	drop _merge
	sort mrrs`i'_vsamplelineid
	quietly compress
	save final_mrrs`i'_allvars, replace
}

********************************************************************************
* GROUP 2
* Census tract - "count falls in"
********************************************************************************
* TRACT CENTROIDS AS ORIGINS ******
****THIS MAY BE REDUNDANT - similar code will be run for the GROUP 4 ***********
* local local final_tractcentroid10
#delimit ;
local datalist
final_snapretailers08
final_infousa08
final_foodpantries08
final_snapoffices11
final_socserproviders13
final_snapretailers10
final_infousa10
final_foodpantries10
final_snapoffices11
final_socserproviders13
;
#delimit cr
/****** add mergeid 
forvalues i=1/10{
	local list: word `i' of `datalist'
	use `list', clear
	capture gen mergeid=1
	capture replace mergeid=1
	sort mergeid
	save `list', replace
}*/
local cnt=0
forvalues i=1/2{
	forvalues i2=1/5{
		local i3=`cnt'+`i2'
		local list: word `i3' of `datalist'
		use final_tractcentroid10, clear
		* keep mrrs`i'_vsamplelineid mrrs`i'_xfinal mrrs`i'_yfinal
		* gen mergeid=1
		sort mergeid
		joinby mergeid using `list'
		save final_tractcentroid10_`list', replace
	}
	local cnt=`cnt'+5
}
*******************************
do cr_snapretailers_tr10counts
do cr_foodretailers_tr10counts
do cr_foodpantries_tr10counts
do cr_snapoffices_tr10counts
do cr_socserproviders_tr10counts

local var1 "08 10"
use final_tractcentroid10, clear
forvalue i=1/2{
	local v1: word `i' of `var1'
	sort tr10fips
	merge 1:1 tr10fips using request`v1'sr_tr10counts
	assert _merge!=2
	drop _merge
	merge 1:1 tr10fips using request`v1'fr_tr10counts
	assert _merge!=2
	drop _merge
	merge 1:1 tr10fips using request`v1'fp_tr10counts
	assert _merge!=2
	drop _merge
}
merge 1:1 tr10fips using request11so_tr10counts
assert _merge!=2
drop _merge
merge 1:1 tr10fips using request13ss_tr10counts
assert _merge!=2
drop _merge
sort tr10fips
quietly compress
save final_tractcentroid10_counts, replace


********************************************************************************
* GROUP 3
* Food Pantries - as origins
********************************************************************************
* FOOD PANTRIES AS ORIGINS **************************************************************
* first - we need to rename the desination "food panties" otherwise, it won't merge well..
local var1 "08 10"
forvalues num=1/2{
	local v1: word `num' of `var1'
	use  final_foodpantries`v1', clear
	foreach var of varlist * {
		local newname="`var'2"
		rename `var' `newname'
	}
	rename mergeid2 mergeid
	sort mergeid
	save final_foodpantries`v1'2, replace
}
* local local final_mrrs1 final_mrrs2
#delimit ;
local datalist
final_snapretailers08
final_infousa08
final_foodpantries082
final_snapoffices11
final_socserproviders13
final_tractcentroid10
final_snapretailers10
final_infousa10
final_foodpantries102
final_snapoffices11
final_socserproviders13
final_tractcentroid10
;
#delimit cr
/****** add mergeid 
forvalues i=1/12{
	local list: word `i' of `datalist'
	use `list', clear
	capture gen mergeid=1
	capture replace mergeid=1
	sort mergeid
	save `list', replace
}*/
local cnt=0
local var1 "08 10"
forvalues i=1/2{
	local v1: word `i' of `var1'
	forvalues i2=1/6{
		local i3=`cnt'+`i2'
		local list: word `i3' of `datalist'
		use final_foodpantries`v1', clear
		* keep mrrs`i'_vsamplelineid mrrs`i'_xfinal mrrs`i'_yfinal
		capture gen mergeid=1
		capture replace mergeid=1
		sort mergeid
		joinby mergeid using `list'
		save final_foodpantries`v1'_`list', replace
	}
	local cnt=`cnt'+6
}

* process food pantries
do cr_snapretailers_fp
do cr_foodretailers_fp
do cr_foodpantries_fp
do cr_snapoffices_fp
do cr_socserproviders_fp
do cr_2010censusdata_fp

local var1 "08 10"
forvalue i=1/2{
	local v1: word `i' of `var1'
	use final_foodpantries`v1', clear
	sort studyid 
	merge 1:1 studyid using request`v1'sr_fp
	assert _merge!=2
	drop _merge
	merge 1:1 studyid using request`v1'fr_fp
	assert _merge!=2
	drop _merge
	merge 1:1 studyid using request`v1'fp_fp
	assert _merge!=2
	drop _merge
	merge 1:1 studyid using request`v1'so_fp
	assert _merge!=2
	drop _merge
	merge 1:1 studyid using request`v1'ss_fp
	assert _merge!=2
	drop _merge
	merge 1:1 studyid using request`v1'acs0711_fp
	assert _merge!=2
	drop _merge
	sort studyid
	quietly compress
	save final_foodpantries`v1'_allvars, replace
}


********************************************************************************
* GROUP 4
* Census tract centroid as origins are incomplete - no walking OD matrix, no pubtrans OD matrix
* before identifying zero-OD pairs, I need to run them first, first using ArcGIS (make ODs for walking)
* and also in the server to run "pubtransit" matrix do file.
********************************************************************************

*******************************************************************************
* STEP 1
* 2010 tract centroid as origins - Public transit travel time calculation
*******************************************************************************

cd /mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/
local destdata foodpantries08_short foodpantries10_short snapoffices11_short22
local prefix fp08 fp10 so11
			 
quietly{
	forvalues i=1/3 { //do this looping for data2 - data5
		local v1: word `i' of `destdata'
		local v2: word `i' of `prefix'
		use tract10centroid, clear
/*
tr10fips        str11   %11s                  
tr10_x          double  %10.0g                
tr10_y          double  %10.0g  
*/
		keep tr10fips tr10_x tr10_y
		gen mergeid=1
		sort mergeid
		joinby mergeid using `v1'
		vincenty tr10_y tr10_x `v2'_y `v2'_x, vin(distance)
		save tract10centroid_`v1', replace
		* make sure we have all possible matrix (i.e. MRRS1=358371=351*1021)
		noisily describe
		*sum distance
		*local maxd=int(r(max))
		* run pubtransit
		keep if distance<=15
		*keep if distance>=`maxd'
		noisily traveltime_pubtransit, start_x(tr10_x) start_y(tr10_y) end_x(`v2'_x) end_y(`v2'_y) date("9/26/12") time("9:00am")
		drop traveltime_dist
		gen totalmins=(hours*60)+mins
		foreach var of varlist date-totalmins {
			local newname="`var'_9am"
			rename `var' `newname'
		}
	* 1rename totalmins_9am time_pubtrans9am
	* noisily list in 1/1
	compress
	save tract10centroid_`v1'_traveltime, replace
	noisily describe
	}
}


* use the following for large destination data files (N>1,000,000)
* traveltime_pubtransit takes long time if the input file is huge
* like the following four
local destdata snapretailers08 snapretailers10 infousa2008_short infousa2010_short socserproviders13_short
local prefix sr08 sr10 fr08 fr10 ss13		 
quietly{
	forvalues i=5/5 { //do this looping for data2 - data5
		local v1: word `i' of `destdata'
		local v2: word `i' of `prefix'	
		use `v1', clear
		mkdir `v1'
		cd `v1'
		* http://www.ats.ucla.edu/stat/stata/faq/assign.htm
		generate rannum = uniform()
		egen grp2 = cut(rannum), group(100)
		gen grp=grp2+1
		drop rannum grp2
		* noisily tab grp
		save `v1'grp, replace
		forvalues n=1/100{
			use `v1'grp, clear
			keep if grp==`n'
			save `v1'`n', replace
			use ../tract10centroid, clear
			keep tr10fips tr10_x tr10_y
			gen mergeid=1
			sort mergeid
			joinby mergeid using `v1'`n'
			vincenty tr10_y tr10_x `v2'_y `v2'_x, vin(distance)
			save tract10centroid_`v1'`n', replace
			keep if distance<=15
			noisily traveltime_pubtransit, start_x(tr10_x) start_y(tr10_y) end_x(`v2'_x) end_y(`v2'_y) date("9/26/12") time("9:00am")
			drop traveltime_dist
			gen totalmins=(hours*60)+mins
			foreach var of varlist date-totalmins {
				local newname="`var'_9am"
				rename `var' `newname'
			}
			compress
			save tract10centroid_`v1'_traveltime`n', replace
		}
		use tract10centroid_`v1'_traveltime1, clear
		forvalues n=2/100{
			append using tract10centroid_`v1'_traveltime`n'
		}
		noisily tab grp
		sort tr10fips
		save ../tract10centroid_`v1'_traveltime, replace
		noisily describe
		cd ../
	}
}

********************************************************************************
* STEP 2
* Tract - find out which of GIS origin-destination matrix need to be corrected/run-again
* Skip pubtransit - BECAUSE we never calculated pubtransit time for tract centroid!
********************************************************************************

* the following re-process the request A-D
cd /mnt/ide0/home/cmaene/ProfAllard/foodchoice/ODcsv_tract10centroid/
do tasksNov2013_tractcen_rev

* Census tract centroid (2010) SNAP retailers, Food retailers, Food pantries, SNAP offices
local requests A  B  C  D
local type     sr fr fp so
local years 2008 2010
forvalues i=1/4{
	local req: word `i' of `requests'
	local typ: word `i' of `type'
	forvalues i2=1/2{
		local v: word `i2' of `years'
		local yr2=substr("`v'",3,2)
		use tr10_request`req'_`v', clear
		if "`typ'"=="fr"{
			gen repeat_d=1 if min_drive1==.
			gen repeat_w=1 if min_walk1==.
			* gen repeat_p=1 if min_pubtrans1==.
			keep tr10fips min_distance1 min_drive1 min_walk1 repeat_*
			*keep mrrs* min_distance1 min_drive1 min_walk1 min_pubtrans1 repeat_*
                }
		else {
			gen repeat_d=1 if min_drive==.
			gen repeat_w=1 if min_walk==.
			* gen repeat_p=1 if  min_pubtrans==.
			keep tr10fips min_distance min_drive min_walk repeat_*
			* keep mrrs* min_distance min_drive min_walk min_pubtrans repeat_*
		}
		keep if repeat_d==1 | repeat_w==1
		* keep if repeat_d==1 | repeat_w==1 | repeat_p==1
		/*sort tr10fips
		merge 1:1 tr10fips using final_mrrs`i2'
		keep if _merge==3
		drop tr10fips_xfinal-_merge*/
		save /mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/repeatlist/tr10`i2'_`typ', replace
		clear all
	}
}
* Census tract centroid (2010) Social Services Providers
local type     ss
local years    2010
forvalues i=1/1{
	local typ: word `i' of `type'
	forvalues i2=1/1{
		local v: word `i2' of `years'
		local yr2=substr("`v'",3,2)
		use /mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/result021814/task3_`v'_Feb2014, clear
		gen repeat_d=1 if min_drive==.
		gen repeat_w=1 if min_walk==.
		* gen repeat_p=1 if min_pubtrans==.
		keep if repeat_d==1 | repeat_w==1
		* keep if repeat_d==1 | repeat_w==1 | repeat_p==1
		keep tr10fips min_* repeat_*
		/*sort tr10fips
		merge 1:1 tr10fips using final_mrrs`i2'
		keep if _merge==3
		drop tr10fips_xfinal-_merge*/
		save /mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/repeatlist/tr10`i2'_`typ', replace
		save /mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/repeatlist/tr102_`typ', replace
		clear all
	}
}
* print out the list of OD needs to be repeated...
log using /mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/repeatlist/list_repeat_tr10, text replace
local type     sr fr fp so ss
forvalues i=1/5{
	local typ: word `i' of `type'
	forvalues i2=1/2{
		use /mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/repeatlist/tr10`i2'_`typ', clear
		describe, short
		if r(N)>0{
			local obs=r(N)
			list, table
		}
	}
}
log close

cd /mnt/ide0/home/cmaene/ProfAllard/foodchoice/final/

***********************
* use the log file (list of origins)
*  - to repeat OD matrix in ArcGIS
***********************

*******************************************************************************
* CREATE ALL POSSIBLE PAIRS & THEN MERGE DRIVING/WARLKING/PUBTRANSIT CALC. FILES
*******************************************************************************

* TRACT CENTROIDS AS ORIGINS **************************************************************
* local local final_tractcentroid10
#delimit ;
local datalist
final_snapretailers08
final_infousa08
final_foodpantries08
final_snapoffices11
final_socserproviders13
final_snapretailers10
final_infousa10
final_foodpantries10
final_snapoffices11
final_socserproviders13
;
#delimit cr
/****** add mergeid 
forvalues i=1/10{
	local list: word `i' of `datalist'
	use `list', clear
	capture gen mergeid=1
	capture replace mergeid=1
	sort mergeid
	save `list', replace
}*/
local cnt=0
forvalues i=1/2{
	forvalues i2=1/5{
		local i3=`cnt'+`i2'
		local list: word `i3' of `datalist'
		use final_tractcentroid10, clear
		* keep mrrs`i'_vsamplelineid mrrs`i'_xfinal mrrs`i'_yfinal
		* gen mergeid=1
		sort mergeid
		joinby mergeid using `list'
		save final_tractcentroid10_`list', replace
	}
	local cnt=`cnt'+5
}

use final_tractcentroid10, clear
foreach var of varlist * {
	local newname="`var'2"
	rename `var' `newname'
}
rename mergeid2 mergeid
sort mergeid
save final_tractcentroid102, replace

use final_tractcentroid10, clear
sort mergeid
joinby mergeid using final_tractcentroid102
save final_tractcentroid10_final_tractcentroid102, replace
***********************
*  Add Stata/Pubtransit calculation (in later section below)
*  AGAIN - we are not REPEAT-ing this for pubtransit BECAUSE pubtransit time
*  has NEVER been calcualted for tract centroids!
***********************

***** ?? calculate by_walk time for the pubtransit - distance <0.06 mile

* add the missing OD time - was run again in ArcGIS and saved in ODcsv_repeat
* no missing fro "length"

* save the original OD (before appending repeated OD ArcGIS matrix)
local group "sr sr fr fr fp fp so ss"
local year  "08 10 08 10 08 10 11 13"
local type "time length"
forvalues i=1/8{
	local gp: word `i' of `group'
	local yr: word `i' of `year'
	forvalues num=1/2{
		forvalues num2=1/2{
			local tp: word `num2' of `type'
			use  /mnt/ide0/home/cmaene/ProfAllard/foodchoice/ODcsv_tract10centroid/od`gp'`yr'_`tp', clear
			save /mnt/ide0/home/cmaene/ProfAllard/foodchoice/ODcsv_tract10centroid/od`gp'`yr'_`tp'_old, replace
		}
	}
}

* append the repeated ArcGIS OD matrix 
* NOTE: repeat SR FR FP for 2008 & 2010
* REMEMBER SR is tricky because both 08/10 are in the same file - exactly the same obs/XY/distance/time combinations
local group "sr sr fr fr fp fp so ss"
local ids   "sr08_id sr10_id fr08_id fr10_id studyid studyid so11_user_fld ss13_id"
local year  "08 10 08 10 08 10 11 13"
local type "time length"
forvalues i=1/8{
	local gp: word `i' of `group'
	local id: word `i' of `ids'
	local yr: word `i' of `year'
	forvalues num=1/2{
		local tp: word `num' of `type'
		if "`gp'"=="sr"{
			insheet using ODcsv_repeat/tr10_od`gp'0810_`tp'.csv, double comma clear
		}
		else {
			insheet using ODcsv_repeat/tr10_od`gp'`yr'_`tp'.csv, double comma clear
		}
		keep name total_time total_length
		gen str11 tr10fips=substr(name,1,11)
		gen `id'=substr(name, 15,length(name)-14)
		if "`tp'"=="time"{
			rename total_time time_drive
			rename total_length length_drive
			destring time_drive, replace force
			destring length_drive, replace force
		}
		else if "`tp'"=="length"{
			drop total_time
			rename total_length length_walk
			destring length_walk, replace force
			gen double time_walk=length_walk/3*60 //using 3mph - average comfortable walking speed
		}
		keep  tr10fips `id' time_* length_*
		order tr10fips `id' time_* length_*
		compress
		sort tr10fips
		save ODcsv_repeat/tr10_od`gp'`yr'_`tp', replace
		use /mnt/ide0/home/cmaene/ProfAllard/foodchoice/ODcsv_tract10centroid/od`gp'`yr'_`tp'_old, clear
		append using ODcsv_repeat/tr10_od`gp'`yr'_`tp'
		sort tr10fips `id'
		save tr10_od`gp'`yr'_`tp', replace
	}
}

* social service provider only doesn't have xxxxx_step5
local fnames "snapretailers08 snapretailers10 infousa2008_short infousa2010_short foodpantries08_short foodpantries10_short snapoffices11_short22 socserproviders13_short"
local group  "sr sr fr fr fp fp so ss"
local ids    "sr08_id sr10_id fr08_id fr10_id studyid studyid so11_user_fld ss13_id"
local year   "08 10 08 10 08 10 11 13"
forvalues i=1/8{
	local fn: word `i' of `fnames'
	local gp: word `i' of `group'
	local id: word `i' of `ids'
	local yr: word `i' of `year'
	use tract10centroid_`fn'_traveltime, clear
	replace totalmins_9am =. if totalmins_9am ==1 & distance>0.06
	keep tr10fips `id' totalmins_9am
	rename  totalmins_9am time_pubtrans9am
	capture tostring `id', replace
	compress
	sort tr10fips `id'
	save tr10_od20`yr'`gp'_step5, replace
}

********* process od-matrix files *******************
program concat
	use tr10_od`1'`2'_time, clear
	sort tr10fips `3'
	merge 1:1 tr10fips `3' using tr10_od`1'`2'_length, update
	drop _merge
	order tr10fips `3' time_drive length_drive 
	sort  tr10fips `3'
	save tr10_od`1'`2', replace
	
	use final_tractcentroid10_final_`4', clear
	* tostring(`3'), replace
	sort tr10fips `3'
	merge 1:1 tr10fips `3' using tr10_od`1'`2'
	* the final_ files are all in SA only!
	keep if _merge!=2
	drop _merge
	vincenty tr10_y tr10_x `5'_y `5'_x, vin(distance)
	
	* add public transportation travel time file
	sort tr10fips `3'
	merge 1:1 tr10fips `3' using tr10_od20`2'`1'_step5
	* there are a few cases (_merge==1) where distance is short (<=15 miles) but pubtransit time wasn't calculated
	drop if _merge==2
	drop _merge
	compress
	sort tr10fips `3'
	save tr10_od20`2'`1'_step6_orig, replace
end
/*concat sr 08 sr08_id snapretailers08 sr08
concat sr 10 sr10_id snapretailers10 sr10
concat fr 08 fr08_id infousa08 fr08
concat fr 10 fr10_id infousa10 fr10
concat fp 08 studyid foodpantries08 fp08
concat fp 10 studyid foodpantries10 fp10*/
concat so 11 so11_user_fld snapoffices11 so11
concat ss 13 ss13_id socserproviders13 ss13

capture program drop concat

* process SNAP retailers
do cr_snapretailers_tr10origin
do cr_foodretailers_tr10origin
do cr_foodpantries_tr10origin
do cr_snapoffices_tr10origin
do cr_socserproviders_tr10origin
do cr_2010censusdata_tr10origin

local var1 "08 10"
use final_tractcentroid10, clear
sort tr10fips
forvalue i=1/2{
	local v1: word `i' of `var1'
	merge 1:1 tr10fips using tr10_request`v1'sr
	assert _merge!=2
	drop _merge
	merge 1:1 tr10fips using tr10_request`v1'fr
	assert _merge!=2
	drop _merge
	merge 1:1 tr10fips using tr10_request`v1'fp
	assert _merge!=2
	drop _merge
}
merge 1:1 tr10fips using tr10_request11so
assert _merge!=2
drop _merge
merge 1:1 tr10fips using tr10_request13ss
assert _merge!=2
drop _merge
merge 1:1 tr10fips using tr10_request10acs0711
assert _merge!=2
drop _merge
sort tr10fips
quietly compress
save final_tractcentroid10_allvars, replace

exit
