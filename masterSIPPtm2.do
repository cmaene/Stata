/*******************************************************************************
STEP 1: DOWNLOAD STATA DATA & ANCILIRARY FILES FROM NBER.ORG

disclaimer of the files:
**  Note:  This program is distributed under the GNU GPL. See end of
**  this file and http://www.gnu.org/licenses/ for details.
**  by Jean Roth Wed Nov  3 15:36:37 EDT 2010
**  Please report errors to jroth@nber.org
*******************************************************************************
cd F:\Prof_Ybarra\SIPP\
* download bulk files from nber.org using wget unitility
* could have used "copy" but I like how wget preserves file organization
* wget is a native utility for Unix, no need to download/install anything
* if using wget in Windows, wget.exe must be downloaded and also path to 
* wget.exe must to be added to the environment variables
*/
*******************************************************************************
* 1996 panel - we don't use this but I process them as a comparison
/* get data files from census to make sure NBER files are updated
shell wget -mrnp http://thedataweb.rm.census.gov/pub/sipp/1996/tm96puw2.zip
shell wget -mrnp http://thedataweb.rm.census.gov/pub/sipp/1996/l96puw2.zip

better to get files from BNER because they are cleaned
local type    pdf   pdf  zip   zip   do   do   dct  dct   
local prefix  p96t2 p96l p96t2 p96l2 96t2 96l2 96t2 96l2  
forvalues i=1/8{
	local v1: word `i' of `type'
	local v2: word `i' of `prefix'
	shell wget -mrnp  http://www.nber.org/sipp/1996/sip`v2'.`v1'
	if "`v1'"=="zip"{
		cd www.nber.org/sipp/1996/
		unzipfile sip`v2'.`v1', replace
		cd ../../../
	}	
}
* NOTE: modify the do & dct files first
cd www.nber.org/sipp/1996/
do sip96l2
compress
save sipp96w2, replace
log close
clear all
do sip96t2
compress
save sipp96t2, replace
log close
clear all
cd ../../../
*/
*******************************************************************************
* 2001 panel
/* get data files from census to make sure NBER files are updated
shell wget -mrnp http://thedataweb.rm.census.gov/pub/sipp/2001/l01puw2.zip //replace NBER file
shell wget -mrnp http://thedataweb.rm.census.gov/pub/sipp/2001/p01putm2.zip
shell wget -mrnp http://thedataweb.rm.census.gov/pub/sipp/2001/p01ptm2d.txt
*/
/*
local type    pdf   pdf   zip   zip   do   do   dct  dct   
local prefix  p01t2 p01w2 p01t2 p01w2 01t2 01w2 01t2 01w2 
forvalues i=1/8{
	local v1: word `i' of `type'
	local v2: word `i' of `prefix'
	shell wget -mrnp  http://www.nber.org/sipp/2001/sip`v2'.`v1'
	if "`v1'"=="zip"{	
		cd www.nber.org/sipp/2001/
		unzipfile sip`v2'.`v1', replace
		cd ../../../
	}
}*/
/* get all core files
forvalues num=1/9{
	shell wget -mrnp  http://www.nber.org/sipp/2001/sipp01w`num'.zip
	shell wget -mrnp  http://www.nber.org/sipp/2001/sip01w`num'.do
	shell wget -mrnp  http://www.nber.org/sipp/2001/sip01w`num'.dct
}*/
* NOTE: modify the do files first
forvalues num=1/9{
	clear all //need to clear previous label definitions
	cd www.nber.org/sipp/2001/
	*unzipfile sipp01w`num'.zip, replace
	quietly do sip01w`num'.do
	egen sippid=concat(spanel ssuid epppnum)
	* keep if srefmon==4
	keep  sippid spanel swave rhcalyr rhcalmn srefmon tfipsst tmovrflg eeducate
	order sippid spanel swave rhcalyr rhcalmn srefmon tfipsst tmovrflg eeducate
	sort sippid
	compress
	save sipp01w`num'_selevars, replace
	capture log close
	cd ../../../
}
use www.nber.org/sipp/2001/sipp01w1_selevars, clear
forvalues num=2/9{
	append using www.nber.org/sipp/2001/sipp01w`num'_selevars
}
save sipp01wall_selevars, replace
* NOTE: modify the do & dct files first
cd www.nber.org/sipp/2001/
do sip01t2
compress
* citizenship variable is different from 2004/2008
gen ecitiznt=tcitiznt
replace ecitiznt=1 if tcitiznt==2
replace ecitiznt=-1 if tcitiznt==-1
label variable ecitiznt "MG: U.S. citizenship"

save sipp01t2, replace
log close
clear all
cd ../../../
*******************************************************************************
* 2004 panel
/* get data files from census to make sure NBER files are updated
shell wget -mrnp http://thedataweb.rm.census.gov/pub/sipp/2004/l04puw2.zip
shell wget -mrnp http://thedataweb.rm.census.gov/pub/sipp/2004/p04putm2.zip
shell wget -mrnp http://thedataweb.rm.census.gov/pub/sipp/2004/p04tm2d.txt
*/
/*
local type    pdf   pdf    zip   zip   do   do   dct  dct   
local prefix  p04t2 p04w2c p04t2 p04w2 04t2 04w2 04t2 04w2 
forvalues i=1/8{
	local v1: word `i' of `type'
	local v2: word `i' of `prefix'
	shell wget -mrnp  http://www.nber.org/sipp/2004/sip`v2'.`v1'
	if "`v1'"=="zip"{	
		cd www.nber.org/sipp/2004/
		unzipfile sip`v2'.`v1', replace
		cd ../../../
	}
}*/
/* get all core files
forvalues num=1/12{
	shell wget -mrnp  http://www.nber.org/sipp/2004/sipp04w`num'.zip
	shell wget -mrnp  http://www.nber.org/sipp/2004/sip04w`num'.do
	shell wget -mrnp  http://www.nber.org/sipp/2004/sip04w`num'.dct
}*/
* NOTE: modify the do files first
forvalues num=1/12{
	clear all //need to clear previous label definitions
	*cd www.nber.org/sipp/2004/
	*unzipfile sipp04w`num'.zip, replace
	*quietly do sip04w`num'.do
	use ../../Prof_Hill/SIPP/www.nber.org/sipp/2004/sippl04puw`num', clear
	egen sippid=concat(spanel ssuid epppnum)
	* keep if srefmon==4
	keep  sippid spanel swave rhcalyr rhcalmn srefmon tfipsst tmovrflg eeducate
	order sippid spanel swave rhcalyr rhcalmn srefmon tfipsst tmovrflg eeducate
	sort sippid
	compress
	save www.nber.org/sipp/2004/sipp04w`num'_selevars, replace
	capture log close
	*cd ../../../
}
use www.nber.org/sipp/2004/sipp04w1_selevars, clear
forvalues num=2/12{
	append using www.nber.org/sipp/2004/sipp04w`num'_selevars
}
save sipp04wall_selevars, replace

* NOTE: modify the do & dct files first
cd www.nber.org/sipp/2004/
do sip04t2
compress
save sipp04t2, replace
log close
clear all
cd ../../../
*******************************************************************************
* 2008 panel
/* get data files from census to make sure NBER files are updated
shell wget -mrnp http://thedataweb.rm.census.gov/pub/sipp/2008/l08puw2.zip
shell wget -mrnp http://thedataweb.rm.census.gov/pub/sipp/2008/p08putm2.zip
shell wget -mrnp http://thedataweb.rm.census.gov/pub/sipp/2008/p08tm1d.txt
*/
/*
local type    pdf       pdf      zip     zip      do          do           dct         dct   
local prefix  sipp08w2c 2008w2tm l08puw2 p08putm2 sippl08puw2 sippp08putm2 sippl08puw2 sippp08putm2
forvalues i=1/8{
	local v1: word `i' of `type'
	local v2: word `i' of `prefix'
	shell wget -mrnp  http://www.nber.org/sipp/2008/`v2'.`v1'
	if "`v1'"=="zip"{	
		cd www.nber.org/sipp/2008/
		unzipfile `v2'.`v1', replace
		cd ../../../
	}
}*/
/* get all core files
forvalues num=1/14{
	shell wget -mrnp  http://www.nber.org/sipp/2008/l08puw`num'.zip
	shell wget -mrnp  http://www.nber.org/sipp/2008/sippl08puw`num'.do
	shell wget -mrnp  http://www.nber.org/sipp/2008/sippl08puw`num'.dct
}*/
* NOTE: modify the do files first
forvalues num=1/14{
	clear all //need to clear previous label definitions
	cd 
	*unzipfile l08puw`num'.zip, replace
	* quietlypuo sippl08puw`num'.do
	use ../../Prof_Hill/SIPP/www.nber.org/sipp/2008/sippl08puw`num', clear
	egen sippid=concat(spanel ssuid epppnum)
	* keep if srefmon==4
	keep  sippid spanel swave rhcalyr rhcalmn srefmon tfipsst tmovrflg eeducate
	order sippid spanel swave rhcalyr rhcalmn srefmon tfipsst tmovrflg eeducate
	sort sippid
	compress
	save www.nber.org/sipp/2008/sipp08w`num'_selevars, replace
	capture log close
}
use www.nber.org/sipp/2008/sipp08w1_selevars, clear
forvalues num=2/14{
	append using www.nber.org/sipp/2008/sipp08w`num'_selevars
}
save sipp08wall_selevars, replace

* NOTE: modify the do & dct files first
cd www.nber.org/sipp/2008/
do sippp08putm2
compress
save sipp08t2, replace
log close
clear all
cd ../../../

/*******************************************************************************
STEP 2: PROCESS DATA
*******************************************************************************/

* append 2001-2004-2008 topical module 2
use www.nber.org/sipp/2008/sipp08t2, clear
local years 04 01
quietly{
	foreach yr of local years{
		append using www.nber.org/sipp/20`yr'/sipp`yr't2
	}
	* append using www.nber.org/sipp/1996/sipp96t2 //we don't need 1996
}
egen sippid=concat(spanel ssuid epppnum)
label variable sippid "panel-HH-person unique ID: spanel+ssuid+epppnum"
sort sippid
order sippid
save sipp010408t2, replace

* append 2001-2004-2008 core file, all waves
use sipp08wall_selevars, clear
append using sipp04wall_selevars
append using sipp01wall_selevars

* assign # of times in month appeared in the survay
sort sippid rhcalyr rhcalmn
by sippid: gen monthinsurvey=_n
label variable monthinsurvey   "Times in month participated in the survey. i.e. 1=first time"
	
******************************* residential state change:
* assign initial value, 1, for the first entry month (i.e. new to sample)
gen    chgresoutstate=(tmovrflg==4)
* but the problem is: move code repeated for the rest of the wave month
* and we want to keep only the first record
* see: http://www.stata.com/support/faqs/data-management/first-and-last-occurrences/
sort sippid rhcalyr rhcalmn
by   sippid swave (rhcalyr rhcalmn), sort: gen tmp2=sum(chgresoutstate)==1 & sum(chgresoutstate[_n-1])==0
* now update the chngresidence with first (flag, first move recorded in each wave)
replace chgresoutstate=tmp2 if chgresoutstate==1
drop tmp2
* now for "alternative measures (refmon=4 only)", move the code from the actual month to refmon=4
by   sippid swave (rhcalyr rhcalmn), sort: egen tmp2=sum(chgresoutstate)
replace chgresoutstate=0 if chgresoutstate==1
replace chgresoutstate=tmp2 if srefmon ==4
drop tmp2
* label variable and values
label variable chgresoutstate "Flag: residence changed, moved to another state"
label define chgresidence 0 `"No move"', modify
label define chgresidence 1 `"Moved, this wave"', modify
label values chgresoutstate chgresidence
* count times of residential state change
sort sippid
by sippid: egen cntchgstate=sum(chgresoutstate)
* label variable
label variable cntchgstate "Times residential state changed throughout panel"

/******************************* education - highest degree
* assign highest education degree
sort sippid
by sippid: egen maxeeducate=max(eeducate)
recode maxeeducate (-1=.) (31/38=1) (39=2) (40/43=3) (44/47=4)
* label variable
label variable maxeeducate "Highest degree held, recoded, throughout panel"
label define eeducaterc 1 "Less than HS" 2 "HS" 3 "Some college" 4 "BA or higher", modify
label values maxeeducate eeducaterc
/*label save eeducate using label_eeducate, replace
do label_eeducate
label values maxeeducate eeducate*/
*******************************/ 

* keep only the variables needed
sort sippid monthinsurvey
keep if swave==2 & srefmon==4
keep sippid rhcalyr monthinsurvey cntchgstate
saveold sipp010408w_wave2refmon4, replace

* finally - merge the core file with the topical module 2 file
* also keep applicable samples only

******************************* 
/* STEP 2.	
Using the dates for birth of first child (FBBIRTH month and year), restrict the 
sample to women with a first birth between January 1998 and December 2009, who 
had worked at least 6 months prior to the birth (BFBCNTWK==1).*/
use sipp010408t2, clear
label variable sippid "panel-HH-person unique ID: spanel+ssuid+epppnum"
sort sippid
merge 1:1 sippid using sipp010408w_wave2refmon4
assert _merge==3
keep if _merge==3
drop _merge
	* note: below mvdecode works fine, except a few "income" variables (th*) may be affect by this
	* use ds (help ds) instead - this will create a list of variables except for (th*)
	* ds th*, not
	* mvdecode `r(varlist)', mv(-1)
*recode all -1 (not in universe) to a special missing value, .n
quietly mvdecode _all, mv(-1=.n)  
keep if tfbrthyr>=1998 & tfbrthyr<=2008 & ebfbctwk==1

* also limit the sample by the age of mother, at the time of the first birth
gen cb_tagefbirth=tage-(rhcalyr-tfbrthyr)
label variable cb_tagefbirth "Estimated age at the time of the first birth"
* limit sample to birth age of mother between 18 and 50
keep if cb_tagefbirth>=18 & cb_tagefbirth<=50

* delete variables with RL, TXR, and WD prefixes in labels.  
* describe, short // use this if not sure if vars are dropped
foreach var of varlist *{
	local vlabel: variable label `var'
	local seleprefix "RL: TXR: WD: "
	forvalues i=1/3{
		local w: word `i' of `seleprefix'
		local yesno=strpos("`vlabel'","`w'")
		if `yesno'>0{
			drop `var'
		}
	}
}
* describe, short

* In our sample criteria statement (step 2 in do file), please drop cases 
* in which respondent is a grandparent (egrndpr==1)
drop if egrndpr==1

* "Please recode all binary variables to 0 (No), 1 (Yes), or (.) missing." 
* we are going to collect varnames with the binary responses..
* remember.. all -1 are now .n (special missing character)

* Above was the request from Prof. Hill but here is a change:
* DON"T touch "ebfbstop" - Prof. Hill's new request (see Prof. Ybarra's
* email on 7-28-14
local binaryvar ""
foreach var of varlist *{
	quietly summarize `var'
	if r(min)==1 & r(max)==2 & "`var'"!="ebfbstop"{
		local binaryvar = "`binaryvar' `var'" 
	}
}
* may want to check the list of vars..
* di "`binaryvar'"
label define yesno 1 "Yes" 0 "No", modify
label save yesno using label_yesno, replace
foreach v of local binaryvar{
	replace `v'=0 if `v'==2
	label values `v' yesno
	tab `v', missing
}

* NEW on 8/1/14 - implementing Prof. Hill's comment (below)
** I recommend that those who answer no to ebfbwkprg be recoded in those variables 
** as -99 or something else that is clearly not a valid value but can be labeled 
** as “no work during pregnancy.”
replace ebfbwkpr=-99 if ebfbwkpr ==0
* label values
label define ebfbwkpr -99 `"No work during pregnancy"', modify
label define ebfbwkpr 1 `"Yes"', modify
label values ebfbwkpr ebfbwkpr

tab ebfbwkpr, missing
tab ebfbwkpr, missing nolabel
/* 
   FH: Response for paid |
       work during first |      Freq.     Percent        Cum.
-------------------------+-----------------------------------
No work during pregnancy |        969       12.16       12.16 // value -99
                     Yes |      7,003       87.84      100.00 // value   1
-------------------------+-----------------------------------
                   Total |      7,972      100.00
*/

* do the same for the subsequent question - following Prof. Hill's lead
* "See my suggestion above."
replace ebfbpgft=-99 if ebfbwkpr ==-99
* label values
label define ebfbpgft -99 `"No work during pregnancy"', modify
label define ebfbpgft 0 `"No"', modify
label define ebfbpgft 1 `"Yes"', modify
label values ebfbpgft ebfbpgft

tab ebfbpgft, missing
tab ebfbpgft, missing nolabel
/*  tab ebfbpgft, missing

    FH: Resp. worked 35+ |
   hours per week before |      Freq.     Percent        Cum.
-------------------------+-----------------------------------
No work during pregnancy |        969       12.16       12.16 // value -99
                      No |        882       11.06       23.22 // value   0
                     Yes |      6,121       76.78      100.00 // value   1
-------------------------+-----------------------------------
                   Total |      7,972      100.00
*/

* Request from Prof. Hill - continuing to adopt prior direction
replace tbfbwsy1=-99 if ebfbwkpr ==-99
* label values
label define tbfbwsyt -99 `"No work during pregnancy"', modify
label values tbfbwsy1 tbfbwsyt

tab tbfbwsy1, missing
tab tbfbwsy1, missing nolabel
/*  tab tbfbwsy1, missing
     FH: Year respondent |
     stopped work before |
                   birth |      Freq.     Percent        Cum.
-------------------------+-----------------------------------
No work during pregnancy |        969       12.16       12.16 // value -99
                    1990 |          2        0.03       12.18
                    1996 |          3        0.04       12.22
                    1997 |         67        0.84       13.06
                    1998 |      1,004       12.59       25.65
                    1999 |        955       11.98       37.63
                    2000 |      1,010       12.67       50.30
                    2001 |        811       10.17       60.47
                    2002 |        706        8.86       69.33
                    2003 |        679        8.52       77.85
                    2004 |        454        5.69       83.54
                    2005 |        340        4.26       87.81
                    2006 |        345        4.33       92.13
                    2007 |        329        4.13       96.26
                    2008 |        298        3.74      100.00
-------------------------+-----------------------------------
                   Total |      7,972      100.00
*/

* Request from Prof. Hill - continuing to adopt prior direction - "Importantly, 
* this variable should not be detached from the variable above “in what month 
* and year did you stop working before the first birth” variable (TBFBWSY1).  
* If you look at the questionnaires, question BFBWRKST, the interviewer either 
* codes a month & year, or they code F for stopped when found out pregnant, or 
* they code N for never stopped working before birth.  F becomes 1 and N becomes 
* 2 in the actual data.

* although the original instruction was to turn the binary variable to yes/no (1/0)
* I made an exception for this variable to follow Prof. Hill's instruction on 
* 8-28-14 (via Prof. Ybarra's email.) 

* "The only truly NIU should be those who did not work at all during pregnancy (n=969)."

* ebfbstop: whether or not respondent stopped working before child was born.
replace ebfbstop=-99 if ebfbwkpr ==-99
* label values
label define ebfbstop -99 `"No work during pregnancy"', modify
label values ebfbstop ebfbstop

tab ebfbstop, missing
tab ebfbstop, missing nolabel
/* tab ebfbstop, missing

FH: Whether resp. stopped working |
                       before 1st |      Freq.     Percent        Cum.
----------------------------------+-----------------------------------
         No work during pregnancy |        969       12.16       12.16 // value -99
 Stopped when she was found to be |         60        0.75       12.91 // value   1
Never stopped/ worked right up to |      2,849       35.74       48.65 // value   2
                               .n |      4,094       51.35      100.00 // value  .n
----------------------------------+-----------------------------------
                            Total |      7,972      100.00
*/

* Request from Prof. Hill - continuing to adopt prior direction
* "The only truly NIU should be those who did not work at all during pregnancy (n=969)."

* ebtsit01: before child was born, did you quit working?
replace ebtsit01=-99 if ebfbwkpr ==-99
* label values
label define ebtsit01 -99 `"No work during pregnancy"', modify
label define ebtsit01   0 `"No, not quit"', modify
label define ebtsit01   1 `"Yes, quit"', modify
label values ebtsit01 ebtsit01

tab ebtsit01, missing
tab ebtsit01, missing nolabel
/* tab ebtsit01, missing

    FH: Before child was |
    born, did respondent |      Freq.     Percent        Cum.
-------------------------+-----------------------------------
No work during pregnancy |        969       12.16       12.16 // value -99
            No, not quit |      3,010       37.76       49.91 // value   0
               Yes, quit |      1,144       14.35       64.26 // value   1
                      .n |      2,849       35.74      100.00 // value  .n
-------------------------+-----------------------------------
                   Total |      7,972      100.00
*/

* This WASN'T reqeusted but seems necessary to change just like the above variables

* eafbst01: FH: After child was born, did respondent quit
replace eafbst01=-99 if ebfbwkpr ==-99
* label values
label define eafbst01 -99 `"No work during pregnancy"', modify
label define eafbst01   0 `"No, not quit"', modify
label define eafbst01   1 `"Yes, quit"', modify
label values eafbst01 eafbst01

tab eafbst01, missing
tab eafbst01, missing nolabel
/* tab eafbst01, missing

     FH: After child was |
    born, did respondent |
                    quit |      Freq.     Percent        Cum.
-------------------------+-----------------------------------
No work during pregnancy |        969       12.16       12.16 // value -99
            No, not quit |      5,789       72.62       84.77 // value   0
               Yes, quit |      1,197       15.02       99.79 // value   1
                      .n |         17        0.21      100.00 // value  .n
-------------------------+-----------------------------------
                   Total |      7,972      100.00
*/

saveold sipp010408t2_sample, replace

******************************* 
/* STEP 3.	
Create a flag indicating whether the birth occurred between the start of the 
person’s SIPP panel and wave 2.  For 2001 panelists, that would be births from 
February 2001-September 2001; For the 2004 panel, February 2004-September 2004; 
For the 2008 panel, September 2008-April 2009..*/

use     sipp010408t2_sample, clear

***** PROBLEM: birth month (efbrthmo) information unavailable *****
gen     birthatbegin=(spanel==tfbrthyr)
replace birthatbegin=1 if spanel==2000 & tfbrthyr==2001
replace birthatbegin=1 if spanel==2003 & tfbrthyr==2004
replace birthatbegin=1 if spanel==2008 & tfbrthyr==2009
label variable birthatbegin "flag: birth occurred between panel start & wave 2" 
label values birthatbegin yesno

/* 2-way tab: flag/birth-at-beginning-panel x cntchgstate

tab birthatbegin cntchgstate, row missing

     flag: |
     birth |
  occurred |
   between |
     panel |
   start & |    Times residential state changed throughout panel
    wave 2 |         0          1          2          3          4 |     Total
-----------+-------------------------------------------------------+----------
        No |     6,867        377         56          5          1 |     7,306 
           |     93.99       5.16       0.77       0.07       0.01 |    100.00 
-----------+-------------------------------------------------------+----------
       Yes |       611         40         14          0          1 |       666 
           |     91.74       6.01       2.10       0.00       0.15 |    100.00 
-----------+-------------------------------------------------------+----------
     Total |     7,478        417         70          5          2 |     7,972 
           |     93.80       5.23       0.88       0.06       0.03 |    100.00 
*/

******************************* 
/* STEP 4.	
Produce tabulation of number of women with first births in each year 1998-2009, 
and the number of women with first births during the first 2 waves of their SIPP
panel.. */

tab tfbrthyr birthatbegin, missing
/*
                | flag: birth occurred
                | between panel start &
 FH: Year first |        wave 2
 child was born |        No        Yes |     Total
----------------+----------------------+----------
           1998 |     1,145          0 |     1,145 
           1999 |     1,124          0 |     1,124 
           2000 |     1,144          0 |     1,144 
           2001 |       796        137 |       933 
           2002 |       809          0 |       809 
           2003 |       775          0 |       775 
           2004 |       360        171 |       531 
           2005 |       380          0 |       380 
           2006 |       396          0 |       396 
           2007 |       377          0 |       377 
           2008 |         0        358 |       358 
----------------+----------------------+----------
          Total |     7,306        666 |     7,972 

*/
******************************* 
* STEP 5.
* Prep variables (Keep all variables in the fertility module.)
******************************* 

* a. Dependent variables

* dependent variable 1
* i.	Quit job during pregnancy (0/1; based on BFBSTSIT==1)
gen     predpd1=(ebtsit01==1)
replace predpd1=ebtsit01 if missing(ebtsit01)
replace predpd1=.n if ebtsit01==-99
label variable predpd1 "Prep dependent var 1: quit job during preg?"
* label values
label define predpd1   0 `"No, not quit"', modify
label define predpd1   1 `"Yes, quit"', modify
label define predpd1  .n `"Not in universe including no work during preg"', modify
label values predpd1 predpd1

/* tab predpd1, missing

  Prep dependent var 1: quit job during |
                                  preg? |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                           No, not quit |      3,010       37.76       37.76 // value  0
                              Yes, quit |      1,144       14.35       52.11 // value  1
Not in universe including no work durin |      3,818       47.89      100.00 // value .n
----------------------------------------+-----------------------------------
                                  Total |      7,972      100.00
*/

******************** NOTE 
* Various reasons for quitting job during pregnancy are available from vars:
* ebtsit02 - ebtsit15
******************** 

* dependent variable 3
* iii.	Quit job post-birth (0/1; AFBJBSIT==1)
gen predpd3=(eafbst01==1)
replace predpd3=eafbst01 if missing(eafbst01)
replace predpd3=.n if eafbst01==-99
label variable predpd3 "Prep dependent var 3: quit job after birth?"
* label values
label define predpd3   0 `"No, not quit"', modify
label define predpd3   1 `"Yes, quit"', modify
label define predpd3  .n `"Not in universe including no work during preg"', modify
label values predpd3 predpd3
/* tab predpd3, missing

   Prep dependent var 3: quit job after |
                                 birth? |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                           No, not quit |      5,789       72.62       72.62 // value  0
                              Yes, quit |      1,197       15.02       87.63 // value  1
Not in universe including no work durin |        986       12.37      100.00 // value .n
----------------------------------------+-----------------------------------
                                  Total |      7,972      100.00
*/

******************************* 
* b. Control variables

* AGE
* tage 		// PE: Age as of last birthday (age at the time of interview)
* cb_tagefbirth 		// Estimated age at first birth

* RACE
* erace 		// PE: The race(s) the respondent is
* race  - another option (below) Hispanic included, mutually exclusive
gen race=3 if !(eorigin>=20 & eorigin<=28) & spanel==2001
replace race=1 if erace==1 & !(eorigin>=20 & eorigin<=28) & spanel==2001
replace race=2 if erace==2 & !(eorigin>=20 & eorigin<=28) & spanel==2001
replace race=4 if (eorigin>=20 & eorigin<=28) & spanel==2001

replace race=1 if erace==1 & eorigin==2 & (spanel==2004 | spanel==2008)
replace race=2 if erace==2 & eorigin==2 & (spanel==2004 | spanel==2008)
replace race=3 if (erace==3 | erace==4) & eorigin==2 & (spanel==2004 | spanel==2008)
replace race=4 if eorigin==1 & (spanel==2004 | spanel==2008)
* replace race=. if erace==. | eorigin==.
label variable race  "Race/ethnicity: nhwhite, nhblack, nhother, hispanic"
label define race 1 `"NH White"', modify
label define race 2 `"NH Black"', modify
label define race 3 `"NH Other"', modify
label define race 4 `"Hispanic"', modify
label values race race
/* tab race spanel, col missing

Race/ethni |
     city: |
  nhwhite, |
  nhblack, |   SU: Sample Code - Indicates
  nhother, |            Panel Year
  hispanic |      2001       2004       2008 |     Total
-----------+---------------------------------+----------
  NH White |       747      1,962      2,956 |     5,665 
           |     71.97      71.71      70.41 |     71.06 
-----------+---------------------------------+----------
  NH Black |        93        294        434 |       821 
           |      8.96      10.75      10.34 |     10.30 
-----------+---------------------------------+----------
  NH Other |        77        236        347 |       660 
           |      7.42       8.63       8.27 |      8.28 
-----------+---------------------------------+----------
  Hispanic |       121        244        461 |       826 
           |     11.66       8.92      10.98 |     10.36 
-----------+---------------------------------+----------
     Total |     1,038      2,736      4,198 |     7,972 
           |    100.00     100.00     100.00 |    100.00 
*/

* NATIONAL ORIGIN
* tcitiznt    // MG: U.S. citizenship - 2001 only
* ecitiznt    // MG: U.S. citizenship - 2004/2008
* enatcitt    // MG How the respondent became a US citizen - 2004/2008
gen     citizenship=tcitiznt if spanel==2001
replace citizenship=ecitiznt if spanel==2004 | spanel==2008
replace citizenship=2 if ecitiznt==1 & (enatcitt>=1 & enatcitt<=3) & (spanel==2004 | spanel==2008)
replace citizenship=3 if ecitiznt==2 & (spanel==2004 | spanel==2008)
label variable citizenship  "U.S. citizenship (recoded: tcitiznt/ecitiznt/enatcitt)"
* "Naturalization is the conferring, by any means, of citizenship upon a person after birth."
* http://factfinder2.census.gov/help/en/glossary/c/citizenship_status.htm
label define citizenship 1 `"Yes, native"', modify
label define citizenship 2 `"Yes, naturalized"', modify
label define citizenship 3 `"No"', modify
label values citizenship  citizenship 
/* tab citizenship spanel, col missing

U.S. citizenship |
       (recoded: |   SU: Sample Code - Indicates
tcitiznt/ecitizn |            Panel Year
     t/enatcitt) |      2001       2004       2008 |     Total
-----------------+---------------------------------+----------
     Yes, native |       907      2,411      3,612 |     6,930 
                 |     87.38      88.12      86.04 |     86.93 
-----------------+---------------------------------+----------
Yes, naturalized |        40        116        249 |       405 
                 |      3.85       4.24       5.93 |      5.08 
-----------------+---------------------------------+----------
              No |        91        209        337 |       637 
                 |      8.77       7.64       8.03 |      7.99 
-----------------+---------------------------------+----------
           Total |     1,038      2,736      4,198 |     7,972 
                 |    100.00     100.00     100.00 |    100.00 
*/

* NATIONAL ORIGIN - not perfect categories but mutually exclusive!
gen    birthcntry=tbrstate
recode birthcntry (-1=.n) (1/62=1) (64/78=4) (102/184=2) (192/195=2)  (185=3) (200/253=3) (301/304=4) (300=5) (310/389=5)  (415/468=6) (501/527=3) (555=99) if spanel==2001
recode birthcntry (-1=.n) (1/56=1) (72/78=4) (102/184=2) (192/195=2)  (185=3) (200/253=3) (301=4)     (300=5) (310/389=5)  (415/468=6) (501/527=3) (555=99) if spanel==2004
recode birthcntry (-1=.n) (1/56=1) (562=4) (563/564=2) (565/567=3)  (568=6) (569/571=5) (555=99) if spanel==2008
label variable birthcntry  "Country/region of birth (standardized 2001/2004/2008)"
label define birthcntry 1 `"United States"', modify
label define birthcntry 2 `"Europe"', modify
label define birthcntry 3 `"Asia, Oceania, Pacific Islands"', modify
label define birthcntry 4 `"North America  (including US territories)"', modify
label define birthcntry 5 `"Latin America"', modify
label define birthcntry 6 `"Africa"', modify
label define birthcntry 99 `"Elsewhere"', modify
label values birthcntry birthcntry
/* tab birthcntry spanel, col missing

    Country/region of |   SU: Sample Code - Indicates
  birth (standardized |            Panel Year
      2001/2004/2008) |      2001       2004       2008 |     Total
----------------------+---------------------------------+----------
        United States |       897      2,375      3,551 |     6,823 
                      |     86.42      86.81      84.59 |     85.59 
----------------------+---------------------------------+----------
               Europe |        16         40         87 |       143 
                      |      1.54       1.46       2.07 |      1.79 
----------------------+---------------------------------+----------
Asia, Oceania, Pacifi |        53        128        206 |       387 
                      |      5.11       4.68       4.91 |      4.85 
----------------------+---------------------------------+----------
North America  (inclu |         6         24         39 |        69 
                      |      0.58       0.88       0.93 |      0.87 
----------------------+---------------------------------+----------
        Latin America |        54        151        278 |       483 
                      |      5.20       5.52       6.62 |      6.06 
----------------------+---------------------------------+----------
               Africa |        11         14         29 |        54 
                      |      1.06       0.51       0.69 |      0.68 
----------------------+---------------------------------+----------
            Elsewhere |         1          4          8 |        13 
                      |      0.10       0.15       0.19 |      0.16 
----------------------+---------------------------------+----------
                Total |     1,038      2,736      4,198 |     7,972 
                      |    100.00     100.00     100.00 |    100.00 
*/

******************************* education - highest degree
* highest education degree in the year of first birth
gen cb_educfbirth=.
* replace educfbirth=thsyr if thsyr<=tfbrthyr
* thsyr    // year received high school diploma
* tassocyr // year received Associate degree
* tbachyr  // year received Bachelor's degree
* tvocyr   // year received vocational school diploma - part of sub-Baccalaureate
* post-secondary educational degree, after highschool. 
* See: http://www.census.gov/hhes/socdemo/education/data/sipp/Crissey_Bauman_PAAPoster.pdf
* tfbrthyr // year first child was born
replace cb_educfbirth=1 if thsyr>tfbrthyr | thsyr==. | thsyr==.n | thsyr==-1 /* technically, .n only, but..*/
replace cb_educfbirth=2 if thsyr<=tfbrthyr & !(thsyr==. | thsyr==.n | thsyr==-1)
* problem: 8 out of 1103 who has vocational degree do NOT appear to have HS degree..
* replace cb_educfbirth=3 if tassocyr<=tfbrthyr & !(thsyr==. | thsyr==.n | thsyr==-1) //without vocational degree in some college
replace cb_educfbirth=3 if (tvocyr<=tfbrthyr | tassocyr<=tfbrthyr) & !(thsyr==. | thsyr==.n | thsyr==-1)
replace cb_educfbirth=4 if tbachyr<=tfbrthyr
label variable cb_educfbirth "Highest degree held, at the time of the first birth"
label define cb_educfbirth 1 "Less than HS" 2 "HS" 3 "Some college" 4 "BA or higher", modify
label values cb_educfbirth cb_educfbirth
note cb_educfbirth: Mom with vocational degree even without HS diploma was coded 3
/* tab cb_educfbirth spanel, col missing

     Highest |
degree held, |
 at the time |   SU: Sample Code - Indicates
of the first |            Panel Year
       birth |      2001       2004       2008 |     Total
-------------+---------------------------------+----------
Less than HS |        97        247        331 |       675 
             |      9.34       9.03       7.88 |      8.47 
-------------+---------------------------------+----------
          HS |       456      1,212      1,696 |     3,364 
             |     43.93      44.30      40.40 |     42.20 
-------------+---------------------------------+----------
Some college |       114        348        633 |     1,095 
             |     10.98      12.72      15.08 |     13.74 
-------------+---------------------------------+----------
BA or higher |       371        929      1,538 |     2,838 
             |     35.74      33.95      36.64 |     35.60 
-------------+---------------------------------+----------
       Total |     1,038      2,736      4,198 |     7,972 
             |    100.00     100.00     100.00 |    100.00 
*/
tab birthatbegin cb_educfbirth, row missing
/*
     flag: |
     birth |
  occurred |
   between |
     panel |   Highest degree held, at the time of the
   start & |                 first birth
    wave 2 | Less than         HS  Some coll  BA or hig |     Total
-----------+--------------------------------------------+----------
        No |       634      3,103      1,001      2,568 |     7,306 
           |      8.68      42.47      13.70      35.15 |    100.00 
-----------+--------------------------------------------+----------
       Yes |        41        261         94        270 |       666 
           |      6.16      39.19      14.11      40.54 |    100.00 
-----------+--------------------------------------------+----------
     Total |       675      3,364      1,095      2,838 |     7,972 
           |      8.47      42.20      13.74      35.60 |    100.00 
*/

*******************************************************************************
* New var requested (30apr14)
* There are a few variables in the data that I think we can use to get a 
* handle on characteristics at the time of the birth.  

* Using rnmstop, please create a categorical variable, cb_wkstop, for “Months 
* prior to birth that mother stopped working (collapsed).”  The variable should 
* be coded 1 (0-1 months), 2 (2-5 months), or 3 (6-9 months).
/* tab  rnmstop, missing
  FH: Number of |
mnth before 1st |
     birth when |      Freq.     Percent        Cum.
----------------+-----------------------------------
              0 |      4,551       57.09       57.09
              1 |      1,089       13.66       70.75
              2 |        436        5.47       76.22
              3 |        232        2.91       79.13
              4 |        166        2.08       81.21
              5 |        119        1.49       82.70
              6 |        105        1.32       84.02
              7 |         57        0.72       84.73
              8 |        107        1.34       86.08
              9 |         32        0.40       86.48
             .n |      1,078       13.52      100.00
----------------+-----------------------------------
          Total |      7,972      100.00
*/
gen    cb_wkstop=rnmstop
label variable cb_wkstop "Months prior to birth that mother stopped working (collapsed)."
recode cb_wkstop (0/1=1) (2/5=2) (6/9=3)
*  ebfbwkpr : FH: Response for paid work during first pregnancy
/* tab ebfbwkpr, missing
        FH: |
   Response |
   for paid |
work during |
      first |      Freq.     Percent        Cum.
------------+-----------------------------------
         No |        969       12.16       12.16
        Yes |      7,003       87.84      100.00
------------+-----------------------------------
      Total |      7,972      100.00
*/
replace cb_wkstop=4 if ebfbwkpr==0
label define cb_wkstop 1 "0-1 months" 2 "2-5 months" 3 "6-9 months" 4 "didn't work", modify
label values cb_wkstop cb_wkstop
/* tab cb_wkstop, missing

     Months |
   prior to |
 birth that |
     mother |
    stopped |
    working |
(collapsed) |
          . |      Freq.     Percent        Cum.
------------+-----------------------------------
 0-1 months |      5,640       70.75       70.75
 2-5 months |        953       11.95       82.70
 6-9 months |        301        3.78       86.48
didn't work |        969       12.16       98.63
         .n |        109        1.37      100.00
------------+-----------------------------------
      Total |      7,972      100.00
*/ 

* Using rnmretwk, please create a categorical variable, cb_wkstrt, for 
* “Months after birth when mother started working (collapsed).”  The variable 
* should be coded 1 (0-3 months), 2 (4-12), 3 (13+), or 4 (never).  
* The “nevers” should be eafbwrk==2.
/* tab rnmretwk, missing

  FH: Number of |
   months after |
      1st birth |
       returned |      Freq.     Percent        Cum.
----------------+-----------------------------------
              0 |        416        5.22        5.22
              1 |        871       10.93       16.14
              2 |      1,730       21.70       37.84
 - omit -
            129 |          1        0.01       83.67
            131 |          1        0.01       83.68
             .n |      1,301       16.32      100.00
----------------+-----------------------------------
          Total |      7,972      100.00
*/
gen cb_wkstrt=rnmretwk
label variable cb_wkstrt "Months after birth when mother started working (collapsed)."
quietly summarize cb_wkstrt
local maxnum=r(max)
recode cb_wkstrt (0/3=1) (4/12=2) (13/`maxnum'=3)
* eafbwrk : FH: Respondent worked for pay after birth of
replace cb_wkstrt=4 if eafbwrk==0
label define cb_wkstrt 1 "0-3 months" 2 "4-12 months" 3 "13+ months" 4 "didn't work", modify
label values cb_wkstrt cb_wkstrt
/* tab cb_wkstrt, missing

     Months |
after birth |
when mother |
    started |
    working |
(collapsed) |
          . |      Freq.     Percent        Cum.
------------+-----------------------------------
 0-3 months |      4,303       53.98       53.98
4-12 months |      1,604       20.12       74.10
 13+ months |        764        9.58       83.68
didn't work |      1,193       14.96       98.65
         .n |        108        1.35      100.00
------------+-----------------------------------
      Total |      7,972      100.00
*/

* Using tmovest and year of 1st birth, please create a binary variable, 
* cb_stdiff, for “Mother lived in different state at interview & first birth),
* ” equal to 1 if the mother moved to current state AFTER year of first birth, 
* and 0 if not.
/* tab tmovest, missing

  MG: Year moved into this |
                     state |      Freq.     Percent        Cum.
---------------------------+-----------------------------------
        Always lived there |        203        2.55        2.55 // -5
Always lived in this state |      3,683       46.20       48.75 // -3
                      1958 |          1        0.01       48.76
                      1962 |          1        0.01       48.77
 - omit -
                      2009 |          7        0.09       84.76
                      9999 |        284        3.56       88.32 // respondent didn't supply valid year
                        .n |        931       11.68      100.00
---------------------------+-----------------------------------
                     Total |      7,972      100.00
*/
gen     cb_stdiff=0
label variable cb_stdiff "Mother lived in different state at interview & first birth."
* some are not in universe (.n)..
replace cb_stdiff=tmovest if tmovest==.n
* .a = 9999 means "respondent didn't supply valid year"
replace cb_stdiff=.a if tmovest==9999
* no missing values in tfbrthyr (good!)
replace cb_stdiff=1 if tmovest>tfbrthyr & !(cb_stdiff==.n | cb_stdiff==.a)
label define cb_stdiff 1 "1: moved to current state AFTER year of first birth" 0 "0: else (exclude unknown/missing)" .a ".a: no valid year supplied", modify
label values cb_stdiff cb_stdiff
/* tab cb_stdiff, missing

     Mother lived in different state at |
               interview & first birth. |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
      0: else (exclude unknown/missing) |      6,284       78.83       78.83
1: moved to current state AFTER year of |        473        5.93       84.76
             .a: no valid year supplied |        284        3.56       88.32
                                     .n |        931       11.68      100.00
----------------------------------------+-----------------------------------
                                  Total |      7,972      100.00
*/

* Using tmoveus and year of 1st birth, please create a binary variable, cb_nonus, 
* for “Mother lived outside the US at time of first birth” equal to 1 if the 
* mother was living outside the U.S. at the time of the first birth, and 0 if not.

************* turned out this is very complicated because 
************* (1) tmoveus are categorical, and
************* (2) categories vary in each panel (2001, 2004, 2008)
************* i.e. value 1 could mean "1961-1968" (2001) or "before 1952" (2004) or "1954 or earlier" (2008)
************* I used upper/maximum possible year of "move to US" to evaluate if
************* "mother was living outside the U.S. at the time of the first birth"

/* tab tmoveus, missing

 MG: Year moved |
  to the United |
         States |      Freq.     Percent        Cum.
----------------+-----------------------------------
      1961-1968 |          8        0.10        0.10
      1969-1973 |          8        0.10        0.20
      1974-1978 |         15        0.19        0.39
 - omit -
      2008-2009 |         43        0.54       12.66
           9999 |        122        1.53       14.19 // Respondent didn't supply valid year
             .n |      6,841       85.81      100.00
----------------+-----------------------------------
          Total |      7,972      100.00
 
* now I have to recode

label list tmoveus
tmoveus for 2001:
          -1 Not in universe
           1 Before 1952
           2 1952-1958
           3 1959-1964
           4 1965-1968
           5 1969-1971
           6 1972-1974
           7 1975-1977
           8 1978-1979
           9 1980-1981
          10 1982-1984
          11 1985-1986
          12 1987-1988
          13 1989-1990
          14 1991-1992
          15 1993-1994
          16 1995
          17 1996-1997
          18 1998
          19 1999
          20 2000
          21 2001
        9999 Respondent didn't supply valid
*/
gen     rctmoveus=tmoveus
* I am using upper-limit, more conservative approach, I think
replace rctmoveus=1952 if rctmoveus==	1 & spanel==2001
replace rctmoveus=1958 if rctmoveus==	2 & spanel==2001
replace rctmoveus=1964 if rctmoveus==	3 & spanel==2001
replace rctmoveus=1968 if rctmoveus==	4 & spanel==2001
replace rctmoveus=1971 if rctmoveus==	5 & spanel==2001
replace rctmoveus=1974 if rctmoveus==	6 & spanel==2001
replace rctmoveus=1977 if rctmoveus==	7 & spanel==2001
replace rctmoveus=1979 if rctmoveus==	8 & spanel==2001
replace rctmoveus=1981 if rctmoveus==	9 & spanel==2001
replace rctmoveus=1984 if rctmoveus==	10 & spanel==2001
replace rctmoveus=1986 if rctmoveus==	11 & spanel==2001
replace rctmoveus=1988 if rctmoveus==	12 & spanel==2001
replace rctmoveus=1990 if rctmoveus==	13 & spanel==2001
replace rctmoveus=1992 if rctmoveus==	14 & spanel==2001
replace rctmoveus=1994 if rctmoveus==	15 & spanel==2001
replace rctmoveus=1995 if rctmoveus==	16 & spanel==2001
replace rctmoveus=1997 if rctmoveus==	17 & spanel==2001
replace rctmoveus=1998 if rctmoveus==	18 & spanel==2001
replace rctmoveus=1999 if rctmoveus==	19 & spanel==2001
replace rctmoveus=2000 if rctmoveus==	20 & spanel==2001
replace rctmoveus=2001 if rctmoveus==	21 & spanel==2001
replace rctmoveus=.a if rctmoveus== 9999 & spanel==2001

/* label list tmoveus
tmoveus for 2004:
          -1 Not in universe
           1 1954 and earlier
           2 1955-1961
           3 1962-1966
           4 1967-1970
           5 1971-1974
           6 1975-1978
           7 1979-1980
           8 1981-1982
           9 1983-1984
          10 1985-1986
          11 1987-1988
          12 1989-1990
          13 1991-1992
          14 1993-1994
          15 1995-1996
          16 1997-1998
          17 1999
          18 2000
          19 2001
          20 2002-2004
        9999 Respondent didn't supply valid
*/
* I am using upper-limit, more conservative approach, I think
replace rctmoveus=1954 if rctmoveus==	1 & spanel==2004
replace rctmoveus=1961 if rctmoveus==	2 & spanel==2004
replace rctmoveus=1966 if rctmoveus==	3 & spanel==2004
replace rctmoveus=1970 if rctmoveus==	4 & spanel==2004
replace rctmoveus=1974 if rctmoveus==	5 & spanel==2004
replace rctmoveus=1978 if rctmoveus==	6 & spanel==2004
replace rctmoveus=1980 if rctmoveus==	7 & spanel==2004
replace rctmoveus=1982 if rctmoveus==	8 & spanel==2004
replace rctmoveus=1984 if rctmoveus==	9 & spanel==2004
replace rctmoveus=1986 if rctmoveus==	10 & spanel==2004
replace rctmoveus=1988 if rctmoveus==	11 & spanel==2004
replace rctmoveus=1990 if rctmoveus==	12 & spanel==2004
replace rctmoveus=1992 if rctmoveus==	13 & spanel==2004
replace rctmoveus=1994 if rctmoveus==	14 & spanel==2004
replace rctmoveus=1996 if rctmoveus==	15 & spanel==2004
replace rctmoveus=1998 if rctmoveus==	16 & spanel==2004
replace rctmoveus=1999 if rctmoveus==	17 & spanel==2004
replace rctmoveus=2000 if rctmoveus==	18 & spanel==2004
replace rctmoveus=2001 if rctmoveus==	19 & spanel==2004
replace rctmoveus=2004 if rctmoveus==	20 & spanel==2004
replace rctmoveus=.a if rctmoveus==	9999 & spanel==2004
/*
label list tmoveus
tmoveus for 2008:
          -1 Not in Universe
           1 1961
           2 1961-1968
           3 1969-1973
           4 1974-1978
           5 1979-1980
           6 1981-1983
           7 1984-1985
           8 1986-1988
           9 1989-1990
          10 1991-1992
          11 1993-1994
          12 1995-1996
          13 1997-1998
          14 1999
          15 2000
          16 2001
          17 2002-2003
          18 2004
          19 2005
          20 2006
          21 2007
          22 2008-2009
*/
* I am using upper-limit, more conservative approach, I think
replace rctmoveus= 1961 if rctmoveus==	1 & spanel==2008
replace rctmoveus= 1968 if rctmoveus==	2 & spanel==2008
replace rctmoveus= 1973 if rctmoveus==	3 & spanel==2008
replace rctmoveus= 1978 if rctmoveus==	4 & spanel==2008
replace rctmoveus= 1980 if rctmoveus==	5 & spanel==2008
replace rctmoveus= 1983 if rctmoveus==	6 & spanel==2008
replace rctmoveus= 1985 if rctmoveus==	7 & spanel==2008
replace rctmoveus= 1988 if rctmoveus==	8 & spanel==2008
replace rctmoveus= 1990 if rctmoveus==	9 & spanel==2008
replace rctmoveus= 1992 if rctmoveus==	10 & spanel==2008
replace rctmoveus= 1994 if rctmoveus==	11 & spanel==2008
replace rctmoveus= 1996 if rctmoveus==	12 & spanel==2008
replace rctmoveus= 1998 if rctmoveus==	13 & spanel==2008
replace rctmoveus= 1999 if rctmoveus==	14 & spanel==2008
replace rctmoveus= 2000 if rctmoveus==	15 & spanel==2008
replace rctmoveus= 2001 if rctmoveus==	16 & spanel==2008
replace rctmoveus= 2003 if rctmoveus==	17 & spanel==2008
replace rctmoveus= 2004 if rctmoveus==	18 & spanel==2008
replace rctmoveus= 2005 if rctmoveus==	19 & spanel==2008
replace rctmoveus= 2006 if rctmoveus==	20 & spanel==2008
replace rctmoveus= 2007 if rctmoveus==	21 & spanel==2008
replace rctmoveus= 2009 if rctmoveus==	22 & spanel==2008

* tab rctmoveus spanel, missing
* after making sure the recode worked well, move forward:
gen     cb_nonus=0
* some are not in universe (.n)..
replace cb_nonus=rctmoveus if rctmoveus==.n | rctmoveus==.a
label variable cb_nonus "Mother lived outside the US at the time of the first birth"
* no missing values in tfbrthyr (good!)
replace cb_nonus=1 if rctmoveus>tfbrthyr & rctmoveus!=.n & rctmoveus!=.a
label define cb_nonus 1 "1: mother was living outside the U.S. at the time of the first birth" 0 "0: else (exclude unknown/missing)" .a ".a: no valid year supplied", modify
label values cb_nonus cb_nonus
note cb_nonus: approximate estimation: original was categorical, upper limit applied
/* tab cb_nonus, missing

Mother lived outside the US at the time |
                     of the first birth |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
      0: else (exclude unknown/missing) |        828       10.39       10.39
1: mother was living outside the U.S. a |        181        2.27       12.66
             .a: no valid year supplied |        122        1.53       14.19
                                     .n |      6,841       85.81      100.00
----------------------------------------+-----------------------------------
                                  Total |      7,972      100.00
*/
* as noted in my email to Profs. there are weird tmoveus reporting cases
* to see them, do the followings:
* brow sippid spanel swave tfipsst rhcalyr tfbrthyr tmovest cb_stdiff tmoveus cb_nonus citizenship  if rctmoveus>tmovest & !(rctmoveus==.9999 | rctmoveus==.n)
* export excel using "F:\Prof_Ybarra\SIPP\sipp010408t2_move2stateBEFOREmove2us.xls", firstrow(variables) replace

* Based on cb_tagefbirth, please create another categorical variable for age at 
* first birth with collapsed categories: 1 (<20), 2(21-30), 3(31-40), 4(41+)
/* tab cb_tagefbirth, missing

  Estimated |
     age at |
first birth |      Freq.     Percent        Cum.
------------+-----------------------------------
         18 |        327        4.10        4.10
         19 |        477        5.98       10.09
         20 |        509        6.38       16.47
 - omit -
         48 |          5        0.06       99.87
         49 |          9        0.11       99.99
         50 |          1        0.01      100.00
------------+-----------------------------------
      Total |      7,972      100.00
*/
gen    cb_rcagefbirth=cb_tagefbirth
label variable cb_rcagefbirth "(recoded: tagefbirth) Estimated age at the time of the first birth"
recode cb_rcagefbirth (18/20=1) (21/30=2) (31/40=3) (41/50=4)
label define cb_rcagefbirth 1 "18-20 yrs old" 2 "21-30 yrs old" 3 "31-40 yrs old" 4 "41-50 yrs old", modify
label values cb_rcagefbirth cb_rcagefbirth
/* tab cb_rcagefbirth, missing

    (recoded: |
  tagefbirth) |
Estimated age |
  at the time |
 of the first |
        birth |      Freq.     Percent        Cum.
--------------+-----------------------------------
18-20 yrs old |      1,313       16.47       16.47
21-30 yrs old |      4,596       57.65       74.12
31-40 yrs old |      1,945       24.40       98.52
41-50 yrs old |        118        1.48      100.00
--------------+-----------------------------------
        Total |      7,972      100.00
*/

* Based on educfbirth, please create a binary variable for mom’s ed level at 
* first birth being HS or less (1) versus some college or more (0).  Please 
* call this “cb_lowed”
/* tab educfbirth, nolabel

    Highest |
     degree |
  received, |
 recoded in |
the year of |
first birth |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |        675        8.47        8.47
          2 |      3,802       47.69       56.16
          3 |        657        8.24       64.40
          4 |      2,838       35.60      100.00
------------+-----------------------------------
      Total |      7,972      100.00
*/
gen    cb_lowed=cb_educfbirth
label variable cb_lowed "mom’s ed level at the time of the first birth"
recode cb_lowed (1/2=1) (3/4=0)
label define cb_lowed 1 "1: HS or less" 0 "0: some college or more", modify
label values cb_lowed cb_lowed
/* tab  cb_lowed, missing


  mom’s ed level at the |
time of the first birth |      Freq.     Percent        Cum.
------------------------+-----------------------------------
0: some college or more |      3,933       49.34       49.34
          1: HS or less |      4,039       50.66      100.00
------------------------+-----------------------------------
                  Total |      7,972      100.00
*/
drop rctmoveus

******************************* marital status at the time of first birth
* requested at the in-person meeting on 5/28/14
* related variables:
* rhcalyr ems tfbrthyr tfmyear tfsyear tftyear tsmyear tssyear tstyear tlmyear tlsyear tltyear
gen cb_married=0
* married if giving the first birth either
*            after first-marriage & before first-termination or
*            after second-marriage & before second-termination or
*            after last-marriage & before last-termination
replace cb_married=1 if (tfbrthyr>=tfmyear & tfbrthyr<=tftyear & tfmyear!=. & tftyear!=.) /*
                   */ | (tfbrthyr>=tsmyear & tfbrthyr<=tstyear & tsmyear!=. & tstyear!=.) /*
                   */ | (tfbrthyr>=tlmyear & tfbrthyr<=tltyear & tlmyear!=. & tltyear!=.)
label variable cb_married "mom’s marital status at the time of first birth"
label define cb_married 1 "1: married at first birth" 0 "0: unknown/unmarried", modify
label values cb_married cb_married
compress
saveold sipp010408t2_sample2, replace

*******************************************************************************
* Descriptive Analysis
* Please send a log file with the following output:
* 1.	Tabulations or summary tables for all the new variables above.
* 2.	Cross-tabulations of predpd3 (job quit after birth) with each variable 
*       in the list eafbst02-15 (other ways that leave was taken).  Please show row percentages.
* 3.	Cross-tabulations of pedpd1 (job quit during preg) and each variable in 
*       the list ebtsit02-ebtsit15. Please show row percentages.
* 4.	Bar graph of types of maternity leave during pregnancy (ebtsit01-ebtsit15)
*       and after birth (eafbst01-eafbst15) by maternal education (cb_lowed). 
*       It’s fine to collapse some of the ebtsit and eafbst categories if there 
*       are “other” type categories.

use sipp010408t2_sample2, clear

set logtype text, permanently
* linesize will change if you resize windows manually
set linesize 80
log using DescriptiveAnalysis30apr14, text replace

* 1.	Tabulations or summary tables for all the new variables above.
foreach var of varlist cb_wkstop cb_wkstrt cb_stdiff cb_nonus cb_rcagefbirth cb_lowed{
	di " "
	di "Summary table of `var'"
	summarize `var', detail
}

* 2.	Cross-tabulations of predpd3 (job quit after birth) with each variable 
*       in the list eafbst02-15 (other ways that leave was taken).  Please show row percentages.
foreach var of varlist eafbst02-eafbst15{
	di " "
	di "Cross-tabulation of predpd3 (job quit after birth) and `var'"
	tab `var' predpd3, row
}

* 3.	Cross-tabulations of pedpd1 (job quit during preg) and each variable in 
*       the list ebtsit02-ebtsit15. Please show row percentages.
foreach var of varlist ebtsit02-ebtsit15{
	di " "
	di "Cross-tabulation of pedpd1 (job quit during preg) and `var'"
	tab `var' predpd1, row
}
log close

* 4.	Bar graph of types of maternity leave during pregnancy (ebtsit01-ebtsit15)
*       and after birth (eafbst01-eafbst15) by maternal education (cb_lowed). 
*       It’s fine to collapse some of the ebtsit and eafbst categories if there 
*       are “other” type categories.

* new on 5/28/14
* If you have time today before we meet, could you please change the graphs to 
* percentage (rather than frequency) distributions? Also, could you just show 
* only the “yes” graph for each type of leave (no need to show yes and no if 
* percentage graphs), and put a whole bunch of the “yes” graphs on one page in 
* an .png file?  It’s hard to look at this many graphs.  Even better, we could 
* show the percentage with “yes” for each type of leave by education all on 1 graph.

* frequency weight needs to be an interger (not double precision)
gen intwpfinwgt=round(wpfinwgt)

/*foreach i of varlist ebtsit01-ebtsit15 eafbst01-eafbst15{
capture confirm  numeric variable `i'
  if _rc==0 {
    local vlabel: variable label `i'
	* tabulate without person weight
	tab `i' cb_lowed, row
	* tabulate with person weight
	tab `i' cb_lowed [fweight = intwpfinwgt], row 
	* bar graph using person weight
	graph bar (count) `i' [fweight = intwpfinwgt], over(cb_lowed) by(`i') /*
*/ name(`i') title("`vlabel'",size(small)) b1title("`i'",size(medsmall)) /*
*/ ytitle("Weighted count",size(small))
	* histogram `i', name(`i')
    local z "`z' `i'"
	graph save "`i'_cb_lowed_pweighted", replace
	graph export "`i'_cb_lowed_pweighted.png", replace
  }
}
* graphs could be combined using "name" but it's too small
* graph combine `z'  */

use sipp010408t2_sample2, clear
gen intwpfinwgt=round(wpfinwgt)
foreach i of varlist ebtsit01-ebtsit15{
	capture confirm  numeric variable `i'
	preserve
	keep if `i'==1
	gen question=substr("`i'",7,2)
	sort cb_lowed question
	collapse (count) ebtsit=`i' [weight=intwpfinwgt], by(cb_lowed question)
	tempfile `i'_collapsed
	save "`i'_collapsed", replace
	if "`i'"!="ebtsit01"{
		use ebtsit01_collapsed, clear
		append using "`i'_collapsed"
		save ebtsit01_collapsed, replace
	}
	capture restore
}

use ebtsit01_collapsed, clear
destring question, replace
sort question
* by question: egen pebtsit=pc(ebtsit)
egen pebtsit=pc(ebtsit)
label define ebtsitlabel /*
*/ 1  "Quit working " /*
*/ 2  "Was let go" /*
*/ 3  "On paid maternity leave" /*
*/ 4  "On unpaid maternity leave" /*
*/ 5  "On paid sick leave" /*
*/ 6  "On unpaid sick leave" /*
*/ 7  "On disability leave" /*
*/ 8  "On paid vacation leave" /*
*/ 9  "On unpaid vacation leave" /*
*/ 10 "On other paid leave" /*
*/ 11 "On other unpaid leave" /*
*/ 12 "Never stopped working" /*
*/ 13 "Self-employed" /*
*/ 14 "Employer out-of-business" /*
*/ 15 "Stop working for other reasons" 
label value question ebtsitlabel
label define cb_lowed2 1 "HS or less" 0 "Some college", modify
label values cb_lowed cb_lowed2

graph hbar (asis) pebtsit, over(cb_lowed) over(question,label(labsize(vsmall))) /*
*/ title("Reason to leave job during pregnancy") /*
*/ ytitle("Percentage Yes",size(medsmall)) /*
*/ scheme(color) asyvar
graph export "Graph_ReasonToLeaveJobDuringPregnancy.png", replace

use sipp010408t2_sample2, clear
gen intwpfinwgt=round(wpfinwgt)
foreach i of varlist eafbst01-eafbst15{
	capture confirm  numeric variable `i'
	preserve
	keep if `i'==1
	gen question=substr("`i'",7,2)
	sort cb_lowed question
	collapse (count) eafbst=`i' [weight=intwpfinwgt], by(cb_lowed question)
	tempfile `i'_collapsed
	save "`i'_collapsed", replace
	if "`i'"!="eafbst01"{
		use eafbst01_collapsed, clear
		append using "`i'_collapsed"
		save eafbst01_collapsed, replace
	}
	capture restore
}

use eafbst01_collapsed, clear
destring question, replace
sort question
* by question: egen peafbst=pc(eafbst)
egen peafbst=pc(eafbst)
label define eafbstlabel /*
*/ 1  "Quit working " /*
*/ 2  "Was let go" /*
*/ 3  "On paid maternity leave" /*
*/ 4  "On unpaid maternity leave" /*
*/ 5  "On paid sick leave" /*
*/ 6  "On unpaid sick leave" /*
*/ 7  "On disability leave" /*
*/ 8  "On paid vacation leave" /*
*/ 9  "On unpaid vacation leave" /*
*/ 10 "On other paid leave" /*
*/ 11 "On other unpaid leave" /*
*/ 12 "Never stopped working" /*
*/ 13 "Self-employed" /*
*/ 14 "Employer out-of-business" /*
*/ 15 "Stop working for other reasons" 
label value question eafbstlabel
label define cb_lowed2 1 "HS or less" 0 "Some college", modify
label values cb_lowed cb_lowed2

graph hbar (asis) peafbst, over(cb_lowed) over(question,label(labsize(vsmall))) /*
*/ title("Reason to leave job after first birth") /*
*/ ytitle("Percentage Yes",size(medsmall)) /*
*/ scheme(color) asyvar
graph export "Graph_ReasonToLeaveJobAfterFBirth.png", replace
clear all

set logtype text, permanently
* linesize will change if you resize windows manually
set linesize 80
use sipp010408t2_sample2, clear
* program program_makecodebook
#delimit ;
local descriptivevars
ebfbctwk
abfbctwk
ebfbwkpr
abfbwkpr
efbrthmo
afbrthmo
tfbrthyr
afbrthyr
tagfbrth
efblivnw
afblivnw
elbirtmo
albirtmo
tlbirtyr
albirtyr
ebtsit01
ebtsit02
ebtsit03
ebtsit04
ebtsit05
ebtsit06
ebtsit07
ebtsit08
ebtsit09
ebtsit10
ebtsit11
ebtsit12
ebtsit13
ebtsit14
ebtsit15
abfbsit
ebfbwsm1
abfbwsm1
tbfbwsy1
abfbwsy1
ebfbstop
abfbstop
tagestop
eafbst01
eafbst02
eafbst03
eafbst04
eafbst05
eafbst06
eafbst07
eafbst08
eafbst09
eafbst10
eafbst11
eafbst12
eafbst13
eafbst14
eafbst15
aafbjst
eafbwrk
aafbwrk
eafbwkm1
aafbwkm1
tafbwky1
aafbwky1
tagertwk
ebfbpgft
abfbpgft
eafbwkft
aafbwkft
eafbwkhr
aafbwkhr
eaedunv
eafbwkem
aafbwkem
eafbwkps
aafbwkps
eafbwkpy
aafbwkpy
eafbwkse
aafbwkse
tafblvyr
rnmstop
rnmretwk
rnmlevem
rpremar
cb_tagefbirth
birthatbegin
predpd1
predpd3
race
citizenship
birthcntry
cb_educfbirth
cb_wkstop
cb_wkstrt
cb_rcagefbirth
cb_lowed
cb_married
;
#delimit cr
keep `descriptivevars'
log using codebook_descriptive_request061214, text replace
* summarize _all
* codebook, all
foreach var of local descriptivevars{
	codebook `var'
	quietly inspect `var'
	if r(N_unique)<15 {
		di " "
		di "******** All categorical responses of `var' ********"
		tab `var', missing
	}
	else if r(N_unique)>=15 {
		di " "
		di "******** Summary (N, mean, median, max & min) of `var' ********"
		summarize `var', detail
		inspect `var'
	}
	local crossvars cb_rcagefbirth race cb_educfbirth cb_married
	foreach cv of local crossvars{
		di " "
		di "******** Cross-tabulation of `var' and `cv' ********"
		tab `var' `cv', row missing
	}
}
log close
* changeeol codebook_`1'_unix.log codebook_`1'_windows.log, eol(windows) replace

set logtype text, permanently
* linesize will change if you resize windows manually
set linesize 80
log using codebook4documents, text replace
use sipp010408t2_sample2, clear
di ""
di "VALUE MODIFIED VARIABLES"
di ""
foreach var of varlist ebfbwkpr ebfbpgft tbfbwsy1 ebfbstop ebtsit01 eafbst01{
	codebook `var'
}
di ""
di "ADDED/DERIVED VARIABLES"
di ""
foreach var of varlist rhcalyr- cb_married{
	codebook `var'
}
log close

/**********STEP ********************/

use Callie/jobquits, clear
rename FIPS tfipsst
rename Year tfbrthyr
sort tfipsst tfbrthyr
save Callie/jobquits_mergeready, replace

use     sipp010408t2_sample2, clear
sort tfipsst tfbrthyr
merge m:1 tfipsst tfbrthyr using Callie/jobquits_mergeready
/* 
    Result                           # of obs.
    -----------------------------------------
    not matched                           246
        from master                        15  (_merge==1)
        from using                        231  (_merge==2)

    matched                             7,957  (_merge==3)
    -----------------------------------------
*/
drop if _merge==2
drop _merge
saveold sipp010408t2_sample2_jobquits, replace
/*
Contains data from sipp010408t2_sample2_jobquits.dta
  obs:         7,256                          
 vars:           368                          22 Jul 2014 11:15
 size:     3,736,840  
*/

exit
