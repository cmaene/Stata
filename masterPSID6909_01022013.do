*******************************************************************************
* Stata version 12.0
* Panel Study of Income Dynamics (PSID)
* longitudinal/1969-2009 data prep & analysis, 2012-2013
*******************************************************************************

***** coding standards *****
* (1) all file & variable names will be lower case
* (2) the last 2-digit represent 2-digit year of the INTERVIEW YEAR!
***** Things needed to be done *before* running this script *****
* (1) download the following packaged files from http://simba.isr.umich.edu/Zips/zipMain.aspx
*      - 1997 family file
*      - 1999 family file
*      - 2001 family file
*      - 2003 family file
*      - 2005 family file
*      - 2007 family file
*      - 2008 family file
*      - Cross- year individual file
* (2) unzip files from the above step, and keep them in the same directory - also save this script in the same directory
* (3) make sure to edit [path]/ in the PSID-supplied do scripts (i.e. FAMxxxxER.do, INDxxxxER.do, etc.)
* (4) set the default path (cd) to the data & script file directory.
set more off
* later years' family files have more than 5,000 variables - see the title page of the codebooks
set maxvar 6000 
* process family main files of each year - start with 1969 family file
quietly do FAM1969
rename V442 fid69  /*interview number (family ID) in 1969 family file*/
rename V529 faminc69     /*total family income in 1969 family file*/
* rename V495 censneed69   /*USDA (NOT census) need standards in 1969 family file*/
rename V801 raceh69	 //race, 1st mentioned, of head in 1969 family file
drop V*
sort fid*
save fam1969, replace
* process 1970 annual family file
quietly do FAM1970
rename V1102 fid70  /*interview number (family ID) in 1970 family file*/
rename V1514 faminc70     /*total family income in 1970 family file*/
* rename V1170 censneed70   /*USDA (NOT census) need standards in 1970 family file*/
rename V1490 raceh70	 //race, 1st mentioned, of head in 1969 family file
drop V*
sort fid*
save fam1970, replace
* process 1971 annual family file
quietly do FAM1971
rename V1802 fid71  /*interview number (family ID) in 1971 family file*/
rename V2226 faminc71     /*total family income in 1971 family file*/
* rename V1871 censneed71   /*USDA (NOT census) need standards in 1971 family file*/
rename V2202 raceh71	 //race, 1st mentioned, of head in 1969 family file
drop V*
sort fid*
save fam1971, replace
* process 1972 annual family file
quietly do FAM1972
rename V2402 fid72  /*interview number (family ID) in 1972 family file*/
rename V2852 faminc72     /*total family income in 1972 family file*/
* rename V2471 censneed72   /*USDA (NOT census) need standards in 1972 family file*/
rename V2828 raceh72	 //race, 1st mentioned, of head in 1969 family file
drop V*
sort fid*
save fam1972, replace
* process 1973 annual family file
quietly do FAM1973
rename V3002 fid73  /*interview number (family ID) in 1973 family file*/
rename V3256 faminc73     /*total family income in 1973 family file*/
* rename V3020 censneed73   /*USDA (NOT census) need standards in 1973 family file*/
rename V3300 raceh73	 //race, 1st mentioned, of head in 1969 family file
drop V*
sort fid*
save fam1973, replace
* process 1974 annual family file
quietly do FAM1974
rename V3402 fid74  /*interview number (family ID) in 1974 family file*/
rename V3676 faminc74     /*total family income in 1974 family file*/
* rename V3440 censneed74   /*USDA (NOT census) need standards in 1974 family file*/
rename V3720 raceh74	 //race, 1st mentioned, of head in 1969 family file
drop V*
sort fid*
save fam1974, replace
* process 1975 annual family file
quietly do FAM1975
rename V3802 fid75  /*interview number (family ID) in 1975 family file*/
rename V4154 faminc75     /*total family income in 1975 family file*/
* rename V3840 censneed75   /*USDA (NOT census) need standards in 1975 family file*/
rename V4204 raceh75	 //race, 1st mentioned, of head in 1969 family file
drop V*
sort fid*
save fam1975, replace
* process 1976 annual family file
quietly do FAM1976
rename V4302 fid76  /*interview number (family ID) in 1976 family file*/
rename V5029 faminc76     /*total family income in 1976 family file*/
* rename V4349 censneed76   /*USDA (NOT census) need standards in 1976 family file*/
rename V5096 raceh76	 //race, 1st mentioned, of head in 1969 family file
drop V*
sort fid*
save fam1976, replace
* process 1977 annual family file
quietly do FAM1977
rename V5202 fid77  /*interview number (family ID) in 1977 family file*/
rename V5626 faminc77     /*total family income in 1977 family file*/
* rename V5257 censneed77   /*USDA (NOT census) need standards in 1977 family file*/
rename V5662 raceh77	 //race, 1st mentioned, of head in 1969 family file
drop V*
sort fid*
save fam1977, replace
* process 1978 annual family file
quietly do FAM1978
rename V5702 fid78  /*interview number (family ID) in 1978 family file*/
rename V6173 faminc78     /*total family income in 1978 family file*/
* rename V5758 censneed78   /*USDA (NOT census) need standards in 1978 family file*/
rename V6209 raceh78	 //race, 1st mentioned, of head in 1969 family file
drop V*
sort fid*
save fam1978, replace
* process 1979 annual family file
quietly do FAM1979
rename V6302 fid79  /*interview number (family ID) in 1979 family file*/
rename V6766 faminc79     /*total family income in 1979 family file*/
* rename V6364 censneed79   /*USDA (NOT census) need standards in 1979 family file*/
rename V6802 raceh79	 //race, 1st mentioned, of head in 1969 family file
drop V*
sort fid*
save fam1979, replace
* process 1980 family file
quietly do FAM1980
rename V6902 fid80  /*interview number (family ID) in 1980 family file*/
rename V7412 faminc80     /*total family income in 1980 family file*/
rename V7447 raceh80      /*race, 1st mentioned, of head in 1980 family file*/
drop V*
sort fid*
save fam1980, replace
* process 1981 family file
quietly do FAM1981
rename V7502 fid81  /*interview number (family ID) in 1981 family file*/
rename V8065 faminc81     /*total family income in 1981 family file*/
rename V8099 raceh81      /*race, 1st mentioned, of head in 1981 family file*/
drop V*
sort fid*
save fam1981, replace
* process 1980 family file
quietly do FAM1982
rename V8202 fid82  /*interview number (family ID) in 1982 family file*/
rename V8689 faminc82     /*total family income in 1982 family file*/
rename V8723 raceh82      /*race, 1st mentioned, of head in 1982 family file*/
drop V*
sort fid*
save fam1982, replace
* process 1983 family file
quietly do FAM1983
rename V8802 fid83  /*interview number (family ID) in 1983 family file*/
rename V9375 faminc83     /*total family income in 1983 family file*/
rename V9408 raceh83      /*race, 1st mentioned, of head in 1983 family file*/
drop V*
sort fid*
save fam1983, replace
* process 1984 family file
quietly do FAM1984
rename V10002 fid84  /*interview number (family ID) in 1984 family file*/
rename V11022 faminc84     /*total family income in 1984 family file*/
rename V11055 raceh84      /*race, 1st mentioned, of head in 1984 family file*/
drop V*
sort fid*
save fam1984, replace
* process 1985 family file
quietly do FAM1985
rename V11102 fid85  /*interview number (family ID) in 1985 family file*/
rename V12371 faminc85     /*total family income in 1985 family file*/
rename V11938 raceh85      /*race, 1st mentioned, of head in 1985 family file*/
drop V*
sort fid*
save fam1985, replace
* process 1986 family file
quietly do FAM1986
rename V12502 fid86  /*interview number (family ID) in 1986 family file*/
rename V13623 faminc86     /*total family income in 1986 family file*/
rename V13565 raceh86      /*race, 1st mentioned, of head in 1986 family file*/
drop V*
sort fid*
save fam1986, replace
* process 1987 family file
quietly do FAM1987
rename V13702 fid87  /*interview number (family ID) in 1987 family file*/
rename V14670 faminc87     /*total family income in 1987 family file*/
rename V14612 raceh87      /*race, 1st mentioned, of head in 1987 family file*/
drop V*
sort fid*
save fam1987, replace
* process 1988 family file
quietly do FAM1988
rename V14802 fid88  /*interview number (family ID) in 1988 family file*/
rename V16144 faminc88     /*total family income in 1988 family file*/
rename V16086 raceh88      /*race, 1st mentioned, of head in 1988 family file*/
drop V*
sort fid*
save fam1988, replace
* process 1989 family file
quietly do FAM1989
rename V16302 fid89  /*interview number (family ID) in 1989 family file*/
rename V17533 faminc89     /*total family income in 1989 family file*/
rename V17483 raceh89      /*race, 1st mentioned, of head in 1989 family file*/
drop V*
sort fid*
save fam1989, replace

* process 1990 family file
quietly do FAM1990
rename V17702 fid90  /*interview number (family ID) in 1990 family file*/
rename V18875 faminc90     /*total family income in 1990 family file*/
rename V18884 censneed90   /*census need standards in 1990 family file*/
rename V18814 raceh90      /*race, 1st mentioned, of head in 1990 family file*/
drop V*
sort fid*
save fam1990, replace
* process 1991 family file
quietly do FAM1991
rename V19002 fid91  /*interview number (family ID) in 1991 family file*/
rename V20175 faminc91     /*total family income in 1991 family file*/
rename V20184 censneed91   /*census need standards in 1991 family file*/
rename V20114 raceh91      /*race, 1st mentioned, of head in 1991 family file*/
drop V*
sort fid*
save fam1991, replace
* process 1992 family file
quietly do FAM1992
rename V20302 fid92  /*interview number (family ID) in 1992 family file*/
rename V21481 faminc92     /*total family income in 1992 family file*/
rename V21490 censneed92   /*census need standards in 1992 family file*/
rename V21420 raceh92      /*race, 1st mentioned, of head in 1992 family file*/
drop V*
sort fid*
save fam1992, replace
* process 1993 family file
quietly do FAM1993
rename V21602 fid93  /*interview number (family ID) in 1993 family file*/
rename V23322 faminc93     /*total family income in 1993 family file*/
rename V23326 censneed93   /*census need standards in 1993 family file*/
rename V23276 raceh93      /*race, 1st mentioned, of head in 1993 family file*/
drop V*
sort fid*
save fam1993, replace
* process 1994 family file
quietly do FAM1994ER
rename ER2002 fid94  /*interview number (family ID) in 1994 family file*/
rename ER4153 faminc94     /*total family income in 1994 family file*/
rename ER4155 censneed94   /*census need standards in 1994 family file*/
mvdecode censneed94, mv(99999)
rename ER3944 raceh94      /*race, 1st mentioned, of head in 1994 family file*/
drop ER*
sort fid*
save fam1994, replace
* process 1995 family file
quietly do FAM1995ER
rename ER5002 fid95  /*interview number (family ID) in 1995 family file*/
rename ER6993 faminc95     /*total family income in 1995 family file*/
rename ER6995 censneed95   /*census need standards in 1995 family file*/
mvdecode censneed95, mv(99999)
rename ER6814 raceh95      /*race, 1st mentioned, of head in 1995 family file*/
drop ER*
sort fid*
save fam1995, replace
* process 1996 family file
quietly do FAM1996ER
rename ER7002 fid96  /*interview number (family ID) in 1996 family file*/
rename ER9244 faminc96     /*total family income in 1996 family file*/
rename ER9246 censneed96   /*census need standards in 1996 family file*/
rename ER9060 raceh96      /*race, 1st mentioned, of head in 1996 family file*/
drop ER*
sort fid*
save fam1996, replace
* process family main files of each year - start with 1997 family file
quietly do FAM1997ER
rename ER10002 fid97  /*interview number (family ID) in 1997 family file*/
rename ER10008 totfu97      /*total # of family unit (FU) in 1997 family file*/
rename ER10014 totnonfu97   /*total # of non-family unit (FU) in 1997 family file*/
rename ER12079 faminc97     /*total family income in 1997 family file*/
rename ER12220 censneed97   /*census need standards in 1997 family file*/
mvdecode censneed97, mv(99999)
rename ER11848 raceh97      /*race, 1st mentioned, of head in 1997 family file*/
rename ER12084 familywgt97    /*core/immigrant longitudinal family weight in 1997 family file*/
* rename ER marchange97    /*head, marital status change*/
* rename ERxxxxx hdworkhr97    //head, annual work hours in previous year
* rename ERxxxxx wfworkhr97    //wife, annual work hours in previous year
* rename ERxxxxx hdump97       //head, weeks missed, uemployment
* rename ERxxxxx hdils97       //head, weeks missed, ill-self
rename ER11812 hdnew97       //whether or not, new head (5=head is the same head as in previous year)
rename ER11731 wfnew97       //whether or not, new head (5=wife is the same head as in previous year, or no wife in FU - tricky but should work for our purpose)
rename ER10081 hd1emp97       //head, employment status, 1st mentioned
rename ER10082 hd2emp97       //head, employment status, 2nd mentioned
rename ER10083 hd3emp97       //head, employment status, 3rd mentioned
drop ER*
sort fid*
save fam1997, replace
* process 1999 bi-annual family file
quietly do FAM1999ER
rename ER13002 fid99  /*interview number (family ID) in 1999 family file*/
rename ER13009 totfu99      /*total # of family unit (FU) in 1999 family file*/
rename ER13015 totnonfu99   /*total # of non-family unit (FU) in 1999 family file*/
rename ER16462 faminc99     /*total family income in 1999 family file*/
rename ER16427 censneed99   /*census need standards in 1999 family file*/
rename ER15928 raceh99      /*race, 1st mentioned, of head in 1999 family file*/
rename ER16518 familywgt99    /*core/immigrant longitudinal family weight in 1999 family file*/
rename ER16424 hdmarchg99    /*head, marital status change*/
* rename ERxxxxx hdworkhr99    //head, annual work hours in previous year
* rename ERxxxxx wfworkhr99    //wife, annual work hours in previous year
* rename ERxxxxx hdump99       //head, weeks missed, uemployment
* rename ERxxxxx hdils99       //head, weeks missed, ill-self
rename ER15890 hdnew99       //whether or not, new head (5=head is the same head as in previous year)
rename ER15805 wfnew99       //whether or not, new head (5=wife is the same head as in previous year, or no wife in FU - tricky but should work for our purpose)
rename ER13205 hd1emp99       //head, employment status, 1st mentioned
rename ER13206 hd2emp99       //head, employment status, 2nd mentioned
rename ER13207 hd3emp99       //head, employment status, 3rd mentioned
drop ER*
sort fid*
save fam1999, replace
* process 2001 bi-annual family file
quietly do FAM2001ER
rename ER17002 fid01  /*interview number (family ID) in 2001 family file*/
rename ER17012 totfu01      /*total # of family unit (FU) in 2001 family file*/
rename ER17018 totnonfu01   /*total # of non-family unit (FU) in 2001 family file*/
rename ER20456 faminc01     /*total family income in 2001 family file*/
rename ER20373 censneed01   /*census need standards in 2001 family file*/
rename ER19989 raceh01      /*race, 1st mentioned, of head in 2001 family file*/
rename ER20394 familywgt01    /*core/immigrant longitudinal family weight in 2001 family file*/
rename ER20370 hdmarchg01    /*head, marital status change*/
* rename ERxxxxx hdworkhr01    //head, annual work hours in previous year
* rename ERxxxxx wfworkhr01    //wife, annual work hours in previous year
* rename ERxxxxx hdump01       //head, weeks missed, uemployment
* rename ERxxxxx hdils01       //head, weeks missed, ill-self
rename ER19951 hdnew01       //whether or not, new head (5=head is the same head as in previous year)
rename ER19866 wfnew01       //whether or not, new head (5=wife is the same head as in previous year, or no wife in FU - tricky but should work for our purpose)
rename ER17216 hd1emp01       //head, employment status, 1st mentioned
rename ER17217 hd2emp01       //head, employment status, 2nd mentioned
rename ER17218 hd3emp01       //head, employment status, 3rd mentioned
drop ER*
sort fid*
save fam2001, replace
* process 2003 bi-annual family file
quietly do FAM2003ER
rename ER21002 fid03  /*interview number (family ID) in 2003 family file*/
rename ER21016 totfu03      /*total # of family unit (FU) in 2003 family file*/
rename ER21022 totnonfu03   /*total # of non-family unit (FU) in 2003 family file*/
rename ER24099 faminc03     /*total family income in 2003 family file*/
rename ER24140 censneed03   /*census need standards in 2003 family file*/
rename ER23426 raceh03      /*race, 1st mentioned, of head in 2003 family file*/
rename ER24179 familywgt03    /*core/immigrant longitudinal family weight in 2003 family file*/
rename ER24151 hdmarchg03    /*head, marital status change*/
rename ER24080 hdworkhr03    //head, annual work hours in previous year
rename ER24091 wfworkhr03    //wife, annual work hours in previous year
rename ER21320 hdump03       //head, weeks missed, uemployment
rename ER24082 hdils03       //head, weeks missed, ill-self
rename ER23388 hdnew03       //whether or not, new head (5=head is the same head as in previous year)
rename ER23303 wfnew03       //whether or not, new head (5=wife is the same head as in previous year, or no wife in FU - tricky but should work for our purpose)
rename ER21123 hd1emp03       //head, employment status, 1st mentioned
rename ER21124 hd2emp03       //head, employment status, 2nd mentioned
rename ER21125 hd3emp03       //head, employment status, 3rd mentioned
drop ER*
sort fid*
save fam2003, replace
* process 2005 bi-annual family file
quietly do FAM2005ER
rename ER25002 fid05  /*interview number (family ID) in 2005 family file*/
rename ER25016 totfu05      /*total # of family unit (FU) in 2005 family file*/
rename ER25022 totnonfu05   /*total # of non-family unit (FU) in 2005 family file*/
rename ER28037 faminc05     /*total family income in 2005 family file*/
rename ER28039 censneed05   /*census need standards in 2005 family file*/
rename ER27393 raceh05      /*race, 1st mentioned, of head in 2005 family file*/
rename ER28078 familywgt05    /*core/immigrant longitudinal family weight in 2005 family file*/
rename ER28050 hdmarchg05    /*head, marital status change*/
rename ER27886 hdworkhr05    //head, annual work hours in previous year
rename ER27897 wfworkhr05    //wife, annual work hours in previous year
rename ER25309 hdump05       //head, weeks missed, uemployment
rename ER27888 hdils05       //head, weeks missed, ill-self
rename ER27352 hdnew05       //whether or not, new head (5=head is the same head as in previous year)
rename ER27263 wfnew05       //whether or not, new head (5=wife is the same head as in previous year, or no wife in FU - tricky but should work for our purpose)
rename ER25104 hd1emp05       //head, employment status, 1st mentioned
rename ER25105 hd2emp05       //head, employment status, 2nd mentioned
rename ER25106 hd3emp05       //head, employment status, 3rd mentioned
drop ER*
sort fid*
save fam2005, replace
* process 2007 bi-annual family file
quietly do FAM2007ER
rename ER36002 fid07  /*interview number (family ID) in 2007 family file*/
rename ER36016 totfu07      /*total # of family unit (FU) in 2007 family file*/
rename ER36022 totnonfu07   /*total # of non-family unit (FU) in 2007 family file*/
rename ER41027 faminc07     /*total family income in 2007 family file*/
rename ER41029 censneed07   /*census need standards in 2007 family file*/
rename ER40565 raceh07      /*race, 1st mentioned, of head in 2007 family file*/
rename ER41069 familywgt07    /*core/immigrant longitudinal family weight in 2007 family file*/
rename ER41040 hdmarchg07    /*head, marital status change*/
rename ER40876 hdworkhr07    //head, annual work hours in previous year
rename ER40887 wfworkhr07    //wife, annual work hours in previous year
rename ER36314 hdump07       //head, weeks missed, uemployment
rename ER40878 hdils07       //head, weeks missed, ill-self
rename ER40527 hdnew07       //whether or not, new head (5=head is the same head as in previous year)
rename ER40438 wfnew07       //whether or not, new head (5=wife is the same head as in previous year, or no wife in FU - tricky but should work for our purpose)
rename ER36109 hd1emp07       //head, employment status, 1st mentioned
rename ER36110 hd2emp07       //head, employment status, 2nd mentioned
rename ER36111 hd3emp07       //head, employment status, 3rd mentioned
drop ER*
sort fid*
save fam2007, replace
* process 2009 bi-annual family file
quietly do FAM2009ER
rename ER42002 fid09  /*interview number (family ID) in 2009 family file*/
rename ER42016 totfu09      /*total # of family unit (FU) in 2009 family file*/
rename ER42022 totnonfu09   /*total # of non-family unit (FU) in 2009 family file*/
rename ER46935 faminc09     /*total family income in 2009 family file*/
rename ER46972 censneed09   /*census need standards in 2009 family file*/
rename ER46543 raceh09      /*race, 1st mentioned, of head in 2009 family file*/
rename ER47012 familywgt09    /*core/immigrant longitudinal family weight in 2009 family file*/
rename ER46984 hdmarchg09    /*head, marital status change*/
rename ER46767 hdworkhr09    //head, annual work hours in previous year
rename ER46788 wfworkhr09    //wife, annual work hours in previous year
rename ER42341 hdump09       //head, weeks missed, uemployment
rename ER46770 hdils09       //head, weeks missed, ill-self
rename ER46504 hdnew09       //whether or not, new head (5=head is the same head as in previous year)
rename ER46410 wfnew09       //whether or not, new head (5=wife is the same head as in previous year, or no wife in FU - tricky but should work for our purpose)
rename ER42140 hd1emp09       //head, employment status, 1st mentioned
rename ER42141 hd2emp09       //head, employment status, 2nd mentioned
rename ER42142 hd3emp09       //head, employment status, 3rd mentioned
drop ER*
sort fid*
save fam2009, replace
* process longitudunal/cross-year individual file of 2009 (include 1968-2009 all surveyed individuals)
quietly do IND2009ER
gen pid=ER30001*1000+ER30002 /*a unique identifier for individual (pid=person ID), a combination of the 1968 family ID (ER30001) and the person number (ER30002)*/
rename ER32000 sex   /*gender of individual - time-invariant variable*/
rename ER31996 sestratum
rename ER31997 secluster
rename ER30020 fid69 /*1997 interview number (family ID) in the longitudunal individual file - use this to merge bi-annual family file*/
rename ER30043 fid70
rename ER30067 fid71
rename ER30091 fid72
rename ER30117 fid73
rename ER30138 fid74
rename ER30160 fid75
rename ER30188 fid76
rename ER30217 fid77
rename ER30246 fid78
rename ER30283 fid79
rename ER30313 fid80
rename ER30343 fid81
rename ER30373 fid82
rename ER30399 fid83
rename ER30429 fid84
rename ER30463 fid85
rename ER30498 fid86
rename ER30535 fid87
rename ER30570 fid88
rename ER30606 fid89
rename ER30642 fid90
rename ER30689 fid91
rename ER30733 fid92
rename ER30806 fid93
rename ER33101 fid94
rename ER33201 fid95
rename ER33301 fid96
rename ER33401 fid97 
rename ER33501 fid99
rename ER33601 fid01
rename ER33701 fid03
rename ER33801 fid05
rename ER33901 fid07
rename ER34001 fid09
mvdecode fid*, mv(0)
rename ER30021 seq69 /*1997 sequence number (person status #) in the longitudunal individual file - use this to merge bi-annual family file*/
rename ER30044 seq70
rename ER30068 seq71
rename ER30092 seq72
rename ER30118 seq73
rename ER30139 seq74
rename ER30161 seq75
rename ER30189 seq76
rename ER30218 seq77
rename ER30247 seq78
rename ER30284 seq79
rename ER30314 seq80
rename ER30344 seq81
rename ER30374 seq82
rename ER30400 seq83
rename ER30430 seq84
rename ER30464 seq85
rename ER30499 seq86
rename ER30536 seq87
rename ER30571 seq88
rename ER30607 seq89
rename ER30643 seq90
rename ER30690 seq91
rename ER30734 seq92
rename ER30807 seq93
rename ER33102 seq94
rename ER33202 seq95
rename ER33302 seq96
rename ER33402 seq97 
rename ER33502 seq99
rename ER33602 seq01
rename ER33702 seq03
rename ER33802 seq05
rename ER33902 seq07
rename ER34002 seq09
mvdecode seq*, mv(0)
rename ER30022 relation69 /*1997 relationship to head in the longitudunal individual file*/
rename ER30045 relation70
rename ER30069 relation71
rename ER30093 relation72
rename ER30119 relation73
rename ER30140 relation74
rename ER30162 relation75
rename ER30190 relation76
rename ER30219 relation77
rename ER30248 relation78
rename ER30285 relation79
rename ER30315 relation80
rename ER30345 relation81
rename ER30375 relation82
rename ER30401 relation83
rename ER30431 relation84
rename ER30465 relation85
rename ER30500 relation86
rename ER30537 relation87
rename ER30572 relation88
rename ER30608 relation89
rename ER30644 relation90
rename ER30691 relation91
rename ER30735 relation92
rename ER30808 relation93
rename ER33103 relation94
rename ER33203 relation95
rename ER33303 relation96
rename ER33403 relation97
rename ER33503 relation99
rename ER33603 relation01
rename ER33703 relation03
rename ER33803 relation05
rename ER33903 relation07
rename ER34003 relation09
mvdecode relation*, mv(0)
rename ER30023 age69 /*1997 age of individual in the longitudunal individual file*/
rename ER30046 age70
rename ER30070 age71
rename ER30094 age72
rename ER30120 age73
rename ER30141 age74
rename ER30163 age75
rename ER30191 age76
rename ER30220 age77
rename ER30249 age78
rename ER30286 age79
rename ER30316 age80
rename ER30346 age81
rename ER30376 age82
rename ER30402 age83
rename ER30432 age84
rename ER30466 age85
rename ER30501 age86
rename ER30538 age87
rename ER30573 age88
rename ER30609 age89
rename ER30645 age90
rename ER30692 age91
rename ER30736 age92
rename ER30809 age93
rename ER33104 age94
rename ER33204 age95
rename ER33304 age96
rename ER33404 age97
rename ER33504 age99
rename ER33604 age01
rename ER33704 age03
rename ER33804 age05
rename ER33904 age07
rename ER34004 age09
mvdecode age*, mv(0,999)
rename ER30404 byear83 /*1997 year born of individual in the longitudunal individual file*/
rename ER30434 byear84
rename ER30468 byear85
rename ER30503 byear86
rename ER30540 byear87
rename ER30575 byear88
rename ER30611 byear89
rename ER30647 byear90
rename ER30694 byear91
rename ER30738 byear92
rename ER30811 byear93
rename ER33106 byear94
rename ER33206 byear95
rename ER33306 byear96
rename ER33406 byear97
rename ER33506 byear99
rename ER33606 byear01
rename ER33706 byear03
rename ER33806 byear05
rename ER33906 byear07
rename ER34006 byear09
mvdecode byear*, mv(0,9999)
rename ER30403 bmonth83 /*1997 month born of individual in the longitudunal individual file*/
rename ER30433 bmonth84
rename ER30467 bmonth85
rename ER30502 bmonth86
rename ER30539 bmonth87
rename ER30574 bmonth88
rename ER30610 bmonth89
rename ER30646 bmonth90
rename ER30693 bmonth91
rename ER30737 bmonth92
rename ER30810 bmonth93
rename ER33105 bmonth94
rename ER33205 bmonth95
rename ER33305 bmonth96
rename ER33405 bmonth97
rename ER33505 bmonth99
rename ER33605 bmonth01
rename ER33705 bmonth03
rename ER33805 bmonth05
rename ER33905 bmonth07
rename ER34005 bmonth09
mvdecode bmonth*, mv(0,99)
*1969-1978, employment status is not available, use "work hours instead" in the meantime (temporary solution until I figure out)
gen byte emp69=1 if ER30034>0 & ER30034<9999
gen byte emp70=1 if ER30058>0 & ER30058<9999
gen byte emp71=1 if ER30082>0 & ER30082<9999
gen byte emp72=1 if ER30107>0 & ER30107<9999
gen byte emp73=1 if ER30131>0 & ER30131<9999
gen byte emp74=1 if ER30153>0 & ER30153<9999
gen byte emp75=1 if ER30177>0
gen byte emp76=1 if ER30204>0
gen byte emp77=1 if ER30233>0
gen byte emp78=1 if ER30270>0
rename ER30293 emp79 /*1997 age of individual in the longitudunal individual file*/
rename ER30323 emp80
rename ER30353 emp81
rename ER30382 emp82
rename ER30411 emp83
rename ER30441 emp84
rename ER30474 emp85
rename ER30509 emp86
rename ER30545 emp87
rename ER30580 emp88
rename ER30616 emp89
rename ER30653 emp90
rename ER30699 emp91
rename ER30744 emp92
rename ER30816 emp93
rename ER33111 emp94
rename ER33211 emp95
rename ER33311 emp96
rename ER33411 emp97 
rename ER33512 emp99
rename ER33612 emp01
rename ER33712 emp03
rename ER33813 emp05
rename ER33913 emp07
rename ER34016 emp09
mvdecode emp*, mv(0)
rename ER30042 personwgt69 /*1997 individual /x/longitudinal/x/ weight (personwgt) in the longitudunal individual file*/
rename ER30066 personwgt70
rename ER30090 personwgt71
rename ER30116 personwgt72
rename ER30137 personwgt73
rename ER30159 personwgt74
rename ER30187 personwgt75
rename ER30216 personwgt76
rename ER30245 personwgt77
rename ER30282 personwgt78
rename ER30312 personwgt79
rename ER30342 personwgt80
rename ER30372 personwgt81
rename ER30398 personwgt82
rename ER30428 personwgt83
rename ER30462 personwgt84
rename ER30497 personwgt85
rename ER30534 personwgt86
rename ER30569 personwgt87
rename ER30605 personwgt88
rename ER30641 personwgt89
rename ER30686 personwgt90
rename ER30730 personwgt91
rename ER30803 personwgt92
rename ER30864 personwgt93
rename ER33119 personwgt94
rename ER33275 personwgt95
rename ER33318 personwgt96
rename ER33430 personwgt97
rename ER33546 personwgt99
rename ER33637 personwgt01
rename ER33740 personwgt03
rename ER33848 personwgt05
rename ER33950 personwgt07
rename ER34045 personwgt09
mvdecode personwgt*, mv(0)
drop ER*
sort pid
/* the following doesn't work - * wildcard cannot be used in a "varlist" macro, http://www.stata.com/statalist/archive/2006-08/msg00616.html
forvalues num=69/109{
	if `num'<98{
		local yr2list "`yr2list' "*`num' ""
	}
	else if `num'==99{
		local yr2list "`yr2list' "*`num' ""
	}
	else if mod(`num',2){ // only if it's an odd number, http://www.stata.com/statalist/archive/2004-03/msg01068.html
		local num=substr("`num'",2,2)
		local yr2list "`yr2list' "*`num' ""
	}
}
order `yr2list'*/
compress
save ind19692009, replace
* add census needs (poverty thresholds) to 1968-1989.
* see PSID Home > Data > User Generated > Poverty threshold data: 1968-2005, based on 2008 Grieger article, "Accurately measuring the trend in poverty in the .."
use Poverty_Thresholds_Wide, clear
gen pid=ER30001*1000+ER30002 /*a unique identifier for individual (pid=person ID), a combination of the 1968 family ID (ER30001) and the person number (ER30002)*/
drop ER30001 ER30002
sort pid
save poverty_thresholds6704, replace
use  ind19692009, clear
sort pid
merge 1:1 pid using poverty_thresholds6704
/*
    Result                           # of obs.
    -----------------------------------------
    not matched                         4,062
        from master                     4,038  (_merge==1) //ind2009 contains 1968-2009 while poverty_thresholds6704 contains 1968-2005
        from using                         24  (_merge==2)

    matched                            67,247  (_merge==3)
    -----------------------------------------
*/
keep if _merge!=2
forvalues num=68/88{ 
	local yr2=`num'+1
	rename p`num' censneed`yr2' //the number in poverty_thresholds6704 variables refers to income year, not interview year
}
rename p89 censneedtest90 //testing with 1990 census need values = compare with the original one
drop _merge p6* p9* p0*
save ind19692009_pov, replace
use  ind19692009_pov, clear
* attach/merge each year's family file to the individual file
* our annual list is now longer & irregular (annual 1969-1996 & bi-annual 1997-2009). Use macro. Intro2stata programming, p55
local period 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1999 2001 2003 2005 2007 2009
foreach year of local period {
	local yr2=substr("`year'",3,2)
	sort fid`yr2'
	merge m:1 fid`yr2' using fam`year'      /*merge individual and each family file based on the family ID (fid)*/
	assert _merge!=2                        /*make sure all records from a family file are merged */
	drop _merge
	* capture gen censneed`yr2'=.
	* adjust total family income, firstly by replacing negatives & 0s (no income), secondly by adjusting to inflation (after this looping -
	* because we do NOT want to calculated inc2needs based on cpi-adjusted family income)
	gen adjfaminc`yr2' =faminc`yr2'
	gen adj2faminc`yr2'=faminc`yr2'
	replace adj2faminc`yr2'=1 if faminc`yr2'<=0  /*following the coding practice prior to 1994, replace negative and no(=0) family income with $1 */
	label variable adjfaminc`yr2'  "adjusted total family income, cpi-adjusted 2008 $"
	label variable adj2faminc`yr2' "adjusted total family income, no negative or 0"
	* create income-to-needs ratio using adjusted total family income with no negative/0
	gen inc2needs`yr2'=.
	replace inc2needs`yr2'=adj2faminc`yr2'/censneed`yr2' if adj2faminc`yr2'!=. & censneed`yr2'!=.
	label variable inc2needs`yr2' "income to needs ratio"
	* flag (=1) if one experienced the year in poverty (income-to-needs ratio<1.0),
	gen pov`yr2'=.
	replace pov`yr2'=0 if inc2needs`yr2'!=.
	replace pov`yr2'=1 if inc2needs`yr2'<1
	label variable pov`yr2' "indicates if one experienced the year in poverty: 1=yes, 0=no"
	save ind19692009_all, replace /*keep all individual records regardless of their survey status*/
}
***** Add "work hours & wages" files 1997-2001 to capture Duncan's life events *****
foreach year of numlist 1997 1999 2001 {
	local yr2=substr("`year'",3,2)
	use hours`yr2'
	foreach var of varlist *{
		local newvarname=lower("`var'")
		rename `var' `newvarname'
	}
	rename id`yr2' fid`yr2'
	rename hdtot`yr2' hdworkhr`yr2'
	rename wftot`yr2' wfworkhr`yr2'
	keep fid`yr2' hdworkhr`yr2' wfworkhr`yr2' hdump`yr2' hdils`yr2'
	sort fid`yr2'
	save hours`yr2'_prejoin, replace
	use ind19692009_all, clear
	sort fid`yr2'
	merge m:1 fid`yr2' using hours`yr2'_prejoin      /*merge individual and each family file based on the family ID (fid)*/
	assert _merge!=2                        /*make sure all records from a family file are merged */
	drop _merge
	save ind19692009_all, replace /*keep all individual records regardless of their survey status*/
}
/*foreach year of local period {
	drop if age`yr2'>=20 | age`yr2'==0 // since we are not interested in adults
}*/
* keep individuals who were present in 1997 PSID family units (surveyed in 1997) only
* keep if seq97<21 & seq97!=0
order pid sestratum secluster sex *69 *70 *71 *72 *73 *74 *75 *76 *77 *78 *79 *80 *81 *82 *83 *84 *85 *86 *87 *88 *89 *90 *91 *92 *93 *94 *95 *96 *97 *99 *01 *03 *05 *07 *09
save psid6909_preanalysis, replace
use  psid6909_preanalysis, clear
/*
/************************CALCULATE AVERAGE ANNUAL GROWTH IN INCOME-TO-NEEDS BY AGE AND SEX********************/
* Though didn't work for my purpose, the tool below was mentioned: http://econpapers.repec.org/software/bocbocode/s372501.htm
* net from http://fmwww.bc.edu/repec/bocode/_/
* net install _gslope
keep  pid inc2needs*
order pid inc2needs*
rename *9? *199? //fix year surffix - from 2-digit to 4-digit for reshape
rename *0? *200? //fix year surffix - from 2-digit to 4-digit for reshape
reshape long inc2needs, i(pid) j(year)
save temp, replace
* statsby, by(pid): regress inc2needs year //very slow + results saved in a new table, not efficient
* helpful site - run regression by group + retain returned results: http://www.stata.com/statalist/archive/2004-01/msg00690.html
* helpful site - save returned results: http://www.ats.ucla.edu/stat/stata/faq/returned_results.htm
* helpful site - skip errors + calc ave annual growth with OLS: http://www.stata.com/statalist/archive/2004-03/msg00902.html
gen slope=.
gen intcp=.
gen lninc2needs=.
quietly replace lninc2needs=ln(inc2needs)
* regress income to needs ratio on year - this portion takes a long time to finish.....
quietly levelsof pid, local(bypid) //create a new local macro, bypid, by grouping longitudinal records by pid = unit of regression
foreach  p of local bypid{
	capture regress lninc2needs year if pid==`p' //capture and skip regression in case of too few observataions
	quietly replace slope=_b[year] if pid==`p'
	quietly replace intcp=_b[_cons] if pid==`p'
}
* reshape back to the wide format
reshape wide inc2needs lninc2needs, i(pid) j(year)
gen growthrate=.
replace growthrate=exp(slope)-1
* order pid avefaminc slope intcp growthrate inc2needs* faminc*
keep pid slope intcp growthrate
sort pid
save psid6909_growthrate, replace

* merge the growthrate back to the original table
use psid6909_preanalysis, clear
sort pid
merge 1:1 pid using psid6909_growthrate
assert _merge==3
drop _merge
*/
/* drop individuals if the person wasn't surveyed or not reside with the sample family in any year between 1997-2009
foreach year of numlist 1997 1999 2001 2003 2005 2007 2009{
	local yr2=substr("`year'",3,2)
	* keep individuals who were surveyed throughout 1997-2009 only
	keep if seq`yr2'<21 & seq`yr2'!=0  /* keep only if the individual resided with the family (sequence#<21) in the year - see PSID tutorial#1 */
}*/
* Finally - adjusted to inflation/cpi: ftp://ftp.bls.gov/pub/special.requests/cpi/cpiai.txt
* replace adjfaminc07=adjfaminc07*215.303/201.6   - old statement
* replace adjfaminc09=adjfaminc09*215.303/215.303 - old statement
merge using cpi //make sure to save 1968-2011 annual average cpi table (cpi.dta) in the same directory
foreach year of local period { //do this for annual files, 1969-1996
	local yr2=substr("`year'",3,2)
	summarize cpi`yr2'
	local cpi`yr2'=r(max)
	replace adjfaminc`yr2'=adjfaminc`yr2'*215.303/cpi`yr2' //base year=2008, annual average: 215.303
}
drop _merge cpi68-cpi11 //drop/get rid of cpi values obtained from cpi.dta table
save psid6909_preanalysis_growthrate, replace
/************************construct age stack-up variables********************/
use psid6909_preanalysis_growthrate, clear
egen birthyear=rowmin(byear??)
egen bmonth   =rowmin(bmonth??)
gen  beginyear=.
gen  finalyear=.
egen beginage =rowmin(age??)
egen finalage =rowmax(age??)
* gen age0year =.  //note: age==0 means "inappropriate", newborns upto 2 yrs old are coded 1
forvalues num=1/40{
	quietly gen a`num'year=.
	quietly gen a`num'inc =.
}
local period 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1999 2001 2003 2005 2007 2009
foreach year of local period {
	local yr2=substr("`year'",3,2)
	quietly replace beginyear=`year' if beginyear==. & seq`yr2'<21 & seq`yr2'!=0
	quietly replace finalyear=`year'                if seq`yr2'<21 & seq`yr2'!=0
	forvalues num=1/40{
		quietly replace a`num'year=`year'         if age`yr2'==`num' & seq`yr2'<21 & seq`yr2'!=0
		quietly replace a`num'inc =adjfaminc`yr2' if age`yr2'==`num' & seq`yr2'<21 & seq`yr2'!=0
	}
}
order pid-pov09 birthyear beginyear finalyear beginage finalage a?year a??year a?inc a??inc
* create a variable for average total family income from 1968 to 2008.
* do we need to consider weight here..? I don't think so, but think again later -

*  egen  avefaminc=rowmean(adjfaminc*)
* label variable avefaminc "mean total family income from 1996 to 2008, cpi-adjusted 2008 $"

/*
* create indicator variables for ever-experienced a year in poverty AND more than 7 years (povcount>3) from 1996 to 2008.
egen    povcount=rowtotal(pov*)
gen     povever=.
replace povever=0 if povcount!=.
replace povever=1 if povcount>0 & povcount!=.
gen     povhalf=.
replace povhalf=0 if povcount!=.
replace povhalf=1 if povcount>3 & povcount!=.
label variable povcount "count of years experienced poverty"
label variable povever  "indicates if ever experienced poverty: 1=yes, .=no"
label variable povhalf  "indicates if ever experienced poverty more than 7 years: 1=yes, .=no"
foreach year of numlist 1997 1999 2001 2003 2005 2007 2009 { //skip the final year=2009 because we don't have data for the consecutive year
	local yr2=substr("`year'",3,2)
	* head employment status - get the prioritized code (in the order of: 2, 1, 3, 4, 5, 7, 6, 8, 9) from the 1st, 2nd and 3rd mentioned status
	gen     hdemp`yr2'=hd1emp`yr2'
	replace hdemp`yr2'=hd2emp`yr2' if hd2emp`yr2'!=0 & hdemp`yr2'!=2 & hd2emp`yr2'<hdemp`yr2'
	replace hdemp`yr2'=hd3emp`yr2' if hd3emp`yr2'!=0 & hdemp`yr2'!=2 & hd3emp`yr2'<hdemp`yr2'
}
* create an "adverse economic change" (inc2needs dropped 50%+) indicator variable
foreach year of numlist 1997 1999 2001 2003 2005 2007 { //skip the final year=2009 because we don't have data for the consecutive year
	local yearnext=`year'+2
	local yr2=substr("`year'",3,2)
	local yr2next=substr("`yearnext'",3,2)
	gen advschange`yr2next'=.
	replace advschange`yr2next'=0 if inc2needs`yr2'!=. & inc2needs`yr2next'!=.
	replace advschange`yr2next'=1 if (inc2needs`yr2next'-inc2needs`yr2')/inc2needs`yr2'<=-0.5 & inc2needs`yr2'!=. & inc2needs`yr2next'!=.
	label variable advschange`yr2next' "indicates if income-to-needs fell by 50% or more from prev. year: 1=yes, 0=no"
	gen byte event1_`yr2next'=hdmarchg`yr2next'==3 | hdmarchg`yr2next'==6 & ((relation97>=10 & relation97<35) | relation97==60)
	gen byte event2_`yr2next'=hdmarchg`yr2next'==4 | hdmarchg`yr2next'==7 & ((relation97>=10 & relation97<35) | relation97==60)
	gen byte event3_`yr2next'=(relation`yr2'!=10 & relation`yr2'!=20 & relation`yr2'!=21) & (relation`yr2next'==10 | relation`yr2next'==20 | relation`yr2next'==21)
	gen byte event4_`yr2next'=hdnew`yr2next'==5 & (hdworkhr`yr2'>1500 & hdworkhr`yr2next'<500) & ((hdemp`yr2'!=4 & hdemp`yr2'!=5) & (hdemp`yr2next'==4 | hdemp`yr2next'==5))
	* apply the event code of the head to the entire family member - because this is "family" event..
	* gsort fid`yr2next' -event4_`yr2next'
	* by fid`yr2next': replace event4_`yr2next'=1 if sum(event4_`yr2next')>0
	gen byte event5_`yr2next'=hdnew`yr2next'==5 & (hdump`yr2'<9 & hdump`yr2next'>=9) //by # of weeks, 61 days = 8.7 weeks
	gen byte event6_`yr2next'=hdnew`yr2next'==5 & (hdils`yr2'<9 & hdils`yr2next'>=9) //by # of weeks, 61 days = 8.7 weeks
	gen byte event7_`yr2next'=hdnew`yr2next'==5 & wfnew`yr2next'==5 & (wfworkhr`yr2'>1500 & wfworkhr`yr2next'<500)
}
egen advscount=rowtotal(advschange*)
foreach num of numlist 1/7{
	egen event`num'count=rowtotal(event`num'_*)
}
label variable advscount "indicates if income-to-needs fell by 50% or more at least once: 1=yes, 0=no"
label variable event1count "Duncan life event 1: family composition, divorce/separation of spouse or parents"
label variable event2count "Duncan life event 2: family composition, death of spouse or parent"
label variable event3count "Duncan life event 3: family composition, individual became head or wife"
label variable event4count "Duncan life event 4: labor/health, major reduction in work hours due to retire/disabilities"
label variable event5count "Duncan life event 5: labor/health, major unemployment of household head"
label variable event6count "Duncan life event 6: labor/health, major work loss due to illness of head"
label variable event7count "Duncan life event 7: labor/health, fall in work hours of wife"

* create Duncan's age category in 1997 (1st year of our analysis)
gen     agecat1=.
replace agecat1=1 if age97>=1  & age97<=4   //note: age==0 means "inappropriate", newborns upto 2 yrs old are coded 1
replace agecat1=2 if age97>=5  & age97<=24 
replace agecat1=3 if age97>=25 & age97<=45 
replace agecat1=4 if age97>=46 & age97<=55
replace agecat1=5 if age97>=56 & age97<=65 
replace agecat1=6 if age97>=66 & age97<=75 
label variable agecat1 "Duncan age category: 00-04, 05-24, 25-45, 46-55, 56-65, 66-75"
label define agecategory1 1 "age 00-04" 2 "age 05-24" 3 "age 25-45" 4 "age 46-55" 5 "age 56-65" 6 "age 66-75", replace
label values agecat1 agecategory1
gen     agecat1rc=1 if agecat1==1
replace agecat1rc=2 if agecat1==2 & sex==1
replace agecat1rc=3 if agecat1==2 & sex==2
replace agecat1rc=4 if agecat1==3 & sex==1
replace agecat1rc=5 if agecat1==3 & sex==2
replace agecat1rc=6 if agecat1==4 & sex==1
replace agecat1rc=7 if agecat1==4 & sex==2
replace agecat1rc=8 if agecat1==5 & sex==1
replace agecat1rc=9 if agecat1==5 & sex==2
replace agecat1rc=10 if agecat1==6 & sex==1
replace agecat1rc=11 if agecat1==6 & sex==2
label define agecategory1recode 1 "all 00-04" 2 "male 05-24" 3 "female 05-24" 4 "male 25-45" 5 "female 25-45" 6 "male 46-55" 7 "female 46-55" ///
				8 "male 56-65" 9 "female 56-65" 10 "male 66-75" 11 "female 66-75", replace
label values agecat1rc agecategory1recode
* the second age category also, create smaller categories for kids/young adults
gen     agecat2=.
replace agecat2=1 if age97>=1  & age97<=4  //note: age==0 means "inappropriate", newborns upto 2 yrs old are coded 1 
replace agecat2=2 if age97>=5  & age97<=12 
replace agecat2=3 if age97>=13 & age97<=18 
replace agecat2=4 if age97>=19 & age97<=24 
label variable agecat2 "Youth age category: age 00-04, 05-12, 13-18, 19-24"
label define agecategory2 1 "age 00-04" 2 "age 05-12" 3 "age 13-18" 4 "age 19-24", replace
label values agecat2 agecategory2
* the third age category also, create smaller categories for up to 19
gen     agecat3=.
replace agecat3=1 if age97>=1  & age97<=4  //note: age==0 means "inappropriate", newborns upto 2 yrs old are coded 1 
replace agecat3=2 if age97>=5  & age97<=9 
replace agecat3=3 if age97>=10 & age97<=14 
replace agecat3=4 if age97>=15 & age97<=19 
label variable agecat3 "Youth age category: age 00-04, 05-09, 10-14, 15-19"
label define agecategory3 1 "age 00-04" 2 "age 05-09" 3 "age 10-14" 4 "age 15-19", replace
label values agecat3 agecategory3

* label values sex gender - sex needs to be labeled for later analysis
label define sexlabel 1 "Male" 2 "Female", replace
label values sex sexlabel
* recode race of head in 1997 and then label
gen raceh97rc=.
replace raceh97rc=raceh97 if raceh97==1 | raceh97==2
replace raceh97rc=3 if raceh97==5
replace raceh97rc=4 if raceh97==3 | raceh97==4 | (raceh97>=6 & raceh97<=9)
label define raceheadrc 1 "White" 2 "Black" 3 "Latino" 4 "Others, including DK,NA", replace
label values raceh97rc raceheadrc
*/
* label values sex gender - sex needs to be labeled for later analysis
local period 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1999 2001 2003 2005 2007 2009
* do this for annual data files, 1969-1996
foreach year of local period {
	local yr2=substr("`year'",3,2)
	preserve
	keep pid sex age`yr2' adjfaminc`yr2' personwgt`yr2' raceh`yr2' 
	drop if age`yr2'>=20 | age`yr2'==0 // since we are not interested in adults
	* the third age category also, create smaller categories for up to 19
	gen     agecat3=.
	replace agecat3=1 if age`yr2'>=1  & age`yr2'<=4  //note: age==0 means "inappropriate", newborns upto 2 yrs old are coded 1 
	replace agecat3=2 if age`yr2'>=5  & age`yr2'<=9 
	replace agecat3=3 if age`yr2'>=10 & age`yr2'<=14 
	replace agecat3=4 if age`yr2'>=15 & age`yr2'<=19 
	capture rename *6? *196? //fix year surffix - from 2-digit to 4-digit for reshape
	capture rename *7? *197? //fix year surffix - from 2-digit to 4-digit for reshape
	capture rename *8? *198? //fix year surffix - from 2-digit to 4-digit for reshape
	capture rename *9? *199? //fix year surffix - from 2-digit to 4-digit for reshape
	capture rename *0? *200? //fix year surffix - from 2-digit to 4-digit for reshape
	reshape long age raceh adjfaminc personwgt, i(pid) j(year)
	save tempfaminc`yr2', replace
	restore
}
use tempfaminc69, clear
* new macro - period2, skips 1969 for appending data
local period2 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1999 2001 2003 2005 2007 2009
foreach year of local period2 {
	local yr2=substr("`year'",3,2)
	append using tempfaminc`yr2'.dta
}
label define sexlabel 1 "Male" 2 "Female", replace
label values sex sexlabel
label variable agecat3 "Youth age category: age 00-04, 05-09, 10-14, 15-19"
label define agecategory3 1 "age 00-04" 2 "age 05-09" 3 "age 10-14" 4 "age 15-19", replace
label values agecat3 agecategory3
gen avefaminc=adjfaminc
label variable avefaminc "mean total family income from 1996 to 2008, cpi-adjusted 2008 $"
save psid6909_analysis1data, replace
program averageincome //takes three inputs `1' category variable `2' second category (sex or race) `3' weight variable
	use psid6909_analysis1data, clear
	drop if `1'==. //though it is unlikely to have missing value in the age variables..
	summarize `2'
	local maxcategory=r(max)
	if `maxcategory'<3{
		local cohort "sex"
		local vnames "Male Female"
	}
	else{
		local cohort "race"
		local vnames "White Black Latino Other"
	}
	* repeat for each sex or race categories
	forvalues i=1/`maxcategory'{
		preserve
		keep if `2'==`i'
		sort `1'
		* collapse (mean)avefaminc`i'=avefaminc [weight=`3'], by(`1')
		collapse (mean)avefaminc`i'=avefaminc, by(`1')
		local v: word `i' of `vnames' //thanks to NJ Cox, sj2003_3-2_185-202
		label variable avefaminc`i' "`v'"
		* label variable avefaminc`i' "`2' `i'"
		sort `1'
		tempfile `1'_avefaminc`i'
		save "``1'_avefaminc`i''", replace
		capture restore
	}
	use "``1'_avefaminc1'", clear
	forvalues i=2/`maxcategory'{
		sort `1'
		merge 1:1 `1' using "``1'_avefaminc`i''"
		assert _merge==3
		drop _merge
	}
	save "averageincome_`1'_`2'", replace
******* to deal with age 00-04 problem
	if `maxcategory'<3{
		use psid_preanalysis_growthrate, clear
		keep if `2'!=. & `1'!=.
		* collapse (mean)avefamincall=avefaminc [weight=`3'], by(`1')
		collapse (mean)avefamincall=avefaminc, by(`1')
		sort `1'
		tempfile `1'_avefamincall
		save "``1'_avefamincall'", replace
		use "averageincome_`1'_`2'", clear
		sort `1'
		merge 1:1 `1' using "``1'_avefamincall'"
		assert _merge==3
		drop _merge
		replace avefaminc1=avefamincall if `1'==1
		replace avefaminc2=avefamincall if `1'==1
		drop avefamincall
		save "averageincome_`1'_`2'", replace
	}
******* 
	local linelist ""	
	forvalues i=1/`maxcategory'{
		local templines "`linelist'"
		local newlines "(line avefaminc`i' `1')"
		local linelist "`templines' `newlines'"
	}
	twoway `linelist', ///
		xtitle("Age in each year") ///
		ytitle("Income") ///
		title("Average total family income by age and `cohort'") ///
		subtitle("1968-2008") ///
		note("Source: PSID 1969-2009, by: `1' & `2', weight: no weight") ///
		legend(on) ///
		ylabel(0(20000)120000, angle(horizontal)) ///
		xlabel(, valuelabels)
	graph save "averageincome_`1'_`2'", replace	
end
averageincome agecat3 sex
capture program drop averageincome

* change variable order for readabilitiy
/*
order pid sestratum secluster sex agecat1 agecat2 avefaminc povcount povever povhalf advscount event1count event2count event3count ///
	event4count event5count event6count event7count slope intcp growthrate raceh97rc
*/
* Survey set - for computing sampling errors and statistics for the population
* svyset secluster [weight=personwgt09], strata(sestratum)
/*
gen byte event1rc=1 if event1count>0
gen byte event2rc=1 if event2count>0
gen byte event3rc=1 if event3count>0
gen byte event4rc=1 if event4count>0
gen byte event5rc=1 if event5count>0
gen byte event6rc=1 if event6count>0
gen byte event7rc=1 if event7count>0
save psid_preanalysis_growthrate, replace
* tabulate the results....
gen personwgt09int=int(personwgt09)
tab agecat1rc event1rc [w=personwgt09int], missing row nofreq
tab agecat1rc event2rc [w=personwgt09int], missing row nofreq
tab agecat1rc event3rc [w=personwgt09int], missing row nofreq
tab agecat1rc event4rc [w=personwgt09int], missing row nofreq
tab agecat1rc event5rc [w=personwgt09int], missing row nofreq
tab agecat1rc event6rc [w=personwgt09int], missing row nofreq
tab agecat1rc event7rc [w=personwgt09int], missing row nofreq
*/
/*
***** Analysis task 1: compute average total family income from 1996-2008 and then 
***** plot average income for full sample, and by age at start of study men & women
program averageincome //takes three inputs `1' category variable `2' second category (sex or race) `3' weight variable
	use psid_preanalysis_growthrate, clear
	drop if `1'==. //though it is unlikely to have missing value in the age variables..
	summarize `2'
	local maxcategory=r(max)
	if `maxcategory'<3{
		local cohort "sex"
		local vnames "Male Female"
	}
	else{
		local cohort "race"
		local vnames "White Black Latino Other"
	}
	* repeat for each sex or race categories
	forvalues i=1/`maxcategory'{
		preserve
		keep if `2'==`i'
		sort `1'
		collapse (mean)avefaminc`i'=avefaminc [weight=`3'], by(`1')
		local v: word `i' of `vnames' //thanks to NJ Cox, sj2003_3-2_185-202
		label variable avefaminc`i' "`v'"
		* label variable avefaminc`i' "`2' `i'"
		sort `1'
		tempfile `1'_avefaminc`i'
		save "``1'_avefaminc`i''", replace
		capture restore
	}
	use "``1'_avefaminc1'", clear
	forvalues i=2/`maxcategory'{
		sort `1'
		merge 1:1 `1' using "``1'_avefaminc`i''"
		assert _merge==3
		drop _merge
	}
	save "averageincome_`1'_`2'_`3'", replace
******* to deal with age 00-04 problem
	if `maxcategory'<3{
		use psid_preanalysis_growthrate, clear
		keep if `2'!=. & `1'!=.
		collapse (mean)avefamincall=avefaminc [weight=`3'], by(`1')
		sort `1'
		tempfile `1'_avefamincall
		save "``1'_avefamincall'", replace
		use "averageincome_`1'_`2'_`3'", clear
		sort `1'
		merge 1:1 `1' using "``1'_avefamincall'"
		assert _merge==3
		drop _merge
		replace avefaminc1=avefamincall if `1'==1
		replace avefaminc2=avefamincall if `1'==1
		drop avefamincall
		save "averageincome_`1'_`2'_`3'", replace
	}
******* 
	local linelist ""	
	forvalues i=1/`maxcategory'{
		local templines "`linelist'"
		local newlines "(line avefaminc`i' `1')"
		local linelist "`templines' `newlines'"
	}
	twoway `linelist', ///
		xtitle("Age in 1997") ///
		ytitle("Income") ///
		title("Average total family income by age and `cohort'") ///
		subtitle("1996-2008") ///
		note("Source: PSID 1997-2009, by: `1' & `2', weight: `3'") ///
		legend(on) ///
		ylabel(0(20000)120000, angle(horizontal)) ///
		xlabel(, valuelabels)
	graph save "averageincome_`1'_`2'_`3'", replace	
end
* averageincome agecat1 sex       personwgt09
* averageincome agecat2 sex       personwgt09
* averageincome agecat2 raceh97rc personwgt09 //may hide assertion in merging section - male & female race categories vary
averageincome agecat3 sex       personwgt09
averageincome agecat3 raceh97rc personwgt09
capture program drop averageincome

***** Analysis task 1B: plot income-to-needs ratio by age & genderfrom 1996-2008 
program averageinc2needs //takes three inputs `1' category variable `2' second category (sex or race) `3' weight variable
	use psid_preanalysis_growthrate, clear
	egen  aveinc2needs=rowmean(inc2needs*)
	drop if `1'==. //though it is unlikely to have missing value in the age variables..
	summarize `2'
	local maxcategory=r(max)
	if `maxcategory'<3{
		local cohort "sex"
		local vnames "Male Female"
	}
	else{
		local cohort "race"
		local vnames "White Black Latino Other"
	}
	* repeat for each sex or race categories
	forvalues i=1/`maxcategory'{
		preserve
		keep if `2'==`i' & aveinc2needs!=.
		sort `1'
		collapse (mean) maveinc2needs`i'=aveinc2needs [weight=`3'], by(`1')
		//replace maveinc2needs`i'=maveinc2needs`i'*100 //convert to percentage
		* replace maveinc2needs`i'=maveinc2needs
		local v: word `i' of `vnames' //thanks to NJ Cox, sj2003_3-2_185-202
		label variable maveinc2needs`i' "`v'"
		* label variable avegrowthrate`i' "`2'`i' growth rate"
		sort `1'
		tempfile `1'_maveinc2needs`i'
		save   "``1'_maveinc2needs`i''", replace
		restore
	}
	use "``1'_maveinc2needs1'", clear
	forvalues i=2/`maxcategory'{
		sort `1'
		merge 1:1 `1' using "``1'_maveinc2needs`i''"
		* assert _merge==3
		drop _merge
	}
	save "averageinc2needs_`1'_`2'_`3'", replace
******* to deal with age 00-04 problem
	if `maxcategory'<3{
		use psid_preanalysis_growthrate, clear
		egen  aveinc2needs=rowmean(inc2needs*)
		keep if `2'!=. & `1'!=.& aveinc2needs!=.
		collapse (mean) maveinc2needsall=aveinc2needs [weight=`3'], by(`1')
		sort `1'
		tempfile `1'_maveinc2needsall
		save "``1'_maveinc2needsall'", replace
		use "averageinc2needs_`1'_`2'_`3'", clear
		sort `1'
		merge 1:1 `1' using "``1'_maveinc2needsall'"
		assert _merge==3
		drop _merge
		replace maveinc2needs1=maveinc2needsall if `1'==1
		replace maveinc2needs2=maveinc2needsall if `1'==1
		drop maveinc2needsall
		save "averageinc2needs_`1'_`2'_`3'", replace
	}
*******
	local linelist ""	
	forvalues i=1/`maxcategory'{
		local templines "`linelist'"
		local newlines "(line maveinc2needs`i' `1')"
		local linelist "`templines' `newlines'"
	}
	twoway `linelist', ///
		xtitle("Age in 1997") ///
		ytitle("Income/needs") ///
		title("Average total family income-to-needs by age and `cohort'") ///
		subtitle("1997-2009") ///
		note("Source: PSID 1997-2009, by: `1' & `2', weight: `3'") ///
		legend(on) ///
		/// ylabel(0(1)5) ///
		ylabel(, angle(horizontal)) ///
		xlabel(, valuelabels)
	graph save "averageinc2needs_`1'_`2'_`3'", replace	
end
* averageinc2needs agecat1 sex       personwgt09
* averageinc2needs agecat2 sex       personwgt09
* averageinc2needs agecat2 raceh97rc personwgt09 //may hide assertion in merging section - male & female race categories vary
averageinc2needs agecat3 sex       personwgt09
averageinc2needs agecat3 raceh97rc personwgt09
capture program drop averageinc2needs
***** Analysis task 2: compute fraction of respondents with at least 1 year in poverty by age and gender.
***** Also compute fraction of respondents with more than half the years in poverty by age and gender
program povertyexperience //takes takes three inputs `1' category variable `2' second category (sex or race) `3' weight variable
	use psid_preanalysis_growthrate, clear
	drop if `1'==. //though it is unlikely to have missing value in the age variables..
	summarize `2'
	local maxcategory=r(max)
	if `maxcategory'<3{
		local cohort "sex"
		local vnames "Male Female"
	}
	else{
		local cohort "race"
		local vnames "White Black Latino Other"
	}
	* repeat for each sex or race categories
	forvalues i=1/`maxcategory'{
		preserve
		keep if `2'==`i' & povever==1
		sort `1'
		collapse (count) povever`i'=povever [weight=`3'], by(`1')
		local v: word `i' of `vnames' //thanks to NJ Cox, sj2003_3-2_185-202
		label variable povever`i' "`v'"
		sort `1'
		tempfile `1'_povever`i'
		save   "``1'_povever`i''", replace
		restore
		preserve
		keep if `2'==`i' 
		sort `1'
		collapse (count) povevertotal`i'=povever [weight=`3'], by(`1')
		local v: word `i' of `vnames' //thanks to NJ Cox, sj2003_3-2_185-202
		label variable povevertotal`i' "`v'"
		sort `1'
		tempfile `1'_povevertotal`i'
		save   "``1'_povevertotal`i''", replace
		restore
		preserve
		keep if `2'==`i' & povhalf==1
		sort `1'
		collapse (count) povhalf`i'=povhalf [weight=`3'], by(`1')
		local v: word `i' of `vnames' //thanks to NJ Cox, sj2003_3-2_185-202
		label variable povhalf`i' "`v'"
		sort `1'
		tempfile `1'_povhalf`i'
		save   "``1'_povhalf`i''", replace
		restore
		preserve
		keep if `2'==`i'
		sort `1'
		collapse (count) povhalftotal`i'=povhalf [weight=`3'], by(`1')
		local v: word `i' of `vnames' //thanks to NJ Cox, sj2003_3-2_185-202
		label variable povhalftotal`i' "`v'"
		sort `1'
		tempfile `1'_povhalftotal`i'
		save   "``1'_povhalftotal`i''", replace
		restore
	}
	* merge all collapsed count tables into one
	* use  "`1'_povevermale", clear
	use "``1'_povever1'", clear
	sort `1'
	merge 1:1 `1' using "``1'_povevertotal1'"
	*assert _merge==3
	drop _merge
	sort `1'
	merge 1:1 `1' using "``1'_povhalf1'"
	*assert _merge==3
	drop _merge
	sort `1'
	merge 1:1 `1' using "``1'_povhalftotal1'"
	*assert _merge==3
	drop _merge	
	sort `1'
	forvalues i=2/`maxcategory'{
		sort `1'
		merge 1:1 `1' using "``1'_povever`i''"
		*assert _merge==3
		drop _merge
	}
	forvalues i=2/`maxcategory'{
		sort `1'
		merge 1:1 `1' using "``1'_povevertotal`i''"
		*assert _merge==3
		drop _merge
	}
	forvalues i=2/`maxcategory'{
		sort `1'
		merge 1:1 `1' using "``1'_povhalf`i''"
		*assert _merge==3
		drop _merge
	}
	forvalues i=2/`maxcategory'{
		sort `1'
		merge 1:1 `1' using "``1'_povhalftotal`i''"
		*assert _merge==3
		drop _merge
	}
	forvalues i=1/`maxcategory'{
		gen p_povever`i'=povever`i'/povevertotal`i'
		gen p_povhalf`i'=povhalf`i'/povhalftotal`i'
		replace p_povever`i'=p_povever`i'*100 //convert to percentage
		replace p_povhalf`i'=p_povhalf`i'*100 //convert to percentage
		local v: word `i' of `vnames' //thanks to NJ Cox, sj2003_3-2_185-202
		label variable p_povever`i' "`v' - once"
		label variable p_povhalf`i' "`v' - half"
	}
	save "povertyexperience_`1'_`2'_`3'", replace
******* to deal with age 00-04 problem
	if `maxcategory'<3{
		use "povertyexperience_`1'_`2'_`3'", clear
		gen p_poveverall=(povever1+povever2)/(povevertotal1+povevertotal2)
		gen p_povhalfall=(povhalf1+povhalf2)/(povhalftotal1+povhalftotal2)
		replace p_poveverall=p_poveverall*100 //convert to percentage
		replace p_povhalfall=p_povhalfall*100 //convert to percentage
		replace p_povever1=p_poveverall if `1'==1
		replace p_povever2=p_poveverall if `1'==1
		replace p_povhalf1=p_povhalfall if `1'==1
		replace p_povhalf2=p_povhalfall if `1'==1
		drop    p_poveverall p_povhalfall
		save "povertyexperience_`1'_`2'_`3'", replace
	}
*******
	if `maxcategory'<3 {  		// if "age" then group all poverty categories	
		local linelist ""	
		forvalues i=1/`maxcategory'{
			local templines "`linelist'"
			local newlines1 "(line p_povever`i' `1')"
			local newlines2 "(line p_povhalf`i' `1')"
			local linelist "`templines' `newlines1' `newlines2'"
		}
		* display "`linelist'"
		twoway `linelist', ///
			xtitle("Age in 1997") ///
			ytitle("Percent") ///
			title("Fractions of age and `cohort' cohorts experiencing poverty") ///
			subtitle("at least once and at least half years 1996-2008") ///
			note("Source: PSID 1997-2009, by: `1' & `2', weight: `3'") ///
			legend(on) ///
			ylabel(, angle(horizontal)) ///
			xlabel(, valuelabels)
		graph save "povertyexperience_`1'_`2'_`3'_age", replace
	}
	else if `maxcategory'>=3 {	//if "race" then split poverty graph into 2 graphs
		local linelist ""	
		forvalues i=1/`maxcategory'{
			local templines "`linelist'"
			local newlines1 "(line p_povever`i' `1')"
			*local newlines2 "(line p_povhalf`i' `1')"
			local linelist "`templines' `newlines1'"
		}
		* display "`linelist'"
		twoway `linelist', ///
			xtitle("Age in 1997") ///
			ytitle("Percent") ///
			title("Fractions of age and `cohort' cohorts experiencing poverty") ///
			subtitle("at least once 1996-2008") ///
			note("Source: PSID 1997-2009, by: `1' & `2', weight: `3'") ///
			legend(on) ///
			ylabel(, angle(horizontal)) ///
			xlabel(, valuelabels)
		graph save "povertyexperience_`1'_`2'_`3'_race1", replace
		local linelist ""	
		forvalues i=1/`maxcategory'{
			local templines "`linelist'"
			*local newlines1 "(line p_povever`i' `1')"
			local newlines2 "(line p_povhalf`i' `1')"
			local linelist "`templines' `newlines2'"
		}
		* display "`linelist'"
		twoway `linelist', ///
			xtitle("Age in 1997") ///
			ytitle("Percent") ///
			title("Fractions of age and `cohort' cohorts experiencing poverty") ///
			subtitle("at least half years 1996-2008") ///
			note("Source: PSID 1997-2009, by: `1' & `2', weight: `3'") ///
			legend(on) ///
			ylabel(, angle(horizontal)) ///
			xlabel(, valuelabels)
		graph save "povertyexperience_`1'_`2'_`3'_race2", replace
	}
end
* povertyexperience agecat1 sex       personwgt09
* povertyexperience agecat2 sex       personwgt09
* povertyexperience agecat2 raceh97rc personwgt09 //hide assertion in merging section - male & female race categories vary
povertyexperience agecat3 sex       personwgt09
povertyexperience agecat3 raceh97rc personwgt09
capture program drop povertyexperience
***** Analysis task 3: compute average annual growth rate in income-to-needs ratio by age and gender.
program averagegrowthinc2needs //takes three inputs `1' category variable `2' second category (sex or race) `3' weight variable
	use psid_preanalysis_growthrate, clear
	drop if `1'==.
	summarize `2'
	local maxcategory=r(max)
	if `maxcategory'<3 {
		local cohort "sex"
		local vnames "Male Female"
	}
	else{
		local cohort "race"
		local vnames "White Black Latino Other"
	}
	* repeat for each sex or race categories
	forvalues i=1/`maxcategory'{
		preserve
		keep if `2'==`i' & growthrate!=.
		sort `1'
		collapse (mean) avegrowthrate`i'=growthrate [weight=`3'], by(`1')
		replace avegrowthrate`i'=avegrowthrate`i'*100 //convert to percentage
		local v: word `i' of `vnames' //thanks to NJ Cox, sj2003_3-2_185-202
		label variable avegrowthrate`i' "`v'"
		* label variable avegrowthrate`i' "`2'`i' growth rate"
		sort `1'
		tempfile `1'_avegrowth`i'
		save   "``1'_avegrowth`i''", replace
		restore
	}
	use "``1'_avegrowth1'", clear
	forvalues i=2/`maxcategory'{
		sort `1'
		merge 1:1 `1' using "``1'_avegrowth`i''"
		* assert _merge==3
		drop _merge
	}
	save "averagegrowthinc2needs_`1'_`2'_`3'", replace
******* to deal with age 00-04 problem
	if `maxcategory'<3{
		use psid_preanalysis_growthrate, clear
		keep if growthrate!=.
		collapse (mean) avegrowthrateall=growthrate [weight=`3'], by(`1')
		replace avegrowthrateall=avegrowthrateall*100 //convert to percentage
		sort `1'
		tempfile `1'_avegrowthall
		save   "``1'_avegrowthall'", replace
		
		use "averagegrowthinc2needs_`1'_`2'_`3'", clear
		sort `1'
		merge 1:1 `1' using "``1'_avegrowthall'"
		* assert _merge==3
		drop _merge
		replace avegrowthrate1=avegrowthrateall if `1'==1
		replace avegrowthrate2=avegrowthrateall if `1'==1
		drop avegrowthrateall
		save "averagegrowthinc2needs_`1'_`2'_`3'", replace
	}
*******
	local linelist ""	
	forvalues i=1/`maxcategory'{
		local templines "`linelist'"
		local newlines "avegrowthrate`i'"
		local linelist "`templines' `newlines'"
	}
	graph bar (asis) `linelist', ///
		over(`1') ///
		ytitle("Percent") ///
		title("Average annual growth in income-to-needs") ///
		subtitle("by age and `cohort'") ///
		note("Source: PSID 1997-2009, by: `1' & `2', weight: `3'") ///
		ylabel(, angle(horizontal))
	graph save "averagegrowthinc2needs_`1'_`2'_`3'", replace
end
* averagegrowthinc2needs agecat1 sex       personwgt09
* averagegrowthinc2needs agecat2 sex       personwgt09
* averagegrowthinc2needs agecat2 raceh97rc personwgt09 //hide assertion in merging section - male & female race categories vary
averagegrowthinc2needs agecat3 sex       personwgt09
averagegrowthinc2needs agecat3 raceh97rc personwgt09
capture program drop averagegrowthinc2needs
*
***** Analysis task CV: compute CV for (average?) total family income from 1996-2008 by age and gender.
***** Also show CV by income-to-needs ratio categories (<1; 1-2; 2+)
/*
CV analysis - omitted - see master_08122012.do to recover this part
*/
*
***** Analysis task 4: graph the fraction of individuals that had at least one 50%+ drop - Duncan Figure 6 *****
program income50drop 
	use psid_preanalysis_growthrate, clear
	drop if `1'==. //though it is unlikely to have missing value in the age variables..
	summarize `2'
	local maxcategory=r(max)
	if `maxcategory'<3{
		local cohort "sex"
		local vnames "Male Female"
	}
	else{
		local cohort "race"
		local vnames "White Black Latino Other"
	}
	* repeat for each sex or race categories
	forvalues i=1/`maxcategory'{
		preserve
		keep if `2'==`i' & advscount>=1 & advscount!=.
		sort `1'
		collapse (count) advscount`i'=advscount [weight=`3'], by(`1')
		local v: word `i' of `vnames' //thanks to NJ Cox, sj2003_3-2_185-202
		label variable advscount`i' "`v'"
		sort `1'
		tempfile `1'_advscount`i'
		save   "``1'_advscount`i''", replace
		restore
		preserve
		keep if `2'==`i' 
		sort `1'
		collapse (count) advscounttotal`i'=advscount [weight=`3'], by(`1')
		local v: word `i' of `vnames' //thanks to NJ Cox, sj2003_3-2_185-202
		label variable advscounttotal`i' "`v'"
		sort `1'
		tempfile `1'_advscounttotal`i'
		save   "``1'_advscounttotal`i''", replace
		restore
	}
	* merge all collapsed count tables into one
	use "``1'_advscount1'", clear
	sort `1'
	merge 1:1 `1' using "``1'_advscounttotal1'"
	*assert _merge==3
	drop _merge	
	sort `1'
	forvalues i=2/`maxcategory'{
		sort `1'
		merge 1:1 `1' using "``1'_advscount`i''"
		*assert _merge==3
		drop _merge
	}
	forvalues i=2/`maxcategory'{
		sort `1'
		merge 1:1 `1' using "``1'_advscounttotal`i''"
		*assert _merge==3
		drop _merge
	}
	forvalues i=1/`maxcategory'{
		gen p_advscount`i'=advscount`i'/advscounttotal`i'
		replace p_advscount`i'=p_advscount`i'*100 //convert to percentage
		local v: word `i' of `vnames' //thanks to NJ Cox, sj2003_3-2_185-202
		label variable p_advscount`i' "`v'"
	}
	save "income50drop_`1'_`2'_`3'", replace

******* to deal with age 00-04 problem
	if `maxcategory'<3{
		use "income50drop_`1'_`2'_`3'", clear
		gen p_advscountall=(advscount1+advscount2)/(advscounttotal1+advscounttotal2)
		replace p_advscountall=p_advscountall*100 //convert to percentage
		replace p_advscount1=p_advscountall if `1'==1
		replace p_advscount2=p_advscountall if `1'==1
		drop    p_advscountall
		save "income50drop_`1'_`2'_`3'", replace
	}
*******
	local linelist ""	
	forvalues i=1/`maxcategory'{
		local templines "`linelist'"
		local newlines1 "(line p_advscount`i' `1')"
		local linelist "`templines' `newlines1'"
	}
	* display "`linelist'"
	twoway `linelist', ///
		xtitle("Age in 1969") ///
		ytitle("Percent") ///
		title("Fractions of age and `cohort' cohorts with income-to-needs") ///
		subtitle("falling by 50% or more at least once 1969-1979") ///
		note("Source: PSID 1997-2009, by: `1' & `2', weight: `3'") ///
		legend(on) ///
		ylabel(, angle(horizontal)) ///
		xlabel(, valuelabels)
	graph save "income50drop_`1'_`2'_`3'_age", replace
end
* income50drop agecat1 sex       personwgt09
* income50drop agecat2 sex       personwgt09
* income50drop agecat2 raceh97rc personwgt09 //hide assertion in merging section - male & female race categories vary
income50drop agecat3 sex       personwgt09
income50drop agecat3 raceh97rc personwgt09
capture program drop income50drop

***** Analysis task 4: collect statistics.
use psid_preanalysis_growthrate, clear
log using analysis4_statistics, text replace
*produce statistics - note: "Total:" means "age 0-12"
quietly{
	*ssc install tabstat // need to install this first!!
	tabstat avefaminc povcount growthrate if agecat2<3, by (agecat2) ///
			stat (mean median min max sd) col(stat) format(%10.2fc) save
	tabstatmat B
	matrix B = B'
}
matrix list B, format(%10.2fc)
* produce similar statistics but using a proper weight..
quietly {
	* see: http://www.stata.com/help.cgi?svy+estimation
	gen byte age0004= agecat2==1              //flag "age 0-4". Values will be either 0 or 1
	gen byte age0512= agecat2==2              //flag "age 5-12". Values will be either 0 or 1
	gen byte age0012= agecat2>=1 & agecat2<=2 //flag "age 0-12". Values will be either 0 or 1
	svyset secluster [weight=personwgt97], strata(sestratum)
}
* age 00-04 only
svy, subpop(age0004): mean avefaminc povcount growthrate
estat sd
* age 05-12 only
svy, subpop(age0512): mean avefaminc povcount growthrate
estat sd
* age 00-12 only
svy, subpop(age0012): mean avefaminc povcount growthrate
estat sd
* display 100*r(sd)/r(mean) //I still need to calculate CV..
log close
clear all
*
*********** Graph manipulation ********
/** combine all graphs for each analysis into one graph for better comparison
* ! dir *.gph /a-d /b >d:\filelist.txt //this is Windows DOS command
! ls analysis1*.gph>list1.txt //thisis UNIX command - use Windows DOS command style above in using Windows OS
! ls analysis2*.gph>list2.txt //thisis UNIX command - use Windows DOS command style above in using Windows OS
! ls analysis3*.gph>list3.txt //thisis UNIX command - use Windows DOS command style above in using Windows OS
forvalues i=1/3{
	local namelist ""
	file open myfile using list`i'.txt, read
	file read myfile line
	while r(eof)==0 {
		local tempnamelist "`namelist'"
		local newname "`line'"
		local namelist "`tempnamelist' `newname'"
		file read myfile line
	}
	graph combine `namelist'
	graph save "analysis`i'_combined", replace
	file close myfile
}*/
** exporting all graphs in PNG
* ! dir *.gph /a-d /b >d:\filelist.txt //this is Windows DOS command
! ls *.gph>filelist.txt //thisis UNIX command - use Windows DOS command style above in using Windows OS
file open myfile using filelist.txt, read
file read myfile line
while r(eof)==0 {
	graph use `line'
	local filename=substr("`line'",1,strpos("`line'",".")-1)
	graph export "`filename'.png", replace
	file read myfile line
}
file close myfile
clear all
*/
clear all
exit
