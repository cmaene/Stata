/*******************************************************************************
STEP 1: DOWNLOAD STATA DATA & ANCILIRARY FILES FROM NBER.ORG

disclaimer of the files:
**  Note:  This program is distributed under the GNU GPL. See end of
**  this file and http://www.gnu.org/licenses/ for details.
**  by Jean Roth Wed Nov  3 15:36:37 EDT 2010
**  Please report errors to jroth@nber.org
*******************************************************************************
cd F:\Prof_Hill\SIPP\
* download bulk files from nber.org using wget unitility
* wget is a native utility for Unix, no need to download/install anything
* if using wget in Windows, wget.exe must be downloaded and also path to 
* wget.exe must to be added to the environment variables
shell wget -mrnp -A pdf,dct,do,dta,html,txt,zip http://www.nber.org/sipp/2004/
shell wget -mrnp -A pdf,dct,do,dta,html,txt,zip http://www.nber.org/sipp/2008/

* MAKE SURE TO CHANGE LINE 19 IN "sipplxxpuwx.do" files - "local dat_name _____"
* ALSO PAY ATTENTION TO LINE 23 "local dta_name _____" - MODIFY ACCORDINGLY
*******************************************************************************
* 2008 panel's longitudinal weights data is still in-process for 2012..
Obtain the latest logitudinal weight data DAT file from census FTP site:
http://thedataweb.rm.census.gov/ftp/sipp_ftp.html
run the modified NBER's do file, F:\Prof_Hill\SIPP\www.nber.org\sipp\2008\sipplgtwgt2008w11.do
to format the latest DAT file.
Use of "calendar year weights" were suggested by Prof. Shaefer (Prof. Hill's email on 11-20-2013 below)
 - Matching year-level policies to the SIPP observations. Luke says that there are 
 - "calendar year weights" that you can download separately of the main data files....  
*/

/*** process the most updated core data files
* cd F:\Prof_Hill\SIPP\
local panels "04 08"
foreach x of local panels{
	if "`x'"=="04"{
		local maxwave=12
	}
	else if "`x'"=="08"{
		local maxwave=14
	}
	cd "www.nber.org/sipp/20`x'/"
	
	forvalues num=1/`maxwave'{
		clear all //need to clear previous label definitions
		unzipfile l`x'puw`num', replace
		quietly do sippl`x'puw`num'.do
		capture log close
	}	
	cd ../../../
}
*/
/*******************************************************************************
STEP 2: MERGING DATA

We want individual level data, first for all and then for age under 18 only:
* the following creates long-format data for each of the SIPP panels
* using monthly variable (moth or monyear), can be easilly converted to wide format later
* although wave 14, 2008 data is available, the corresponding longitudinal/calender year
* weight will NOT be available until February, 2015. For the reason, we should
* stick to up to wave 13 data..
*******************************************************************************/
set more off, permanently
clear all
set maxvar 6000 
* cd F:\Prof_Hill\SIPP\
local panels "04 08"

foreach x of local panels{
	if "`x'"=="04"{
		local maxwave=12
	}
	else if "`x'"=="08"{
		local maxwave=14
	}
	cd "www.nber.org/sipp/20`x'/"
	
	forvalues num=1/`maxwave'{
		use sippl`x'puw`num', clear
		** we care about the most accurate info only: reference month==4
		** keep if srefmon==4
		* note on IDs - http://www.census.gov/sipp/use_core_id.html
		egen sippid=concat(spanel ssuid epppnum)
		label variable sippid "panel-HH-person unique ID: spanel+ssuid+epppnum"
		order sippid
		* help on date conversion: http://ceprdata.org/wp-content/sipp/recode/job_tenure.do
		gen monyear=ym( rhcalyr, rhcalmn)
		label var monyear "Month-year in STATA counter (480 is Jan. 2000)"
		* the following is from Shaefer lectuer 3 pdf
		gen zero = 0
		egen tempmo = concat(zero rhcalmn)
		tostring rhcalmn, generate(rhcalmn2)
		replace tempmo = rhcalmn2 if rhcalmn > 9
		egen month = concat(rhcalyr tempmo)
		label var month "Month-year in string, as Shaefer suggested"
		* should I keep person-weight? (wpfinwgt)
		* followings are the original variables I am keeping
		* t26amt wasn't included in 2008 panel
		if "`x'"=="08"{
			gen t26amt=.
			gen a26amt=.
			label variable t26amt "GI: Amount of pass-through child support paym"
		}
		#delimit ;
		local keptvars 
		sippid 		// panel-HH-person unique ID: spanel+ssuid+epppnum
		ssuid 		// SU: Sample Unit Identifier
		shhadid		// SU: Hhld Address ID differentiates hhlds in
		ehhnumpp	// HH: Total number of persons in this household
		eentaid 	// PE: Address ID of hhld where person entered
		epppnum 	// PE: Person number
		rhtype 		// HH: Household type
		rhchange 	// HH: Change in household composition from previous month
		errp 		// PE: Household relationship
		rfid 		// FA: Family ID Number for this month
		rfid2 		// FA: Family ID excluding related subfamily
		//eftype 		// FA: Type of family (or pseudo-family)
		//esft 		// PE: Family type
		//efkind 		// FA: Kind of family (or pseudo-family)
		//esfkind 	// SF: Kind of family (or pseudo-family)
		//rhnf 		// HH: Number of families and pseudo families in
		//rhnfam 		// HH: No. of fams and psuedo fams (excluding
		//rfchange 	// FA: Change in family composition from
		//efnp 		// FA: Number of persons in this family or
		//efrefper 	// FA: Person number of the family reference
		epnspous 	// PE: Person number of spouse
		//efspouse 	// FA: Person number of spouse of family
		//esftype 	// SF: Kind of family (or pseudo-family)
		rsid 		// FA: Related or unrelated subfamily ID Number
		//rhnsf 		// HH: Number of related subfamilies for this
		//esfr 		// PE: Subfamily relationship
		//esfrfper 	// SF: Person number of the related subfamily
		//esfspse 	// SF: Person number of spouse of related subfam
		//esfnp 		// SF: Number of persons in this related
		epnmom 		// PE: Person number of mother
		//etypmom 	// PE: Type of child to mother
		epndad 		// PE: Person number of father
		//etypdad 	// PE: Type of child to father
		epnguard 	// PE: Person number of guardian
		lgtkey 		// PE: Person longitudinal key
		gvarstr 	// SU: Variance Stratum Code
		rhcalyr 	// SU: Calendar year for this reference month	
		monyear 	// Month-year in STATA counter (480 is Jan. 2000)
		month 		// Month-year in string, as Shaefer suggested
		spanel 		// SU: Sample Code - Indicates Panel Year
		swave 		// SU: Wave of data collection
		//srotaton 	// SU: Rotation of data collection
		srefmon 	// SU: Reference month of this record
		rhcalmn 	// SU: Calendar month for this reference month.
		tfipsst 	// HH: FIPS State Code
		tmovrflg 	// PE: Mover flag
		tage 		// PE: Age as of last birthday
		esex 		// PE: Sex of this person
		erace 		// PE: The race(s) the respondent is
		eorigin 	// PE: Spanish, Hispanic or Latino
		ebornus 	// PE: Respondent was born in the U.S.
		ecitizen 	// PE: US Citizenship Status of Respondent
		//rfnkids 	// FA: Total number of children under 18 in
		//rfoklt18 	// FA: Number of own children under 18 in family
		eeducate 	// ED: Highest Degree received or grade completed
		// employment and income related
		//ejobcntr	// LF: Number of jobs held during the reference
		//epdjbthn	// LF: Paid job during the reference period
		//ebuscntr	// LF: Number of businesses owned during referen
		//ecflag		// LF: Flag indicating contingent worker
		rmesr 		// LF: Employment status recode for month
		//rwksperm	// LF: Number of weeks in this month
		//rwkesr1 	// LF: Employment Status Recode for Week 1
		//rwkesr2 	// LF: Employment Status Recode for Week 2
		//rwkesr3 	// LF: Employment Status Recode for Week 3
		//rwkesr4 	// LF: Employment Status Recode for Week 4
		//rwkesr5 	// LF: Employment Status Recode for Week 5
		//rmhrswk 	// LF: Usual hours worked per week recode in
		//rmwkwjb 	// LF: Number of weeks with a job in month
		//ejbhrs1		// LF: Usual hours worked per week at this job
		//ejbhrs2		// LF: Usual hours worked per week at this job
		//tpyrate1	// JB: Regular hourly pay rate
		//tpyrate2	// JB: Regular hourly pay rate
		//ejbind1		// JB: Industry code
		//ejbind2		// JB: Industry code
		//tjbocc1		// JB: Occupation classification code
		//tjbocc2 	// JB: Occupation classification code
		//eclwrk1		// JB: Class of worker
		//eclwrk2		// JB: Class of worker
		ersnowrk 	// LF: Main reason for not having a job during
		evaques		// AF: Veteran - fill questionnaire to receive
		// HH poverty threshold
		rhpov 		// HH: Poverty threshold for this household in
		// Household income
		thpndist 	// HH: Distributions from pension plans
		thlumpsm 	// HH: Retirement lump sum payments
		thnoncsh 	// HH: Total Household Noncash Income Recode
		thsocsec 	// HH: Total Household Social Security Income
		thssi 		// HH: Total Household Supplemental Security
		thunemp 	// HH: Total Household Unemployment Income Recode
		thvets 		// HH: Total Household Veterans Payments Recode
		thafdc 		// HH: Total household public assistance payments
		thfdstp 	// HH: Total Household Food Stamps Received
		thearn 		// HH: Total household earned income
		thprpinc 	// HH: Total household property income
		thtrninc 	// HH: Total household means-tested cash
		thothinc 	// HH: Total 'other' household income
		thtotinc 	// HH: Total household income
		// total personal income components
		tptotinc	// PE: Total person's income for the reference
		// earnings
		tpearn		//// PE: Total person's earned income for the
		tpmsum1		// JB: Earnings from job received in this month, incl. farming income (incl. contingent workers)
		tpmsum2		// JB: Earnings from job received in this month, incl. farming income (excl. contingent workers)
		tmlmsum		// LF: Amount of income from moonlighting or
		tbmsum1		// BS: Income received this month
		tbmsum2		// BS: Income received this month
		tprftb1		// BS: Net profit or loss
		tprftb2		// BS: Net profit or loss
		t15amt		// GI: Amount of severance pay (ISS Code 15)
		// means-tested cash transfers
		t03amta		// GI: Amount of Federal SSI - Adult (ISS Code 3)	
		t03amtk		// GI: Amount of Federal SSI - Child (ISS Code 3)	
		t04amt		// GI: Amount of State SSI (ISS Code 4)		
		t20amt		// GI: Amount of public assistance payments (ISS	
		t21amt		// GI: Amount of General Assistance or General	
		t24amt		// GI: Amount of other welfare (ISS Code 24)	
		t61amt		// GI: Amount of food assistance	
		t62amt		// GI: Amount of clothing assistance	
		t64amt		// GI: Amount of short-term cash assistance
		t08amt		// GI: Amount of Veterans compensation or pension	
		// food stamp
		t27amt		// GI: Amount of Food Stamps (ISS Code 27)
		// property income - dividend
		tmjntdiv	// AS: Amount of check from jointly held mutual
		tmowndiv	// AS: Amount of check from solely held mutual
		tmjadiv		// AS: Amount of dividends credited to join
		tmownadv	// AS: Amount of dividends credited to own
		tsjntdiv	// AS: Amount of dividend check from jointly
		tsowndiv	// AS: Amount of dividend check for solely held
		tsjadiv		// AS: Amount of dividend credited to a joint
		tsownadv	// AS: Amount of dividend credited solely held
		// property income - interest
		tckjtint	// AS: Amount of monthly interest from joint
		tckoint		// AS: Amount of monthly interest from own
		tsvjtint	// AS: Amount of monthly interest on joint
		tsvoint		// AS: Amount of monthly interest from own
		tmdjtint	// AS: Amount of monthly interest on joint money
		tmdoint		// AS: Amt of monthly interest from own money
		tcdjtint	// AS: Amount of monthly interest from joint CDs
		tcdoint		// AS: Amount of monthly interest from solely
		tbdjtint	// AS: Amt of monthly interest from joint	
		tbdoint		// AS: Amount of monthly int. from own
		tgvjtint	// AS: Amount of monthly int from joint US Govt
		tgvoint		// AS: Amount of monthly int from own US Govt
		// property income - other property income
		tjaclr		// AS: Amt of net rent from prop. held jointly
		toaclr		// AS: Amount of net income from own rental
		tjaclr2		// AS: Amount of net income from rental property
		tmijnt		// AS: Amount of interest paid on mortgage owned
		tmiown		// AS: Amount of interest paid on own mortgage
		trndup1		// AS: Amount of income from royalties
		trndup2		// AS: Amount of other income from financial
		// other income
		t01amta		// GI: Amount of Social Security - Adult (ISS	
		t01amtk		// GI: Amount of Social Security - Child (ISS	
		t02amt		// GI: Amount of Railroad Retirement (ISS Code 2)
		t05amt		// GI: Amount of State unemployment compensation
		t06amt		// GI: Amount of Supplemental Unemployment
		t10amt		// GI: Amount of workers' compensation (ISS Code
		t13amt		// GI: Amount of own sickness, accident,
		t14amt		// GI: Amount of employer disability payments
		t23amt		// GI: Amount of foster child care payments (ISS
		t26amt		// GI: Amount of pass-through child support paym
		t28amt		// GI: Amount of child support payments (ISS
		t29amt		// GI: Amount of alimony payments (ISS Code 29)
		t30amt		// GI: Amount of pension from a company or union
		t31amt		// GI: Amount of Federal Civil Service pension
		t32amt		// GI: Amount of U.S. Military retirement pay
		t34amt		// GI: Amount of State government pension (ISS
		t35amt		// GI: Amount of local government pension (ISS
		t36amt		// GI: Amount of income from paid-up life
		t38amt		// GI: Amt. from other retirement, disability or
		t51amt		// GI: Amount of money from relatives or friends
		t55amt		// GI: Amount of incidental or casual earnings
		t56amt		// GI: Amount of miscellaneous cash income
		t75amt		// GI: Amount of other government income (ISS	
		// imputation flags
		// earnings
		apmsum1		// JB: Earnings from job received in this month, incl. farming income (incl. contingent workers)
		apmsum2		// JB: Earnings from job received in this month, incl. farming income (excl. contingent workers)
		amlmsum		// LF: Amount of income from moonlighting or
		abmsum1		// BS: Income received this month
		abmsum2		// BS: Income received this month
		aprftb1		// BS: Net profit or loss
		aprftb2		// BS: Net profit or loss
		a15amt		// GI: Amount of severance pay (ISS Code 15)
		// means-tested cash transfers
		a03amta		// GI: Amount of Federal SSI - Adult (ISS Code 3)	
		a03amtk		// GI: Amount of Federal SSI - Child (ISS Code 3)	
		a04amt		// GI: Amount of State SSI (ISS Code 4)		
		a20amt		// GI: Amount of public assistance payments (ISS	
		a21amt		// GI: Amount of General Assistance or General	
		a24amt		// GI: Amount of other welfare (ISS Code 24)	
		a61amt		// GI: Amount of food assistance	
		a62amt		// GI: Amount of clothing assistance	
		a64amt		// GI: Amount of short-term cash assistance
		a08amt		// GI: Amount of Veterans compensation or pension	
		// food stamp
		a27amt		// GI: Amount of Food Stamps (ISS Code 27)
		// property income - dividend
		amjntdiv	// AS: Amount of check from jointly held mutual
		amowndiv	// AS: Amount of check from solely held mutual
		amjadiv		// AS: Amount of dividends credited to join
		amownadv	// AS: Amount of dividends credited to own
		asjntdiv	// AS: Amount of dividend check from jointly
		asowndiv	// AS: Amount of dividend check for solely held
		asjadiv		// AS: Amount of dividend credited to a joint
		asownadv	// AS: Amount of dividend credited solely held
		// property income - interest
		ackjtint	// AS: Amount of monthly interest from joint
		ackoint		// AS: Amount of monthly interest from own
		asvjtint	// AS: Amount of monthly interest on joint
		asvoint		// AS: Amount of monthly interest from own
		amdjtint	// AS: Amount of monthly interest on joint money
		amdoint		// AS: Amt of monthly interest from own money
		acdjtint	// AS: Amount of monthly interest from joint CDs
		acdoint		// AS: Amount of monthly interest from solely
		abdjtint	// AS: Amt of monthly interest from joint	
		abdoint		// AS: Amount of monthly int. from own
		agvjtint	// AS: Amount of monthly int from joint US Govt
		agvoint		// AS: Amount of monthly int from own US Govt
		// property income - other property income
		ajaclr		// AS: Amt of net rent from prop. held jointly
		aoaclr		// AS: Amount of net income from own rental
		ajaclr2		// AS: Amount of net income from rental property
		amijnt		// AS: Amount of interest paid on mortgage owned
		amiown		// AS: Amount of interest paid on own mortgage
		arndup1		// AS: Amount of income from royalties
		arndup2		// AS: Amount of other income from financial
		// other income
		a01amta		// GI: Amount of Social Security - Adult (ISS	
		a01amtk		// GI: Amount of Social Security - Child (ISS	
		a02amt		// GI: Amount of Railroad Retirement (ISS Code 2)
		a05amt		// GI: Amount of State unemployment compensation
		a06amt		// GI: Amount of Supplemental Unemployment
		a10amt		// GI: Amount of workers' compensation (ISS Code
		a13amt		// GI: Amount of own sickness, accident,
		a14amt		// GI: Amount of employer disability payments
		a23amt		// GI: Amount of foster child care payments (ISS
		a26amt		// GI: Amount of pass-through child support paym
		a28amt		// GI: Amount of child support payments (ISS
		a29amt		// GI: Amount of alimony payments (ISS Code 29)
		a30amt		// GI: Amount of pension from a company or union
		a31amt		// GI: Amount of Federal Civil Service pension
		a32amt		// GI: Amount of U.S. Military retirement pay
		a34amt		// GI: Amount of State government pension (ISS
		a35amt		// GI: Amount of local government pension (ISS
		a36amt		// GI: Amount of income from paid-up life
		a38amt		// GI: Amt. from other retirement, disability or
		a51amt		// GI: Amount of money from relatives or friends
		a55amt		// GI: Amount of incidental or casual earnings
		a56amt		// GI: Amount of miscellaneous cash income
		a75amt		// GI: Amount of other government income (ISS	
		;	
		#delimit cr
		keep  `keptvars'
		order `keptvars'
		* keep if tage<18
		sort sippid
		save sippl`x'puw`num'_temp, replace
		describe, short
	}	
	* merge (append, actually) all wave files
	use sippl`x'puw1_temp, clear
	forvalues i=2/`maxwave'{
		sort sippid
		quietly append using sippl`x'puw`i'_temp
	}
	* I don't like how the inconsistent panel year labels
	label drop spanel
	save sippl`x'puw_tempall, replace
	
	* add sippid to the longitudinal/calendar year weight file
	use sipplgtwgt20`x'w`maxwave', clear
	* gen sippid=ssuid+epppnum
	drop spanel ssuid epppnum
	sort lgtkey
	save sipplgtwgt20`x'w`maxwave'_premerge, replace
	* assign calendar year weight
	use sippl`x'puw_tempall, clear
	gen double lgtcywt=.
	label var lgtcywt "Longitudinal calendar year weight"
	sort lgtkey
	merge m:1 lgtkey using sipplgtwgt20`x'w`maxwave'_premerge
	* assert _merge==3 ///this turned out to be untrue=some individuals don't get lgtwgts
	* set base year to assign longitudinal calendar year weight (first-year, second-year, etc.)
	if "`x'"=="04"{
		local baseyr=2004
		local calyearnum=4
		* to keep the 2-digit base calendar year
		local x2="0709"
	}
	else if "`x'"=="08"{
		local baseyr=2009
		local calyearnum=5
		* to keep the 2-digit base calendar year
		* local x2="1208"
		* ALSO CHANGE LINE 528 EVERYTIME CHANGING THE END MONTH!
		local x2="1212" //if including wave 14
	}
	forvalues i2=1/`calyearnum'{
		replace lgtcywt=lgtcy`i2'wt if rhcalyr==`baseyr'
		local baseyr=`baseyr'+1
	}
	drop lgtpn* lgtcy1wt-lgtcy`calyearnum'wt _merge	

	drop if sippid==""
	***** income - calculate % allocated/imputated for totinc, trninc, fdstp, earn

	***** First, create a new variable, thtrninc2: means-tested plus food stamp
	gen thtrninc2=thtrninc+thfdstp
	label variable thtrninc2 "HH: Total household means-tested cash plus food stamps"
	order sippid-thtrninc thtrninc2

	*** earnings
	gen     incearn=tpmsum1+tpmsum2+tmlmsum+tbmsum1+tbmsum2+t15amt
	* problem - business net loss/profit is reported for the entire ref month
	* AND they are not evenly divided into 4 month - the only way to find how
	* the loss/profit is divided is to use tpearn.. 
	foreach var of varlist tprftb1 tprftb2{
		gen `var'per=(tpearn-incearn)/`var'
		gen `var'mon=round(`var'*`var'per) if `var'per!=.
		replace incearn=incearn+`var'mon if `var'mon!=.
	}
	gen     impearn=0
	foreach var of varlist tpmsum1 tpmsum2 tmlmsum tbmsum1 tbmsum2 {
		local impvar="a"+substr("`var'",2,length("`var'")-1)
		replace impearn=impearn+`var'  if `impvar'!=0
	}
	replace impearn=impearn+tprftb1mon if aprftb1!=0
	replace impearn=impearn+tprftb2mon if aprftb2!=0

	*** means-tested + food stamp
	egen    inctrninc2=rowtotal(t03amta-t64amt)
	replace inctrninc2=inctrninc2+t08amt if evaques==1
	replace inctrninc2=inctrninc2+t27amt
	gen     imptrninc2=0
	foreach var of varlist t03amta-t64amt {
		local impvar="a"+substr("`var'",2,length("`var'")-1)
		replace imptrninc2=imptrninc2+`var' if `impvar'!=0
	}
	replace imptrninc2=imptrninc2+t08amt if evaques==1 & a08amt!=0
	replace imptrninc2=imptrninc2+t27amt if a27amt!=0

	*** total income
	egen    inctotinc=rowtotal(tmjntdiv-t75amt)
	replace inctotinc=inctotinc+incearn+inctrninc2-t27amt
	replace inctotinc=inctotinc+t08amt if evaques!=1
	gen     imptotinc=impearn + imptrninc2
	replace imptotinc=imptotinc-t27amt if a27amt!=0
	foreach var of varlist tmjntdiv-t75amt {
		local impvar="a"+substr("`var'",2,length("`var'")-1)
		replace imptotinc=imptotinc+`var' if `impvar'!=0
	}
	replace imptotinc=imptotinc+t08amt if evaques!=1 & a08amt!=0

	sort spanel ssuid shhadid swave srefmon
	foreach var of varlist incearn impearn inctrninc2 imptrninc2 inctotinc imptotinc{
		egen hh_`var' = sum(`var'), by(spanel ssuid shhadid swave srefmon)
	}
	
	* the following households (two in 2004 & onw in 2008) appear to be invalid
	* perhaps, remove the HHs from analysis all together but will keep them for now
	replace hh_incearn=thearn if ssuid=="066925613210" & spanel==2004 & swave==8 & srefmon==1
	replace hh_inctotinc=thtotinc if ssuid=="066925613210" & spanel==2004 & swave==8 & srefmon==1
	replace hh_incearn=thearn if ssuid=="077228398089" & spanel==2004 & swave==10 & (srefmon>=1 & srefmon<=3)
	replace hh_inctotinc=thtotinc if ssuid=="077228398089" & spanel==2004 & swave==10 & (srefmon>=1 & srefmon<=3)
	replace hh_inctotinc=thtotinc if ssuid=="458925167375" & spanel==2008 & swave==4 & (srefmon>=1 & srefmon<=3)
	* make sure all income add up
	assert hh_inctotinc==thtotinc if thtotinc!=.
	
	*** finally - flag if equal or more than 30% of the HH total ($) is imputed
	local flagimp "earn trninc2 totinc"
	foreach i of local flagimp {
		label variable hh_imp`i' "Total HH income imputed: th`i'"
		gen flag_`i'=((hh_imp`i'/hh_inc`i')>=0.3 & hh_inc`i'!=. & hh_inc`i'>0)
		label variable flag_`i' "flag: 1/3 or more imputed: th`i'"
	}
	* clean variables
	order hh_imp* flag*, last
	drop tptotinc-a75amt incearn-hh_inctotinc

	sort sippid monyear
	***** elaborate scheme just to label "monyear" (STATA counter, 480=January 2000)
	* - hope this was worth doing..
	local inc 12
	local list 480
	local listname "480"
	while `list'<=650{
		local increment=`list'+`inc'
		local listname "`listname' `increment'"
		local list=`list'+`inc'
	}
	* display "`listname'"
	local year 2000
	foreach clist of local listname{
		local counter 0
		local month "Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"
		foreach m of local month {
			local my=`clist'+`counter'
			label define monyear `my' "`m' `year'", modify
			local counter=`counter'+ 1
		}
		local year=`year'+1
	}
	label values monyear monyear
	*****
	* assign # of times in month appeared in the survay
	sort sippid monyear
	by sippid: gen monthinsurvey=_n
	label variable monthinsurvey   "Times in month participated in the survey. i.e. 1=first time"
	gen tmp1 = monyear if monthinsurvey==1
	egen monfirst = min(tmp1), by(sippid)
	label variable monfirst   "Month first participated in the survey"
	egen tmp2 = max(monthinsurvey), by(sippid)
	gen  tmp3 = monyear if tmp2 ==monthinsurvey
	egen monlast  = min(tmp3), by(sippid)
	label variable monlast    "Month last participated in the survey"
	label values monfirst monyear
	label values monlast  monyear
	
	* assign age at the begining and end in the survay
	sort sippid monyear
	replace tmp1 = tage if monthinsurvey==1
	egen agefirst = min(tmp1), by(sippid)
	label variable agefirst   "Age at the first survey participated"
	replace tmp3 = tage if tmp2 ==monthinsurvey
	egen agelast  = min(tmp3), by(sippid)
	label variable agelast    "Age at the last survey participated"
	drop tmp1 tmp2 tmp3
	
******************************************************************************** 
	* the following is from (but I modified a few lines) : 
	* http://ceprdata.org/wp-content/sipp/recode/clean_c_hhfam.do

	* mvdecode _all, mv(-1)  //recode all -1 to missing values
	* above mvdecode works fine, except a few "income" variables (th*) will be affect by this
	* use ds (help ds) instead - this will create a list of variables except for (th*)
	ds th*, not
	mvdecode `r(varlist)', mv(-1=.n)

	* their id is different but essentially the same. set_a_memo.pdf for id setting
	* I will use "sippid" instead of their "id"
	* egen id = concat(ssuid eentaid epppnum) //i changed this - original add id doesn't make sense to us

	* Generate household/family identifiers; See SIPP User's Guide, pp. 10.9 to 10.14.
	* Households
	recode rfid .=0
	recode rfid2 .=0
	recode rsid .=0

	sort ssuid shhadid
	egen hhid = group(ssuid shhadid)
	label var hhid "Unique household ID"
	* Familes, including both primary and subfamlies
	sort ssuid shhadid rfid
	egen pfid = group(ssuid shhadid rfid)
	label var pfid "Unique family ID (Total)"
	* Families, with sub and primary families counted separately
	sort ssuid shhadid rfid2 rsid
	egen sfid = group(ssuid shhadid rfid2 rsid)
	label var sfid "Unique family ID (sub/prim separate)"

	* To match spouses and children, use household id, not entry id.
	* This must be made into a string variable.
	tostring shhadid, replace

	* Generate a variable to match spouses
	* cm: not sure if mvdecode, 9999 to ., is necessary, but I am following the example
	mvdecode epnspous, mv(9999)	
	gen a_spouse = epnspous
	tostring a_spouse, replace
	gen str1 t = "0"
	egen spouse2 = concat(t a_spouse)
	gen spouse = substr(spouse2, -4, 4)
	drop a_spouse spouse2 

	egen shhadid2 = concat(t shhadid)
	drop shhadid
	gen  shhadid = substr(shhadid2, -3, 3)
	label var shhadid "SU: Hhld Address ID differentiates hhlds in"
	drop shhadid2

	egen id = concat(ssuid shhadid epppnum)
	replace id = "" if epppnum==""
	label var id "ID with current addressID (ssuid+shhadid+epppnum)"

	/*generate id based on current address, rather than entry address*/
	egen add_id = concat(ssuid shhadid epppnum)
	replace add_id = "" if epppnum==""
	label var add_id "ID with current address"
	count if add_id==""

	sort ssuid shhadid spouse
	egen s = concat(ssuid shhadid spouse) 
	replace s = "" if epnspous==.
	rename s spouseid
	label var spouseid "ID number of spouse"
	drop spouse

	* Parents are attached to children
	* Generate a person number for each mother, father, and guardian: variables are 4 characters long (96,01)	
	mvdecode epnmom epndad epnguard, mv(9999)
	gen a_mom = epnmom
	gen a_dad = epndad
	gen a_guard = epnguard
	tostring a_mom a_dad a_guard, replace
	egen mom2 = concat(t a_mom)
	egen dad2 = concat(t a_dad)
	egen guard2 = concat(t a_guard)
	gen mom = substr(mom2, -4, 4)
	gen dad = substr(dad2, -4, 4)
	gen guard = substr(guard2, -4, 4)
	drop a_* mom2 dad2 guard2 t

	* Generate an id for each mother, father, and guardian.(96,01)
	sort ssuid shhadid mom
	egen m = concat(ssuid shhadid mom) 
	sort ssuid shhadid dad
	egen d = concat(ssuid shhadid dad)
	sort ssuid shhadid guard
	egen g = concat(ssuid shhadid guard)
	drop mom dad guard
	replace m = "" if epnmom==.
	replace d = "" if epndad==.
	replace g = "" if epnguard==.

	* Recode guardian as missing if same as mother or father	
	replace g = "" if m==g
	replace g = "" if d==g

	* Recode Guardians as mothers or fathers
	replace g = "NA" if g==""
	sort g srefmon swave
	compress
	save chpt, replace
	keep id esex srefmon swave
	rename esex psex
	rename id g
	sort  g srefmon swave
	merge g srefmon swave using chpt
	tab _merge
	keep if _merge==2 | _merge==3
	drop _merge
	* gen m2=m
	* gen d2=d
	replace m = g if m=="" & psex==2 & g~="NA"
	replace d = g if d=="" & psex==1 & g~="NA"

	gen f_guard=(g!="NA")
	rename m momid
	rename d dadid
	rename g guardid
	label var momid   "ID number of mom (or female gurdian)"
	label var dadid   "ID number of dad (or male gurdian)"
	label var guardid "ID number of guardian"
	label var f_guard "Flag: having guardian not parent(s)"
	drop psex

	order sippid ssuid shhadid ehhnumpp eentaid epppnum rhtype rhchange errp /*
	*/ rfid rfid2 epnspous rsid epnmom epndad epnguard /*
	*/ lgtkey gvarstr rhcalyr monyear month spanel swave /*
	*/ srefmon rhcalmn monthinsurvey lgtcywt/*
	*/ tfipsst tmovrflg tage esex erace eorigin ebornus ecitizen /*
	*/ eeducate rmesr ersnowrk evaques rhpov thpndist-thtotinc hh_imp* flag* /*
	*/ id add_id hhid pfid sfid spouseid momid dadid guardid f_guard 
	sort id
	
	*Generate child and adult dummies
	gen byte child = tage<18 & tage>=0 & tage~=.
	gen byte adult = tage>=18 & tage~=.
	sum child adult

	* gen numeric id variable
	gen str10 ida = substr(id,1,10)
	gen str10 idb = substr(id,11,.)
	gen double idax = real(ida)
	gen double idbx = real(idb)
	egen idx = group(idax idbx)
	drop ida* idb*

	/*
	Generate a unique sub-family id which can be used as the categorical equivalent of m,d,p,g 
	so later we can use sfid/hhid as the categorical equivalent of id to identify subfamilies/hh
	*/
	gen s = sfid
	gen h = hhid

	sort hhid swave srefmon
	egen hh_adult = sum(adult), by(hhid swave srefmon)
	egen hh_child = sum(child), by(hhid swave srefmon)
	label var hh_adult "Number of adults in hh"
	label var hh_child "Number of children under 18 in hh"
	egen hh_total = count(idx), by(hhid swave srefmon)
	label var hh_total "Number of people in hh"

	drop child adult idx s h
	drop add_id hhid pfid sfid spouseid
	* dataset with child id, parent ids only.

	save chpt2, replace

********************************************************************************
	save ../../../sippl`x'puw_allwaves_withlgtwgt, replace
	* make a list of age under 18 at the end of panels (2004 or 2009)
	keep if tage<18 & month=="20`x2'"
	keep sippid
	sort sippid
	save ../../../sippl`x'puw_und18asof20`x2', replace	
	cd ../../../
}

***** combine 2004 & 2008 panels

local panels "04 08"
foreach x of local panels{
	use sippl`x'puw_allwaves_withlgtwgt, clear
	keep monyear
	sort monyear
	by monyear: gen dup=cond(_N==1,0,_n)
	keep if dup<2
	drop dup
	drop if monyear==.
	gen order=1
	sort order
	save monyear_unique`x', replace

	use sippl`x'puw_allwaves_withlgtwgt, clear
	keep sippid
	drop if sippid==""
	sort sippid
	by sippid: gen dup=cond(_N==1,0,_n)
	keep if dup<2
	drop dup
	gen order=1
	sort order
	joinby order using monyear_unique`x'
	drop order
	sort sippid monyear
	save sippmonyear_unique`x', replace

	use sippl`x'puw_allwaves_withlgtwgt, clear
	drop if sippid==""
	* making data with constant spacing (real monthly)
	sort sippid monyear
	merge 1:1 sippid monyear using sippmonyear_unique`x'
	assert _merge!=1
	sort sippid monyear
	drop _merge
	saveold sippl`x'puw_allwaves_withlgtwgt_balanced, replace
}

use sippl04puw_allwaves_withlgtwgt_balanced, clear
* append 2008 panel
append using sippl08puw_allwaves_withlgtwgt_balanced
drop if sippid==""
compress
sort sippid
saveold sippl0408puw_allwaves_withlgtwgt, replace

* list of child age under 18 as of at the end of each panel
use sippl04puw_und18asof200709, clear
* append using sippl08puw_und18asof201208
append using sippl08puw_und18asof201212
sort sippid
saveold sippl0408puw_und18, replace

* select chld age under 18 only
use  sippl0408puw_allwaves_withlgtwgt, clear
sort sippid
merge m:1 sippid using sippl0408puw_und18
keep if _merge==3
drop _merge
sort sippid monyear
saveold sippl0408puw_allwaves_withlgtwgt_und18, replace

* merge parent/guardian information..
use sippl0408puw_allwaves_withlgtwgt, clear
* keep the variables that matter to parents only
keep id monyear monthinsurvey sippid tage esex erace eorigin ebornus ecitizen eeducate rmesr ersnowrk 
preserve
* rename vars for mom to avoid unintended var mergeing
foreach v of varlist *{
	local newname="m_`v'"
	rename `v' `newname'
}
rename m_id  momid
rename m_monyear monyear
drop if momid==""
sort momid monyear
saveold sippl0408puw_allwaves_withlgtwgt_mom, replace
restore
* rename vars for dad to avoid unintended var mergeing
foreach v of varlist *{
	local newname="d_`v'"
	rename `v' `newname'
}
rename d_id  dadid
rename d_monyear monyear
drop if dadid==""
sort dadid monyear
saveold sippl0408puw_allwaves_withlgtwgt_dad, replace

use sippl0408puw_allwaves_withlgtwgt_und18, clear
* we don't need education & employment code for children
drop eeducate rmesr ersnowrk evaques
* add mom information
sort momid monyear
merge m:1 momid monyear using sippl0408puw_allwaves_withlgtwgt_mom
keep if _merge==1 | _merge==3
drop _merge
* add dad information
sort dadid monyear
merge m:1 dadid monyear using sippl0408puw_allwaves_withlgtwgt_dad
keep if _merge==1 | _merge==3
drop _merge
sort  sippid monyear
order sippid monyear
saveold sippl0408puw_allwaves_withlgtwgt_und18withparentinfo, replace

use sippl0408puw_allwaves_withlgtwgt_und18withparentinfo, clear
/***** Geographic variables ****/
* add geographic values..
sort tfipsst
merge m:1 tfipsst using states
drop if _merge==2
drop state name statens division region intptlat intptlon pop10sf1 hu10sf1 popdensity areatotal arealand areawater _merge
order sippid-tfipsst fips stusab
sort sippid monyear

***** inflation adjustment
* 2012 average using cpi: ftp://ftp.bls.gov/pub/special.requests/cpi/cpiai.txt
merge using cpimonth //make sure to keep the 2000-2013 monthly cpi table (cpimonth.dta) in the same directory
local incomes "thpndist thlumpsm thnoncsh thsocsec thssi thunemp thvets thafdc thfdstp thearn thprpinc thtrninc thtrninc2 thothinc thtotinc hh_impearn hh_imptrninc2 hh_imptotinc"
quietly{
	foreach inc of local incomes{
		gen adj`inc'=.
		local vlabel: variable label `inc'
		label variable adj`inc' "CPI-adjusted: `vlabel'"
		foreach var of varlist cpi200301-cpi201310{
			local monyr=substr("`var'",4,6)
			summarize `var'
			local mcpi=r(max)
			replace adj`inc'=`inc'*229.594/`mcpi' if month=="`monyr'"
			*base year=2012, annual average: 229.594
		}
	}
}
drop cpi20* _merge //drop/get rid of cpi values obtained from cpi.dta table
***** 
saveold sippl0408puw_allwaves_withlgtwgt_und18withparentinfo_cpi, replace

use     sippl0408puw_allwaves_withlgtwgt_und18withparentinfo_cpi, clear
***** calculate time-invariant % imputed in the total HH income (after djusted)
sort sippid
foreach var of varlist adjthearn adjthtrninc2 adjthtotinc{
	egen tot`var' = sum(`var'), by(sippid)
	replace tot`var' =. if `var'==.
	label variable tot`var' "Total, panel-wide HH income: `var'"
}
foreach var of varlist adjhh_impearn adjhh_imptrninc2 adjhh_imptotinc{
	egen tot`var' = sum(`var'), by(sippid)
	replace tot`var' =. if `var'==.
	label variable tot`var' "Total imputed, panel-wide HH income: `var'"
}
* calculate %
local incs earn trninc2 totinc
foreach var of local incs{
	gen pimpadj`var'=totadjhh_imp`var'/totadjth`var'
	gen fimpadj`var'=pimpadj`var'>=0.3
	replace fimpadj`var'=. if pimpadj`var'==.
	label variable pimpadj`var' "% imputed, panel-wide HH income: adjth`var'"
	label variable fimpadj`var' "Flag: 1/3 or more imputed: adjth`var'"
}

local selectedincome "earn trninc2 totinc"
foreach inc of local selectedincome {
	* can coefficient of variance measure income variability? - if so..
	* but of course CV has many disadvantages: zero mean, minus variance
	* so, CV is not the best measure of income variability..
	sort sippid rhcalyr
	gen cvadjth`inc'=.
	by sippid rhcalyr: egen meanadjth`inc'=mean(adjth`inc')
	by sippid rhcalyr: egen sdadjth`inc'=sd(adjth`inc')
	replace meanadjth`inc'=. if adjth`inc'==.
	replace sdadjth`inc'  =. if adjth`inc'==.
	replace cvadjth`inc'=100*sdadjth`inc'/meanadjth`inc'
	replace cvadjth`inc'=100*sdadjth`inc'/1  if meanadjth`inc'==0 //several HH don't have any income
	replace cvadjth`inc'=abs(cvadjth`inc') if cvadjth`inc'<0  //reverse the negative variance
	label variable meanadjth`inc' "Annual mean of the CPI-adjusted HH income: adjth`inc'"	
	label variable sdadjth`inc'   "Annual SD of the CPI-adjusted HH income: adjth`inc'"	
	label variable cvadjth`inc'   "Annual CV of the CPI-adjusted HH income: adjth`inc'"	

	* assign "arc percent change" variable
	sort sippid monyear
	by sippid: gen lag=adjth`inc'[_n-1]
	gen arcchgth`inc'=(adjth`inc'-lag)/((adjth`inc'+lag)/2)*100 //arc% change=change/period average
	replace arcchgth`inc'=abs(arcchgth`inc') //make negatives to positives
	replace arcchgth`inc'=. if adjth`inc'==.
	label variable arcchgth`inc' "Arc% monthly income change: adjth`inc'"
	
	* assign "frequency of large income changes" variable
	sort sippid monyear
	* by sippid: gen lag=adjth`inc'[_n-1]
	gen change=adjth`inc'-lag
	gen f_lchange=.
	replace f_lchange=1 if abs(change)>(meanadjth`inc'*0.33) & lag!=. //flag if diff is .33>mean
	sort sippid 
	by sippid: egen cntlchgth`inc'=count(f_lchange)
	replace cntlchgth`inc'=. if adjth`inc'==.
	label variable cntlchgth`inc' "Frequency of large income changes throughout panel: adjth`inc'"
	drop lag change f_lchange
}

* create a unique & shorter sippid
sort sippid
by sippid: gen sippid2=1 if _n==1 
* egen (group) is better but didn't work well as I thought..
* egen sippid2=group(sippid)
order sippid sippid2
replace sippid2=sum(sippid2)
label variable sippid2 "Short unique panel-HH-person unique ID"

/***** Household level variables ****/
* use  sippl0408puw_temp, clear
* assign time-invariant HH type (based on mode/the most often assigned type)
sort sippid
by sippid: egen moderhtype=mode(rhtype)
replace moderhtype=. if rhtype==.
label variable moderhtype   "HH type (most often coded throughout survey)"
label save rhtype using label_rhtype, replace
quietly do label_rhtype
label values moderhtype rhtype

* household composition change
* note: rhchange is not the same as "HH type change"
* the var (rhchange) was in the original file but "no change" is coded 2
replace rhchange=0 if rhchange==2
label variable rhchange "Flag: change in HH composition"
label define rhchange 0 `"No change in HH composition"', modify
label define rhchange 1 `"Change in HH composition"', modify
label values rhchange rhchange

* household type change
sort sippid monyear
* assign the HH type of the previous month
by sippid: gen templag=rhtype[_n-1]
gen     chgrhtype=(rhtype!=templag & templag!=.)
replace chgrhtype=. if rhtype==. | templag==.
drop templag
label variable chgrhtype "Flag: change: HH type"
label define chgrhtype 0 `"No change in HH type"', modify
label define chgrhtype 1 `"Change in HH type"', modify
label values chgrhtype chgrhtype

* residential change:
* assign initial value, 1, for the first entry month (i.e. new to sample)
gen    chgresinstate=(tmovrflg==2 | tmovrflg==3)
gen    chgresoutstate=(tmovrflg==4)
* but the problem is: move code repeated for the rest of the wave month
* and we want to keep only the first record
* see: http://www.stata.com/support/faqs/data-management/first-and-last-occurrences/
sort sippid monyear
by   sippid swave (monyear), sort: gen tmp1=sum(chgresinstate)==1 & sum(chgresinstate[_n-1])==0
by   sippid swave (monyear), sort: gen tmp2=sum(chgresoutstate)==1 & sum(chgresoutstate[_n-1])==0
* now update the chngresidence with first (flag, first move recorded in each wave)
replace chgresinstate =tmp1 if chgresinstate ==1
replace chgresoutstate=tmp2 if chgresoutstate==1
* now for "alternative measures (refmon=4 only)", move the code from the actual month to refmon=4
drop tmp1 tmp2
by   sippid swave (monyear), sort: egen tmp1=sum(chgresinstate)
by   sippid swave (monyear), sort: egen tmp2=sum(chgresoutstate)
replace chgresinstate =0 if chgresinstate ==1
replace chgresoutstate=0 if chgresoutstate==1
replace chgresinstate =tmp1 if srefmon ==4
replace chgresoutstate=tmp2 if srefmon ==4
drop tmp1 tmp2

gen chgresidence=(chgresinstate>0|chgresoutstate>0)
label variable chgresinstate  "Flag: residence changed, within same state"
label variable chgresoutstate "Flag: residence changed, moved to another state"
label variable chgresidence   "Flag: whether residence changed (per wave)"
label define chgresidence 0 `"No move"', modify
label define chgresidence 1 `"Moved, this wave"', modify
label values chgresinstate chgresidence
label values chgresoutstate chgresidence
label values chgresidence chgresidence
* Weird case: "New to sample" (wave 10, month 4) assigned while continuing participation
* brow sippid monyear tmovrflg swave srefmon chgresidence first if sippid=="20040192285870680105"

* add monthly household poverty status
gen poverty=(rhpov>thtotinc)
replace poverty=. if rhpov==. | thtotinc==.
label variable poverty "Flag: whether household is in poverty (by month)"
label define poverty 0 "Not in Poverty" 1 "In Poverty"
label values poverty poverty

/***** Individual level demographic variables ****/
local who "self mom dad"
* quietly{
foreach w of local who{
	if "`w'"=="self"{
		* assign time-invariant race category
		* be aware: responses can change. see: m_sippid=="2004019228130434010" - change of eorigin/hispanic answers
		sort sippid monthinsurvey
		* gen, rtemp, to keep the first race value
		* by   sippid monthinsurvey: gen rtemp=(erace==1 & eorigin==2) if monthinsurvey==1
		gen rtemp=(erace==1 & eorigin==2) if monthinsurvey==1 
		replace rtemp=2 if erace==2 & eorigin==2 & monthinsurvey==1
		replace rtemp=3 if erace==3 & eorigin==2 & monthinsurvey==1
		replace rtemp=4 if erace==4 & eorigin==2 & monthinsurvey==1
		replace rtemp=5 if eorigin==1
		* copy rtemp - the first race value and then drop rtemp
		by sippid: egen race=min(rtemp)
		drop rtemp
		replace race=. if erace==. | eorigin==.
		label variable race  "Race at the first entry: nhwhite, nhblack, nhasian, nhother, hispanic"
		label define race 1 `"NH White"', modify
		label define race 2 `"NH Black"', modify
		label define race 3 `"NH Asian"', modify
		label define race 4 `"NH Other"', modify
		label define race 5 `"Hispanic"', modify
		label values race race
	}
	else{
		* just mind that mom and dad can be repeated - not unique!
		if "`w'"=="mom"{
			local varid="m_sippid"
			local varhead="m_"
		}
		else if "`w'"=="dad"{
			local varid="d_sippid"
			local varhead="d_"
		}
		* assign time-invariant race category
		sort `varid' `varhead'monthinsurvey
		by   `varid': egen mintemp=min(`varhead'monthinsurvey)
		* gen, rtemp, to keep the first race value
		by   `varid': gen rtemp=(`varhead'erace==1 & `varhead'eorigin==2) if `varhead'monthinsurvey==mintemp
		by   `varid': replace rtemp=2 if `varhead'erace==2 & `varhead'eorigin==2 & `varhead'monthinsurvey==mintemp
		by   `varid': replace rtemp=3 if `varhead'erace==3 & `varhead'eorigin==2 & `varhead'monthinsurvey==mintemp
		by   `varid': replace rtemp=4 if `varhead'erace==4 & `varhead'eorigin==2 & `varhead'monthinsurvey==mintemp
		by   `varid': replace rtemp=5 if `varhead'eorigin==1 & `varhead'monthinsurvey==mintemp
		* copy rtemp - the first race value and then drop rtemp
		sort `varid'
		by   `varid': egen `varhead'race=min(rtemp)
		drop  mintemp rtemp
		replace `varhead'race=. if `varhead'erace==. | `varhead'eorigin==.
		label variable `varhead'race  "Race at the first entry: nhwhite, nhblack, nhasian, nhother, hispanic"
		label define race 1 `"NH White"', modify
		label define race 2 `"NH Black"', modify
		label define race 3 `"NH Asian"', modify
		label define race 4 `"NH Other"', modify
		label define race 5 `"Hispanic"', modify
		label values `varhead'race race
	}
}
* nativity - first entry
sort sippid monthinsurvey
* gen, rtemp, to keep the first race value
gen rtemp=ebornus if monthinsurvey==1 
* copy rtemp - the first value and then drop rtemp
* save value label first
label save ebornus using label_ebornus, replace
drop ebornus
by sippid: egen ebornus=min(rtemp)
drop rtemp
replace ebornus=. if monthinsurvey==.
label variable ebornus  "PE: Respondent was born in the U.S."
do label_ebornus

* state - mode (most often) by year
sort sippid rhcalyr
* gen, rtemp, to keep the first race value
by sippid rhcalyr: egen modetfipsst=mode(tfipsst)
replace modetfipsst=. if tfipsst==.
* save value label
label save tfipsst using label_tfipsst, replace
replace tfipsst=. if monthinsurvey==.
label variable modetfipsst   "HH: FIPS State Code (most often coded by year)"
do label_tfipsst

/***** Individual level "change" variables ****/

* IMPORTANT NOTE: We don't care if mom/dad changed

* create mode of employment status by year
sort sippid rhcalyr
by sippid rhcalyr: egen m_modermesr=mode(m_rmesr)
by sippid rhcalyr: egen d_modermesr=mode(d_rmesr)
replace m_modermesr=. if m_rmesr==.
replace d_modermesr=. if d_rmesr==.
label variable m_modermesr   "Mom employment status (most often coded by year)"
label variable d_modermesr   "Dad employment status (most often coded by year)"
label save rmesr using label_rmesr, replace
quietly do label_rmesr
label values m_modermesr rmesr
label values d_modermesr rmesr

* create mode of unemployment reason by year
sort sippid rhcalyr
by sippid rhcalyr: egen m_modeersnowrk=mode(m_ersnowrk)
by sippid rhcalyr: egen d_modeersnowrk=mode(d_ersnowrk)
replace m_modeersnowrk=. if m_ersnowrk==.
replace d_modeersnowrk=. if d_ersnowrk==.
label variable m_modeersnowrk   "Mom employment status (most often coded by year)"
label variable d_modeersnowrk   "Dad employment status (most often coded by year)"
label save ersnowrk using label_ersnowrk, replace
quietly do label_ersnowrk
label values m_modeersnowrk ersnowrk
label values d_modeersnowrk ersnowrk

* employment status change:
* I will simplify the original employment code (rmesr) first..
* mom info -
gen    m_emp=m_rmesr
recode m_emp (-1=.) (6/8=0) (1/5=1)
sort sippid monyear
by sippid: gen m_templag=m_emp[_n-1]
gen     m_chgemp=(m_emp!=m_templag)
replace m_chgemp=. if m_emp==. | m_templag==.
* dad info -
gen    d_emp=d_rmesr
recode d_emp (-1=.) (6/8=0) (1/5=1)
sort sippid monyear
by sippid: gen d_templag=d_emp[_n-1]
gen     d_chgemp=(d_emp!=d_templag)
replace d_chgemp=. if d_emp==. | d_templag==.

label variable m_emp  "Mom employed at least one week in a month"
label variable d_emp  "Dad employed at least one week in a month"
label define emp 1 "Employed at least one week in a month" 0 "In LF, not employed all month", modify
label values m_emp emp
label values d_emp emp
label variable m_chgemp "Mom's emp.status change from prev.month"
label variable d_chgemp "Dad's emp.status change from prev.month"
label define chgemp 1 "Change" 0 "No change", modify
label values m_chgemp chgemp
label values d_chgemp chgemp

* add dummies for employment status
gen m_unemployed=(m_rmesr>=6 & m_rmesr<=8)
gen d_unemployed=(d_rmesr>=6 & d_rmesr<=8)
replace m_unemployed=. if m_rmesr==.
replace d_unemployed=. if d_rmesr==.
label variable m_unemployed "Mom, unemployed/no work in a month"
label variable d_unemployed "Dad, unemployed/no work in a month"

drop *_templag

compress
sort sippid monyear
saveold sippl0408puw_analysisdata_all, replace
keep if ssuid!=""
saveold sippl0408puw_analysisdata, replace
describe

* For later use.. save value labels in a do file
label save monyear using label_monyear, replace
label save rhtype using label_rhtype, replace
label save rhchange using label_rhchange, replace
label save errp using label_errp, replace
label save rfid2l using label_rfid2l, replace
label save epnspous using label_epnspous, replace
label save rsid using label_rsid, replace
label save epnmom using label_epnmom, replace
label save epndad using label_epndad, replace
label save epnguard using label_epnguard, replace
label save srefmon using label_srefmon, replace
label save rhcalmn using label_rhcalmn, replace
label save tfipsst using label_tfipsst, replace
label save tage using label_tage, replace
label save esex using label_esex, replace
label save race using label_race, replace
label save ebornus using label_ebornus, replace
label save ecitizen using label_ecitizen, replace
label save eeducate using label_eeducate, replace
label save rmesr using label_rmesr, replace
label save ersnowrk using label_ersnowrk, replace
label save chgrhtype using label_chgrhtype, replace
label save chgresidence using label_chgresidence, replace
label save poverty using label_poverty, replace
label save emp using label_emp, replace

/*******************************************************************************
Now we want individual annual average data
*******************************************************************************/

/*****CALCULATE AVERAGE MONTHLY GROWTH - avoid running this part, takes 10+ hours****
local selectedincome "totinc trninc2 earn"
foreach inc of local selectedincome {
	use sippl0408puw_analysisdata, clear
	sort  sippid2 monyear 
	keep  sippid2 monyear rhcalyr adjth`inc'
	* statsby, by(pid): regress inc2needs year //very slow + results saved in a new table, not efficient
	* helpful site - run regression by group + retain returned results: http://www.stata.com/statalist/archive/2004-01/msg00690.html
	* helpful site - save returned results: http://www.ats.ucla.edu/stat/stata/faq/returned_results.htm
	* helpful site - skip errors + calc ave annual growth with OLS: http://www.stata.com/statalist/archive/2004-03/msg00902.html

	gen th`inc'growth=.
	label variable th`inc'growth "Average monthly income growth rate: ln(adjth`inc')"
	gen slope=.
	gen intcp=.
	gen lnadjth`inc'=.
	quietly replace lnadjth`inc'=ln(adjth`inc')
	local years 2004 2005 2006 2007 2009 2010 2011 2012 
	foreach yr of local years{
		* regress income to needs ratio on year - this portion takes a long time to finish.....
		* create a new local macro, bypid, by grouping longitudinal records by pid = unit of regression
		quietly levelsof sippid2, local(bysippid2)
		quietly foreach  p of local bysippid2{
			capture regress lnadjth`inc' monyear if sippid2==`p' & rhcalyr==`yr' //capture and skip regression in case of too few observataions
			capture quietly replace slope=_b[monyear] if sippid2==`p' & rhcalyr==`yr' 
			replace th`inc'growth=exp(slope)-1 if sippid2==`p' & rhcalyr==`yr'
		}
	}
	keep sippid2 monyear th`inc'growth
	sort sippid2 monyear
	save sippid2_annualgrowthrate_analysisdata_th`inc', replace
}
*****END OF GROWTH RATE CALCULATION****/

*****REPEAT FOR ALTERNATE (SREFMON==4 ONLY) MEASURE****
* merge back to the original data
use sippl0408puw_analysisdata, clear
* keep srefmon==4 only
keep if srefmon==4
saveold sippl0408puw_analysisdata_srefmon4, replace

/*****CALCULATE AVERAGE MONTHLY GROWTH - avoid running this part, takes 10+ hours FOR ALTERNATE (SREFMON==4 ONLY) MEASURE****
local selectedincome "totinc trninc2 earn"
foreach inc of local selectedincome {
	use sippl0408puw_analysisdata_srefmon4, clear
	sort  sippid2 monyear 
	keep  sippid2 monyear rhcalyr adjth`inc'
	* statsby, by(pid): regress inc2needs year //very slow + results saved in a new table, not efficient
	* helpful site - run regression by group + retain returned results: http://www.stata.com/statalist/archive/2004-01/msg00690.html
	* helpful site - save returned results: http://www.ats.ucla.edu/stat/stata/faq/returned_results.htm
	* helpful site - skip errors + calc ave annual growth with OLS: http://www.stata.com/statalist/archive/2004-03/msg00902.html

	gen th`inc'growth=.
	label variable th`inc'growth "Average monthly income growth rate: ln(adjth`inc')"
	gen slope=.
	gen intcp=.
	gen lnadjth`inc'=.
	quietly replace lnadjth`inc'=ln(adjth`inc')
	local years 2004 2005 2006 2007 2009 2010 2011 2012 
	foreach yr of local years{
		* regress income to needs ratio on year - this portion takes a long time to finish.....
		* create a new local macro, bypid, by grouping longitudinal records by pid = unit of regression
		quietly levelsof sippid2, local(bysippid2)
		quietly foreach  p of local bysippid2{
			capture regress lnadjth`inc' monyear if sippid2==`p' & rhcalyr==`yr' //capture and skip regression in case of too few observataions
			capture quietly replace slope=_b[monyear] if sippid2==`p' & rhcalyr==`yr' 
			replace th`inc'growth=exp(slope)-1 if sippid2==`p' & rhcalyr==`yr'
		}
	}
	keep sippid2 monyear th`inc'growth
	sort sippid2 monyear
	save sippid2_annualgrowthrate_analysisdata_srefmon4_th`inc', replace
}

*****END OF GROWTH RATE CALCULATION FOR ALTERNATE (SREFMON==4 ONLY) MEASURE****/

* we need two different set of final data
* one - annual using all months
* two - annual but using reference month==4 (srefmon==4) only 

* first create "annual" data from all SIPP monthly data
do program_makeannual analysisdata          annual
do program_makeannual analysisdata_srefmon4 annual_srefmon4

* then merge state policy data
do program_stpolicies annual
do program_stpolicies annual_srefmon4

exit
