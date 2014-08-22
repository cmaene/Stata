
use blkrel10_ilblks_xtract, clear
gen blk00fips= state2k+ cnty2k+ substr(tract2k,1,4)+ substr(tract2k,6,2)+ blk2k
gen blk10fips= state+ cnty+ substr(tract,1,4)+ substr(tract,6,2)+ blk 
sort  blk00fips
by blk00fips: egen pop10sumby00=total(Pop10)
gen afactPop10=Pop10/pop10sumby00
gen afactComb = afactPop10
replace afactComb=afactLand if afactPop10==.
drop cousubfp2k vtd2k taz2k- puma2k
order  blk00fips state2k cnty2k tract2k blk2k blksfx2k placefp2k AreaLand2k AreaWater2k pflag2k blk10fips state cnty tract blk blksfx AreaLand AreaWater pflag AreaLandInt AreaWaterInt afactLand afactPop10 afactComb pop2k hus2k Pop10 HUS10 Pop2kInt
* keep Cook & DuPage county blocks only
keep if cnty2k=="031"| cnty2k=="043"| cnty=="031"| cnty=="043"
sort blk00fips blk10fips
save blkrel10_ilblks_xtract_formatted, replace
* keep  blk00fips AreaLand2k AreaWater2k pflag2k blk10fips AreaLand AreaWater pflag  AreaLandInt AreaWaterInt afactLand afactPop10 afactComb pop2k hus2k Pop10 HUS10 Pop2kInt
keep  blk00fips blk10fips afactLand afactPop10 afactComb
sort blk00fips
*save blkrel10_ilblks_xtract_formatted_premerge, replace
save blk0010_relate_cookdupage, replace

use census00sf1_sumlev101_p012_cookdupage, clear
gen blk00fips= state+ county+ tract+ block
drop fileid- block
label variable	 p012001	"Total"
label variable	 p012002	"Male: Total"
label variable	 p012003	"Male: Under 5 years"
label variable	 p012004	"Male: 5 to 9 years"
label variable	 p012005	"Male: 10 to 14 years"
label variable	 p012006	"Male: 15 to 17 years"
label variable	 p012007	"Male: 18 and 19 years"
label variable	 p012008	"Male: 20 years"
label variable	 p012009	"Male: 21 years"
label variable	 p012010	"Male: 22 to 24 years"
label variable	 p012011	"Male: 25 to 29 years"
label variable	 p012012	"Male: 30 to 34 years"
label variable	 p012013	"Male: 35 to 39 years"
label variable	 p012014	"Male: 40 to 44 years"
label variable	 p012015	"Male: 45 to 49 years"
label variable	 p012016	"Male: 50 to 54 years"
label variable	 p012017	"Male: 55 to 59 years"
label variable	 p012018	"Male: 60 and 61 years"
label variable	 p012019	"Male: 62 to 64 years"
label variable	 p012020	"Male: 65 and 66 years"
label variable	 p012021	"Male: 67 to 69 years"
label variable	 p012022	"Male: 70 to 74 years"
label variable	 p012023	"Male: 75 to 79 years"
label variable	 p012024	"Male: 80 to 84 years"
label variable	 p012025	"Male: 85 years and over"
label variable	 p012026	"Female: Total"
label variable	 p012027	"Female: Under 5 years"
label variable	 p012028	"Female: 5 to 9 years"
label variable	 p012029	"Female: 10 to 14 years"
label variable	 p012030	"Female: 15 to 17 years"
label variable	 p012031	"Female: 18 and 19 years"
label variable	 p012032	"Female: 20 years"
label variable	 p012033	"Female: 21 years"
label variable	 p012034	"Female: 22 to 24 years"
label variable	 p012035	"Female: 25 to 29 years"
label variable	 p012036	"Female: 30 to 34 years"
label variable	 p012037	"Female: 35 to 39 years"
label variable	 p012038	"Female: 40 to 44 years"
label variable	 p012039	"Female: 45 to 49 years"
label variable	 p012040	"Female: 50 to 54 years"
label variable	 p012041	"Female: 55 to 59 years"
label variable	 p012042	"Female: 60 and 61 years"
label variable	 p012043	"Female: 62 to 64 years"
label variable	 p012044	"Female: 65 and 66 years"
label variable	 p012045	"Female: 67 to 69 years"
label variable	 p012046	"Female: 70 to 74 years"
label variable	 p012047	"Female: 75 to 79 years"
label variable	 p012048	"Female: 80 to 84 years"
label variable	 p012049	"Female: 85 years and over"
gen mage1=p012003
label variable mage1 "Male 00-04"
gen mage2=p012004
label variable mage2 "Male 05-09"
gen mage3=p012005
label variable mage3 "Male 10-14"	
gen mage4=p012006
label variable mage4 "Male 15-17"	
gen mage5=p012007
label variable mage5 "Male 18-19"
gen mage6=p012008+p012009+p012010
label variable mage6 "Male 20-24"
gen mage7=p012011
label variable mage7 "Male 25-29"
gen mage8=p012012
label variable mage8 "Male 30-34"
gen mage9=p012013
label variable mage9 "Male 35-39"
gen mage10=p012014
label variable mage10 "Male 40-44"
gen mage11=p012015
label variable mage11 "Male 45-49"
gen mage12=p012016
label variable mage12 "Male 50-54"
gen mage13=p012017
label variable mage13 "Male 55-59"
gen mage14=p012018+p012019+p012020
label variable mage14 "Male 60-64"
gen mage15=p012021
label variable mage15 "Male 65-69"
gen mage16=p012022
label variable mage16 "Male 70-74"
gen mage17=p012023
label variable mage17 "Male 75-79"
gen mage18=p012024
label variable mage18 "Male 80-84"
gen mage19=p012025
label variable mage19 "Male 85+"

gen fage1=p012027
label variable fage1 "Female 00-04"
gen fage2=p012028
label variable fage2 "Female 05-09"
gen fage3=p012029
label variable fage3 "Female 10-14"	
gen fage4=p012030
label variable fage4 "Female 15-17"	
gen fage5=p012031
label variable fage5 "Female 18-19"
gen fage6=p012032+p012033+p012034
label variable fage6 "Female 20-24"
gen fage7=p012035
label variable fage7 "Female 25-29"
gen fage8=p012036
label variable fage8 "Female 30-34"
gen fage9=p012037
label variable fage9 "Female 35-39"
gen fage10=p012038
label variable fage10 "Female 40-44"
gen fage11=p012039
label variable fage11 "Female 45-49"
gen fage12=p012040
label variable fage12 "Female 50-54"
gen fage13=p012041
label variable fage13 "Female 55-59"
gen fage14=p012042+p012043+p012044
label variable fage14 "Female 60-64"
gen fage15=p012045
label variable fage15 "Female 65-69"
gen fage16=p012046
label variable fage16 "Female 70-74"
gen fage17=p012047
label variable fage17 "Female 75-79"
gen fage18=p012048
label variable fage18 "Female 80-84"
gen fage19=p012049
label variable fage19 "Female 85+"

forvalues i=1/19{
	gen aage`i'=mage`i'+fage`i'
}
label variable aage1 "All 00-04"
label variable aage2 "All 05-09"
label variable aage3 "All 10-14"	
label variable aage4 "All 15-17"	
label variable aage5 "All 18-19"
label variable aage6 "All 20-24"
label variable aage7 "All 25-29"
label variable aage8 "All 30-34"
label variable aage9 "All 35-39"
label variable aage10 "All 40-44"
label variable aage11 "All 45-49"
label variable aage12 "All 50-54"
label variable aage13 "All 55-59"
label variable aage14 "All 60-64"
label variable aage15 "All 65-69"
label variable aage16 "All 70-74"
label variable aage17 "All 75-79"
label variable aage18 "All 80-84"
label variable aage19 "All 85+"
drop p012*
save census00sf1_sumlev101_p012_cookdupage_formatted, replace
preserve
keep blk00fips mage*
sort blk00fips
save census00sf1_blk00_mage19, replace
restore
preserve
keep blk00fips fage*
sort blk00fips
save census00sf1_blk00_fage19, replace
restore
keep blk00fips aage*
sort blk00fips
save census00sf1_blk00_aage19, replace

use census10sf1_sumlev101_p012_cookdupage, clear
gen blk10fips= state+ county+ tract+ block
drop fileid- block
label variable	 p0120001	"Total"
label variable	 p0120002	"Male: Total"
label variable	 p0120003	"Male: Under 5 years"
label variable	 p0120004	"Male: 5 to 9 years"
label variable	 p0120005	"Male: 10 to 14 years"
label variable	 p0120006	"Male: 15 to 17 years"
label variable	 p0120007	"Male: 18 and 19 years"
label variable	 p0120008	"Male: 20 years"
label variable	 p0120009	"Male: 21 years"
label variable	 p0120010	"Male: 22 to 24 years"
label variable	 p0120011	"Male: 25 to 29 years"
label variable	 p0120012	"Male: 30 to 34 years"
label variable	 p0120013	"Male: 35 to 39 years"
label variable	 p0120014	"Male: 40 to 44 years"
label variable	 p0120015	"Male: 45 to 49 years"
label variable	 p0120016	"Male: 50 to 54 years"
label variable	 p0120017	"Male: 55 to 59 years"
label variable	 p0120018	"Male: 60 and 61 years"
label variable	 p0120019	"Male: 62 to 64 years"
label variable	 p0120020	"Male: 65 and 66 years"
label variable	 p0120021	"Male: 67 to 69 years"
label variable	 p0120022	"Male: 70 to 74 years"
label variable	 p0120023	"Male: 75 to 79 years"
label variable	 p0120024	"Male: 80 to 84 years"
label variable	 p0120025	"Male: 85 years and over"
label variable	 p0120026	"Female: Total"
label variable	 p0120027	"Female: Under 5 years"
label variable	 p0120028	"Female: 5 to 9 years"
label variable	 p0120029	"Female: 10 to 14 years"
label variable	 p0120030	"Female: 15 to 17 years"
label variable	 p0120031	"Female: 18 and 19 years"
label variable	 p0120032	"Female: 20 years"
label variable	 p0120033	"Female: 21 years"
label variable	 p0120034	"Female: 22 to 24 years"
label variable	 p0120035	"Female: 25 to 29 years"
label variable	 p0120036	"Female: 30 to 34 years"
label variable	 p0120037	"Female: 35 to 39 years"
label variable	 p0120038	"Female: 40 to 44 years"
label variable	 p0120039	"Female: 45 to 49 years"
label variable	 p0120040	"Female: 50 to 54 years"
label variable	 p0120041	"Female: 55 to 59 years"
label variable	 p0120042	"Female: 60 and 61 years"
label variable	 p0120043	"Female: 62 to 64 years"
label variable	 p0120044	"Female: 65 and 66 years"
label variable	 p0120045	"Female: 67 to 69 years"
label variable	 p0120046	"Female: 70 to 74 years"
label variable	 p0120047	"Female: 75 to 79 years"
label variable	 p0120048	"Female: 80 to 84 years"
label variable	 p0120049	"Female: 85 years and over"
gen mage1=p0120003
label variable mage1 "Male 00-04"
gen mage2=p0120004
label variable mage2 "Male 05-09"
gen mage3=p0120005
label variable mage3 "Male 10-14"	
gen mage4=p0120006
label variable mage4 "Male 15-17"	
gen mage5=p0120007
label variable mage5 "Male 18-19"
gen mage6=p0120008+p0120009+p0120010
label variable mage6 "Male 20-24"
gen mage7=p0120011
label variable mage7 "Male 25-29"
gen mage8=p0120012
label variable mage8 "Male 30-34"
gen mage9=p0120013
label variable mage9 "Male 35-39"
gen mage10=p0120014
label variable mage10 "Male 40-44"
gen mage11=p0120015
label variable mage11 "Male 45-49"
gen mage12=p0120016
label variable mage12 "Male 50-54"
gen mage13=p0120017
label variable mage13 "Male 55-59"
gen mage14=p0120018+p0120019+p0120020
label variable mage14 "Male 60-64"
gen mage15=p0120021
label variable mage15 "Male 65-69"
gen mage16=p0120022
label variable mage16 "Male 70-74"
gen mage17=p0120023
label variable mage17 "Male 75-79"
gen mage18=p0120024
label variable mage18 "Male 80-84"
gen mage19=p0120025
label variable mage19 "Male 85+"

gen fage1=p0120027
label variable fage1 "Female 00-04"
gen fage2=p0120028
label variable fage2 "Female 05-09"
gen fage3=p0120029
label variable fage3 "Female 10-14"	
gen fage4=p0120030
label variable fage4 "Female 15-17"	
gen fage5=p0120031
label variable fage5 "Female 18-19"
gen fage6=p0120032+p0120033+p0120034
label variable fage6 "Female 20-24"
gen fage7=p0120035
label variable fage7 "Female 25-29"
gen fage8=p0120036
label variable fage8 "Female 30-34"
gen fage9=p0120037
label variable fage9 "Female 35-39"
gen fage10=p0120038
label variable fage10 "Female 40-44"
gen fage11=p0120039
label variable fage11 "Female 45-49"
gen fage12=p0120040
label variable fage12 "Female 50-54"
gen fage13=p0120041
label variable fage13 "Female 55-59"
gen fage14=p0120042+p0120043+p0120044
label variable fage14 "Female 60-64"
gen fage15=p0120045
label variable fage15 "Female 65-69"
gen fage16=p0120046
label variable fage16 "Female 70-74"
gen fage17=p0120047
label variable fage17 "Female 75-79"
gen fage18=p0120048
label variable fage18 "Female 80-84"
gen fage19=p0120049
label variable fage19 "Female 85+"

forvalues i=1/19{
	gen aage`i'=mage`i'+fage`i'
}
label variable aage1 "All 00-04"
label variable aage2 "All 05-09"
label variable aage3 "All 10-14"	
label variable aage4 "All 15-17"	
label variable aage5 "All 18-19"
label variable aage6 "All 20-24"
label variable aage7 "All 25-29"
label variable aage8 "All 30-34"
label variable aage9 "All 35-39"
label variable aage10 "All 40-44"
label variable aage11 "All 45-49"
label variable aage12 "All 50-54"
label variable aage13 "All 55-59"
label variable aage14 "All 60-64"
label variable aage15 "All 65-69"
label variable aage16 "All 70-74"
label variable aage17 "All 75-79"
label variable aage18 "All 80-84"
label variable aage19 "All 85+"
drop p012*
save census10sf1_sumlev101_p012_cookdupage_formatted, replace
preserve
keep blk10fips mage*
sort blk10fips
save census10sf1_blk10_mage19, replace
restore
preserve
keep blk10fips fage*
sort blk10fips
save census10sf1_blk10_fage19, replace
restore
keep blk10fips aage*
sort blk10fips
save census10sf1_blk10_aage19, replace

program annual_pop_interpolation
	forvalues i=1/19{
		use census00sf1_blk00_`1'19, clear
		keep blk00fips `1'`i'
		sort blk00fips
		save temp00_`i', replace
		use census10sf1_blk10_`1'19, clear
		keep blk10fips `1'`i'
		rename `1'`i' pop10
		sort blk10fips
		save temp10_`i', replace
		use blk0010_relate_cookdupage, clear
		sort blk00fips
		merge m:1 blk00fips using temp00_`i'
		save testmerge1_`i', replace
		gen pop0=`1'`i'*afactComb
		sort blk10fips
		collapse (sum) pop0, by(blk10fips)
		sort blk10fips
		merge 1:1 blk10fips using temp10_`i'
		* treat missing value as 0 to calculate inter-censusal annual pop
		replace pop0=0 if pop0==.
		replace pop10=0 if pop10==.
		forvalues i2=1/9{
			gen pop`i2'=pop0+(((pop10-pop0)/10)*`i2')
			label variable pop`i2' "`2' population in 200`i2'"
		}
		label variable pop0  "`2' population in 2000"
		label variable pop10 "`2' population in 2010"
		order blk10fips pop0 pop1 pop2 pop3 pop4 pop5 pop6 pop7 pop8 pop9 pop10
		save testmerge2_`i', replace
		drop _merge
		keep if substr(blk10fips,3,3)=="031"
		reshape long pop, i(blk10fips) j(year)
		replace year=year+2000
		gen sex="`2'"
		gen agegpn=`i'
		order blk10fips year sex agegpn pop
		save census10sf1_blk10_`1'19_`i', replace
	}
	use census10sf1_blk10_`1'19_1, clear
	forvalues k=2/19{
		append using census10sf1_blk10_`1'19_`k'
	}
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
	19 "85+"
	label values agegpn agegroup
	compress
	save census10sf1_blk10_`1'19_long, replace
end
annual_pop_interpolation mage MALE
annual_pop_interpolation fage FEMALE
annual_pop_interpolation aage ALL

capture program drop annual_pop_interpolation
exit
