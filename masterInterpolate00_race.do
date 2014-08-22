* gen y=substr(intptlat,2,2)+"."+substr(intptlat,4,(length(intptlat)-3))
* gen x=substr(intptlon,1,4)+"."+substr(intptlon,5,(length(intptlon)-4))
* brow intptlat y intptlon x
* destring(x y), force replace

* previous data files - for ALL population only:
* census00sf1_blk00_aage19 - in 2000 blk fips (blk00fips), 19 age categories for all (both sexes)
* census00sf1_blk00_mage19 - in 2000 blk fips (blk00fips), 19 age categories for males alone
* census00sf1_blk00_fage19 - in 2000 blk fips (blk00fips), 19 age categories for females alone

* create the same files for (1) Hispanic alone, (2) Non-Hispanic White alone, and (3) All the others. 
* input data: ilgeo00_sumlev101_Chicago14000_AgeBySexByRaceHisp
* input data above was extracted from MCDC Missouri data center - the labels are similar but slightly modified from original SF1
* (1) p12hixx: Hispanic (or Latino) variables
* (2) p12Iixx: Non-Hispanic White variables:
* (3) Others variables is to be calculated based on previous files: i.e. Others = All - (Hispanic + Non-Hispanic)
clear all
local races p12hi p12Ii
local vnames "Hispanic NonHispWhite"
local counter=1
foreach var of local races {
	use ilgeo00_sumlev101_CookDuPage_AgeBySexByRaceHisp, clear
	sort blk00fips
	local v: word `counter' of `vnames'
	keep blk00fips `var'*
	label variable	 `var'1	"`v' Total"
	label variable	 `var'2	"`v' Male: Total"
	label variable	 `var'3	"`v' Male: Under 5 years"
	label variable	 `var'4	"`v' Male: 5 to 9 years"
	label variable	 `var'5	"`v' Male: 10 to 14 years"
	label variable	 `var'6	"`v' Male: 15 to 17 years"
	label variable	 `var'7	"`v' Male: 18 and 19 years"
	label variable	 `var'8	"`v' Male: 20 years"
	label variable	 `var'9	"`v' Male: 21 years"
	label variable	 `var'10	"`v' Male: 22 to 24 years"
	label variable	 `var'11	"`v' Male: 25 to 29 years"
	label variable	 `var'12	"`v' Male: 30 to 34 years"
	label variable	 `var'13	"`v' Male: 35 to 39 years"
	label variable	 `var'14	"`v' Male: 40 to 44 years"
	label variable	 `var'15	"`v' Male: 45 to 49 years"
	label variable	 `var'16	"`v' Male: 50 to 54 years"
	label variable	 `var'17	"`v' Male: 55 to 59 years"
	label variable	 `var'18	"`v' Male: 60 and 61 years"
	label variable	 `var'19	"`v' Male: 62 to 64 years"
	label variable	 `var'20	"`v' Male: 65 and 66 years"
	label variable	 `var'21	"`v' Male: 67 to 69 years"
	label variable	 `var'22	"`v' Male: 70 to 74 years"
	label variable	 `var'23	"`v' Male: 75 to 79 years"
	label variable	 `var'24	"`v' Male: 80 to 84 years"
	label variable	 `var'25	"`v' Male: 85 years and over"
	label variable	 `var'26	"`v' Female: Total"
	label variable	 `var'27	"`v' Female: Under 5 years"
	label variable	 `var'28	"`v' Female: 5 to 9 years"
	label variable	 `var'29	"`v' Female: 10 to 14 years"
	label variable	 `var'30	"`v' Female: 15 to 17 years"
	label variable	 `var'31	"`v' Female: 18 and 19 years"
	label variable	 `var'32	"`v' Female: 20 years"
	label variable	 `var'33	"`v' Female: 21 years"
	label variable	 `var'34	"`v' Female: 22 to 24 years"
	label variable	 `var'35	"`v' Female: 25 to 29 years"
	label variable	 `var'36	"`v' Female: 30 to 34 years"
	label variable	 `var'37	"`v' Female: 35 to 39 years"
	label variable	 `var'38	"`v' Female: 40 to 44 years"
	label variable	 `var'39	"`v' Female: 45 to 49 years"
	label variable	 `var'40	"`v' Female: 50 to 54 years"
	label variable	 `var'41	"`v' Female: 55 to 59 years"
	label variable	 `var'42	"`v' Female: 60 and 61 years"
	label variable	 `var'43	"`v' Female: 62 to 64 years"
	label variable	 `var'44	"`v' Female: 65 and 66 years"
	label variable	 `var'45	"`v' Female: 67 to 69 years"
	label variable	 `var'46	"`v' Female: 70 to 74 years"
	label variable	 `var'47	"`v' Female: 75 to 79 years"
	label variable	 `var'48	"`v' Female: 80 to 84 years"
	label variable	 `var'49	"`v' Female: 85 years and over"
	gen mage1=`var'3
	label variable mage1 "`v' Male 00-04"
	gen mage2=`var'4
	label variable mage2 "`v' Male 05-09"
	gen mage3=`var'5
	label variable mage3 "`v' Male 10-14"	
	gen mage4=`var'6
	label variable mage4 "`v' Male 15-17"	
	gen mage5=`var'7
	label variable mage5 "`v' Male 18-19"
	gen mage6=`var'8+`var'9+`var'10
	label variable mage6 "`v' Male 20-24"
	gen mage7=`var'11
	label variable mage7 "`v' Male 25-29"
	gen mage8=`var'12
	label variable mage8 "`v' Male 30-34"
	gen mage9=`var'13
	label variable mage9 "`v' Male 35-39"
	gen mage10=`var'14
	label variable mage10 "`v' Male 40-44"
	gen mage11=`var'15
	label variable mage11 "`v' Male 45-49"
	gen mage12=`var'16
	label variable mage12 "`v' Male 50-54"
	gen mage13=`var'17
	label variable mage13 "`v' Male 55-59"
	gen mage14=`var'18+`var'19+`var'20
	label variable mage14 "`v' Male 60-64"
	gen mage15=`var'21
	label variable mage15 "`v' Male 65-69"
	gen mage16=`var'22
	label variable mage16 "`v' Male 70-74"
	gen mage17=`var'23
	label variable mage17 "`v' Male 75-79"
	gen mage18=`var'24
	label variable mage18 "`v' Male 80-84"
	gen mage19=`var'25
	label variable mage19 "`v' Male 85+"

	gen fage1=`var'27
	label variable fage1 "`v' Female 00-04"
	gen fage2=`var'28
	label variable fage2 "`v' Female 05-09"
	gen fage3=`var'29
	label variable fage3 "`v' Female 10-14"	
	gen fage4=`var'30
	label variable fage4 "`v' Female 15-17"	
	gen fage5=`var'31
	label variable fage5 "`v' Female 18-19"
	gen fage6=`var'32+`var'33+`var'34
	label variable fage6 "`v' Female 20-24"
	gen fage7=`var'35
	label variable fage7 "`v' Female 25-29"
	gen fage8=`var'36
	label variable fage8 "`v' Female 30-34"
	gen fage9=`var'37
	label variable fage9 "`v' Female 35-39"
	gen fage10=`var'38
	label variable fage10 "`v' Female 40-44"
	gen fage11=`var'39
	label variable fage11 "`v' Female 45-49"
	gen fage12=`var'40
	label variable fage12 "`v' Female 50-54"
	gen fage13=`var'41
	label variable fage13 "`v' Female 55-59"
	gen fage14=`var'42+`var'43+`var'44
	label variable fage14 "`v' Female 60-64"
	gen fage15=`var'45
	label variable fage15 "`v' Female 65-69"
	gen fage16=`var'46
	label variable fage16 "`v' Female 70-74"
	gen fage17=`var'47
	label variable fage17 "`v' Female 75-79"
	gen fage18=`var'48
	label variable fage18 "`v' Female 80-84"
	gen fage19=`var'49
	label variable fage19 "`v' Female 85+"

	forvalues i=1/19{
		gen aage`i'=mage`i'+fage`i'
	}
	label variable aage1 "`v' All 00-04"
	label variable aage2 "`v' All 05-09"
	label variable aage3 "`v' All 10-14"	
	label variable aage4 "`v' All 15-17"	
	label variable aage5 "`v' All 18-19"
	label variable aage6 "`v' All 20-24"
	label variable aage7 "`v' All 25-29"
	label variable aage8 "`v' All 30-34"
	label variable aage9 "`v' All 35-39"
	label variable aage10 "`v' All 40-44"
	label variable aage11 "`v' All 45-49"
	label variable aage12 "`v' All 50-54"
	label variable aage13 "`v' All 55-59"
	label variable aage14 "`v' All 60-64"
	label variable aage15 "`v' All 65-69"
	label variable aage16 "`v' All 70-74"
	label variable aage17 "`v' All 75-79"
	label variable aage18 "`v' All 80-84"
	label variable aage19 "`v' All 85+"
	drop p12*
	save ilgeo00_sumlev101_CookDuPage_AgeBySexByRaceHisp_formatted_`v', replace
	local counter=`counter'+1
}
/*
* Create "Others" file ..
use census00sf1_sumlev101_p012_cookdupage_formatted, clear
foreach var of varlist mage1-aage19{
	local newname="t_"+"`var'"
	rename `var' `newname'
}
sort blk00fips
save temp1, replace

use ilgeo00_sumlev101_CookDuPage_AgeBySexByRaceHisp_formatted_Hispanic, clear
foreach var of varlist mage1-aage19{
	local newname="h_"+"`var'"
	rename `var' `newname'
}
sort blk00fips
save temp2, replace

use ilgeo00_sumlev101_CookDuPage_AgeBySexByRaceHisp_formatted_NonHispWhite, clear
foreach var of varlist mage1-aage19{
	local newname="w_"+"`var'"
	rename `var' `newname'
}
sort blk00fips
save temp3, replace

use temp1, clear
sort blk00fips
merge 1:1 blk00fips using temp2
assert _merge==3
drop _merge
sort blk00fips
merge 1:1 blk00fips using temp3
assert _merge==3
drop _merge

forvalues i=1/19{
	gen o_mage`i'=t_mage`i'-h_mage`i'-w_mage`i'
	gen o_fage`i'=t_fage`i'-h_fage`i'-w_fage`i'
	gen o_aage`i'=t_aage`i'-h_aage`i'-w_aage`i'
}
drop t_* h_* w_*
foreach var of varlist o_mage1-o_aage19{
	local newname=substr("`var'",3,length("`var'")-2)
	rename `var' `newname'
}
local vlist_mage mage1
local vlist_fage fage1
local vlist_aage aage1
forvalues i=1/19{
	local vlist_mage `vlist_mage'  mage`i'
	local vlist_fage `vlist_fage'  fage`i'
	local vlist_aage `vlist_aage'  aage`i'
}
*di "`vlist_mage'"
*di "`vlist_fage'"
*di "`vlist_aage'"
order blk00fips `vlist_mage' `vlist_fage' `vlist_aage'
save ilgeo00_sumlev101_CookDuPage_AgeBySexByRaceHisp_formatted_Others, replace
 
* All races/total population wasn't requested by Eric
use census00sf1_blk00_aage19_All, clear
use census00sf1_blk00_fage19_All, clear
use census00sf1_blk00_mage19_All, clear
*/
local counter=1
local races "Hispanic NonHispWhite Others"
foreach race of local races {
	use ilgeo00_sumlev101_CookDuPage_AgeBySexByRaceHisp_formatted_`race', clear
	keep if substr(blk00fips,3,3)=="031"
	preserve
	keep blk00fips mage*
	sort blk00fips
	reshape long mage, i(blk00fips) j(agegpn)
	gen racegpn=`counter'  //1:HISPANIC, 2:NON-HISPANIC WHITE, 3:NON-HISPANIC OTHER
	gen sex=2 //Male
	rename mage count
	order blk00fips count agegpn racegpn sex
	save census00sf1_blk00_mage19_`race'_long, replace
	restore

	preserve
	keep blk00fips fage*
	sort blk00fips
	reshape long fage, i(blk00fips) j(agegpn)
	gen racegpn=`counter' //1:HISPANIC, 2:NON-HISPANIC WHITE, 3:NON-HISPANIC OTHER
	gen sex=3 //Female
	rename fage count
	order blk00fips count agegpn racegpn sex
	save census00sf1_blk00_fage19_`race'_long, replace
	restore
	
	keep blk00fips aage*
	sort blk00fips
	reshape long aage, i(blk00fips) j(agegpn)
	gen racegpn=`counter' //1:HISPANIC, 2:NON-HISPANIC WHITE, 3:NON-HISPANIC OTHER
	gen sex=1 //ALL
	rename aage count
	order blk00fips count agegpn racegpn sex
	save census00sf1_blk00_aage19_`race'_long, replace
	local counter=`counter'+1
}
local sexes "aage mage fage"
foreach sex of local sexes {
	use 		 census00sf1_blk00_`sex'19_Hispanic_long, clear
	append using census00sf1_blk00_`sex'19_NonHispWhite_long
	append using census00sf1_blk00_`sex'19_Others_long
	* add var labels and values
	label variable blk00fips "2000 census block 15-digit FIPS code"
	label variable count	 "Count (i.e., population)"
	label variable agegpn  "Age group "
	label variable racegpn "Race group: 1:HISPANIC, 2:NON-HISPANIC WHITE, 3:NON-HISPANIC OTHER"
	label variable sex		 "Sex: 1:ALL, 2:MALE, 3:FEMALE"
	label define agegroup ///
	1 "00-04" ///
	2 "05-09" ///
	3 "10-14" ///	
	4 "15-17" ///	
	5 "18-19" ///
	6 "20-24" ///
	7 "25-29" ///
	8 "30-34" ///
	9 "35-39" ///
	10 "40-44" ///
	11 "45-49" ///
	12 "50-54" ///
	13 "55-59" ///
	14 "60-64" ///
	15 "65-69" ///
	16 "70-74" ///
	17 "75-79" ///
	18 "80-84" ///
	19 "85+", replace
	label values agegpn agegroup
	label define racegroup ///
	1 "HISPANIC" ///
	2 "NON-HISPANIC WHITE" ///
	3 "NON-HISPANIC OTHER", replace 
	label values racegpn racegroup
	label define sexgroup ///
	1 "ALL" ///
	2 "MALE" ///
	3 "FEMALE", replace 
	label values sex sexgroup
	sort blk00fips racegpn agegpn sex
	save census00sf1_blk00_`sex'19_races_long, replace
}
