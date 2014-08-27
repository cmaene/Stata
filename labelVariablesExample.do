local var1 "08sr 10sr"
local var2 "mrrs1_vsamplelineid mrrs2_vsamplelineid"
forvalues num=1/2{
	local v1: word `num' of `var1'
	local v2: word `num' of `var2'
	local v3=substr("`v1'",1,2)

	use od20`v1'_step6_orig, clear

	save od20`v1'_step6, replace

	use od20`v1'_step6, clear
	gen radi`v1'_1m=1 if distance>0 & distance<=1
	gen radi`v1'_2m=1 if distance>0 & distance<=2
	gen radi`v1'_3m=1 if distance>0 & distance<=3	
	gen drive`v1'_05m=1 if time_drive>0 & time_drive<=5
	gen drive`v1'_10m=1 if time_drive>0 & time_drive<=10
	gen drive`v1'_15m=1 if time_drive>0 & time_drive<=15
	gen drive`v1'_20m=1 if time_drive>0 & time_drive<=20
	gen drive`v1'_30m=1 if time_drive>0 & time_drive<=30
	gen walk`v1'_05m =1 if time_walk>0 & time_walk<=5
	gen walk`v1'_10m =1 if time_walk>0 & time_walk<=10
	gen walk`v1'_15m =1 if time_walk>0 & time_walk<=15
	gen walk`v1'_20m =1 if time_walk>0 & time_walk<=20
	gen walk`v1'_30m =1 if time_walk>0 & time_walk<=30
	gen pubtr`v1'_05m=1 if time_pubtrans9am>0 & time_pubtrans9am<=5
	gen pubtr`v1'_10m=1 if time_pubtrans9am>0 & time_pubtrans9am<=10
	gen pubtr`v1'_15m=1 if time_pubtrans9am>0 & time_pubtrans9am<=15
	gen pubtr`v1'_20m=1 if time_pubtrans9am>0 & time_pubtrans9am<=20
	gen pubtr`v1'_30m=1 if time_pubtrans9am>0 & time_pubtrans9am<=30
	sort `v2'
	collapse (sum) radi* drive* walk* pubtr* (min)distance time_drive time_walk time_pubtrans9am, by(`v2')
	rename distance 		min`v1'_distance
	rename time_drive		min`v1'_drive
	rename time_walk		min`v1'_walk
	rename time_pubtrans9am         min`v1'_pubtrans
	label variable min`v1'_distance     "20`v3' SNAP retail all: minimum Euclidean distance"
	label variable min`v1'_drive 	"20`v3' SNAP retail all: minimum travel time by car"
	label variable min`v1'_walk 	"20`v3' SNAP retail all: minimum travel time by walk"
	label variable min`v1'_pubtrans     "20`v3' SNAP retail all: minimum travel time by public transit"
	*if `num'>1{
	*	rename `v2'_vsamplelineid mrrs1_vsamplelineid
	*}
	sort `v2'
	save od20`v1'_collapsed1, replace
	* use od_time_all_od20`v1'1, clear
	foreach var of varlist * {
		if strpos("`var'","08")>0 {
			label variable `var' "2008 "
			local vlabel : variable label `var'
			* display "`vlabel'"
			if strpos("`var'","sr_")>0 {
				label variable `var' "`vlabel'SNAP retail all: counts within "
				local vlabel : variable label `var'
				* display "`vlabel'"
				if strpos("`var'","_05m")>0 {
					label variable `var' "`vlabel'5-min "
					local vlabel : variable label `var'
					* display "`vlabel'"
					if strpos("`var'","drive")>0 {
						label variable `var' "`vlabel'by car"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","walk")>0 {
						label variable `var' "`vlabel'by walk"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","pubtr")>0 {
						label variable `var' "`vlabel'by public transit"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
				}
				else if strpos("`var'","_10m")>0 {
					label variable `var' "`vlabel'10-min "
					local vlabel : variable label `var'
					* display "`vlabel'"
					if strpos("`var'","drive")>0 {
						label variable `var' "`vlabel'by car"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","walk")>0 {
						label variable `var' "`vlabel'by walk"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","pubtr")>0 {
						label variable `var' "`vlabel'by public transit"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
				}
				else if strpos("`var'","_15m")>0 {
					label variable `var' "`vlabel'15-min "
					local vlabel : variable label `var'
					* display "`vlabel'"
					if strpos("`var'","drive")>0 {
						label variable `var' "`vlabel'by car"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","walk")>0 {
						label variable `var' "`vlabel'by walk"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","pubtr")>0 {
						label variable `var' "`vlabel'by public transit"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
				}
				else if strpos("`var'","_20m")>0 {
					label variable `var' "`vlabel'20-min "
					local vlabel : variable label `var'
					* display "`vlabel'"
					if strpos("`var'","drive")>0 {
						label variable `var' "`vlabel'by car"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","walk")>0 {
						label variable `var' "`vlabel'by walk"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","pubtr")>0 {
						label variable `var' "`vlabel'by public transit"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
				}
				else if strpos("`var'","_30m")>0 {
					label variable `var' "`vlabel'30-min "
					local vlabel : variable label `var'
					* display "`vlabel'"
					if strpos("`var'","drive")>0 {
						label variable `var' "`vlabel'by car"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","walk")>0 {
						label variable `var' "`vlabel'by walk"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","pubtr")>0 {
						label variable `var' "`vlabel'by public transit"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
				}
			}
		}
		else if strpos("`var'","10")>0 {
			label variable `var' "2010 "
			local vlabel : variable label `var'
			* display "`vlabel'"
			if strpos("`var'","sr_")>0 {
				label variable `var' "`vlabel'SNAP retail all: counts within "
				local vlabel : variable label `var'
				* display "`vlabel'"
				if strpos("`var'","_05m")>0 {
					label variable `var' "`vlabel'5-min "
					local vlabel : variable label `var'
					* display "`vlabel'"
					if strpos("`var'","drive")>0 {
						label variable `var' "`vlabel'by car"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","walk")>0 {
						label variable `var' "`vlabel'by walk"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","pubtr")>0 {
						label variable `var' "`vlabel'by public transit"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
				}
				else if strpos("`var'","_10m")>0 {
					label variable `var' "`vlabel'10-min "
					local vlabel : variable label `var'
					* display "`vlabel'"
					if strpos("`var'","drive")>0 {
						label variable `var' "`vlabel'by car"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","walk")>0 {
						label variable `var' "`vlabel'by walk"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","pubtr")>0 {
						label variable `var' "`vlabel'by public transit"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
				}
				else if strpos("`var'","_15m")>0 {
					label variable `var' "`vlabel'15-min "
					local vlabel : variable label `var'
					* display "`vlabel'"
					if strpos("`var'","drive")>0 {
						label variable `var' "`vlabel'by car"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","walk")>0 {
						label variable `var' "`vlabel'by walk"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","pubtr")>0 {
						label variable `var' "`vlabel'by public transit"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
				}
				else if strpos("`var'","_20m")>0 {
					label variable `var' "`vlabel'20-min "
					local vlabel : variable label `var'
					* display "`vlabel'"
					if strpos("`var'","drive")>0 {
						label variable `var' "`vlabel'by car"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","walk")>0 {
						label variable `var' "`vlabel'by walk"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","pubtr")>0 {
						label variable `var' "`vlabel'by public transit"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
				}
				else if strpos("`var'","_30m")>0 {
					label variable `var' "`vlabel'30-min "
					local vlabel : variable label `var'
					* display "`vlabel'"
					if strpos("`var'","drive")>0 {
						label variable `var' "`vlabel'by car"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","walk")>0 {
						label variable `var' "`vlabel'by walk"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
					else if strpos("`var'","pubtr")>0 {
						label variable `var' "`vlabel'by public transit"
						local vlabel : variable label `var'
						* display "`vlabel'"
					}
				}
			}
		}
	}
	compress
	sort `v2'
	label variable min`v1'_distance     "20`v3' SNAP retail all: minimum Euclidean distance"
	label variable min`v1'_drive 	"20`v3' SNAP retail all: minimum travel time by car"
	label variable min`v1'_walk 	"20`v3' SNAP retail all: minimum travel time by walk"
	label variable min`v1'_pubtrans     "20`v3' SNAP retail all: minimum travel time by public transit"
	label variable radi`v1'_1m  "20`v3' SNAP retail all: counts within 1-mile radius"
	label variable radi`v1'_2m  "20`v3' SNAP retail all: counts within 2-mile radius"
	label variable radi`v1'_3m  "20`v3' SNAP retail all': counts within 3-mile radius"
	save od_time_all_od20`v1'1, replace
	* this "all" type will be the core file for later "by type" appending
	use  od_time_all_od20`v1'1, clear
	save od_time_all_od20`v1'_bytype, replace
	
	* do the following for "by type"
	forvalues i=2/6{
		local type=`i'-1
		use od20`v1'_step6, clear
		keep if snapstoretype`v3'rc==`i'-1
		gen radi`v1'_1m=1 if distance>0 & distance<=1
		gen radi`v1'_2m=1 if distance>0 & distance<=2
		gen radi`v1'_3m=1 if distance>0 & distance<=3	
		gen drive`v1'_05m=1 if time_drive>0 & time_drive<=5
		gen drive`v1'_10m=1 if time_drive>0 & time_drive<=10
		gen drive`v1'_15m=1 if time_drive>0 & time_drive<=15
		gen drive`v1'_20m=1 if time_drive>0 & time_drive<=20
		gen drive`v1'_30m=1 if time_drive>0 & time_drive<=30
		gen walk`v1'_05m =1 if time_walk>0 & time_walk<=5
		gen walk`v1'_10m =1 if time_walk>0 & time_walk<=10
		gen walk`v1'_15m =1 if time_walk>0 & time_walk<=15
		gen walk`v1'_20m =1 if time_walk>0 & time_walk<=20
		gen walk`v1'_30m =1 if time_walk>0 & time_walk<=30
		gen pubtr`v1'_05m=1 if time_pubtrans9am>0 & time_pubtrans9am<=5
		gen pubtr`v1'_10m=1 if time_pubtrans9am>0 & time_pubtrans9am<=10
		gen pubtr`v1'_15m=1 if time_pubtrans9am>0 & time_pubtrans9am<=15
		gen pubtr`v1'_20m=1 if time_pubtrans9am>0 & time_pubtrans9am<=20
		gen pubtr`v1'_30m=1 if time_pubtrans9am>0 & time_pubtrans9am<=30
		sort `v2'
		collapse (sum)radi* drive* walk* pubtr* (min)distance time_drive time_walk time_pubtrans9am, by(`v2')
		*collapse (sum)drive* (min)distance time_drive, by(mrrs`num'_vsamplelineid)
		rename distance 		min`v1'_distance
		rename time_drive		min`v1'_drive
		rename time_walk		min`v1'_walk
		rename time_pubtrans9am         min`v1'_pubtrans
		
		*if `num'>1{
		*	rename `v2'_vsamplelineid mrrs1_vsamplelineid
		*}
		sort `v2'
		save od20`v1'_collapsed`i', replace
		
		foreach var of varlist * {
			if strpos("`var'","08")>0 {
				label variable `var' "2008 "
				local vlabel : variable label `var'
				* display "`vlabel'"
				if strpos("`var'","sr_")>0 {
					label variable `var' "`vlabel'SNAP retail type=`type': counts within "
					local vlabel : variable label `var'
					* display "`vlabel'"
					if strpos("`var'","_05m")>0 {
						label variable `var' "`vlabel'5-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_10m")>0 {
						label variable `var' "`vlabel'10-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_15m")>0 {
						label variable `var' "`vlabel'15-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_20m")>0 {
						label variable `var' "`vlabel'20-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_30m")>0 {
						label variable `var' "`vlabel'30-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
				}
			}
			else if strpos("`var'","10")>0 {
				label variable `var' "2010 "
				local vlabel : variable label `var'
				* display "`vlabel'"
				if strpos("`var'","sr_")>0 {
					label variable `var' "`vlabel'SNAP retail type=`type': counts within "
					local vlabel : variable label `var'
					* display "`vlabel'"
					if strpos("`var'","_05m")>0 {
						label variable `var' "`vlabel'5-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_10m")>0 {
						label variable `var' "`vlabel'10-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_15m")>0 {
						label variable `var' "`vlabel'15-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_20m")>0 {
						label variable `var' "`vlabel'20-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_30m")>0 {
						label variable `var' "`vlabel'30-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
				}
			}
		}
		* rename vars
		label variable min`v1'_distance     "20`v3' SNAP retail type=`type': minimum Euclidean distance"
		label variable min`v1'_drive 	"20`v3' SNAP retail type=`type': minimum travel time by car"
		label variable min`v1'_walk 	"20`v3' SNAP retail type=`type': minimum travel time by walk"
		label variable min`v1'_pubtrans     "20`v3' SNAP retail type=`type': minimum travel time by public transit"
		label variable radi`v1'_1m  "20`v3' SNAP retail type=`type': counts within 1-mile radius"
		label variable radi`v1'_2m  "20`v3' SNAP retail type=`type': counts within 2-mile radius"
		label variable radi`v1'_3m  "20`v3' SNAP retail type=`type': counts within 3-mile radius"
		foreach var of varlist radi`v1'_1m-min`v1'_pubtrans{
		* foreach var of varlist drive`v1'_05m-pubtr`v1'_30m{
			local newname="`var'`type'"
			rename `var' `newname'
		}
		compress
		sort `v2'
		save od_time_all_od20`v1'`i', replace
		*capture restore
	}

	* do the following for "by grocery store type"
	forvalues i=7/10{
		local type=`i'-1
		use od20`v1'_step6, clear
		local typenum=`i'-7
		keep if grocerystoretype`v3'==`typenum'
		gen radi`v1'_1m=1 if distance>0 & distance<=1
		gen radi`v1'_2m=1 if distance>0 & distance<=2
		gen radi`v1'_3m=1 if distance>0 & distance<=3	
		gen drive`v1'_05m=1 if time_drive>0 & time_drive<=5
		gen drive`v1'_10m=1 if time_drive>0 & time_drive<=10
		gen drive`v1'_15m=1 if time_drive>0 & time_drive<=15
		gen drive`v1'_20m=1 if time_drive>0 & time_drive<=20
		gen drive`v1'_30m=1 if time_drive>0 & time_drive<=30
		gen walk`v1'_05m =1 if time_walk>0 & time_walk<=5
		gen walk`v1'_10m =1 if time_walk>0 & time_walk<=10
		gen walk`v1'_15m =1 if time_walk>0 & time_walk<=15
		gen walk`v1'_20m =1 if time_walk>0 & time_walk<=20
		gen walk`v1'_30m =1 if time_walk>0 & time_walk<=30
		gen pubtr`v1'_05m=1 if time_pubtrans9am>0 & time_pubtrans9am<=5
		gen pubtr`v1'_10m=1 if time_pubtrans9am>0 & time_pubtrans9am<=10
		gen pubtr`v1'_15m=1 if time_pubtrans9am>0 & time_pubtrans9am<=15
		gen pubtr`v1'_20m=1 if time_pubtrans9am>0 & time_pubtrans9am<=20
		gen pubtr`v1'_30m=1 if time_pubtrans9am>0 & time_pubtrans9am<=30
		sort `v2'
		collapse (sum)radi* drive* walk* pubtr* (min)distance time_drive time_walk time_pubtrans9am, by(`v2')
		*collapse (sum)drive* (min)distance time_drive, by(mrrs`num'_vsamplelineid)
		rename distance 		min`v1'_distance
		rename time_drive		min`v1'_drive
		rename time_walk		min`v1'_walk
		rename time_pubtrans9am         min`v1'_pubtrans
		
		*if `num'>1{
		*	rename `v2'_vsamplelineid mrrs1_vsamplelineid
		*}
		sort `v2'
		save od20`v1'_collapsed`i', replace
		
		foreach var of varlist * {
			if strpos("`var'","08")>0 {
				label variable `var' "2008 "
				local vlabel : variable label `var'
				* display "`vlabel'"
				if strpos("`var'","sr_")>0 {
					label variable `var' "`vlabel'SNAP store type=`typenum': counts within "
					local vlabel : variable label `var'
					* display "`vlabel'"
					if strpos("`var'","_05m")>0 {
						label variable `var' "`vlabel'5-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_10m")>0 {
						label variable `var' "`vlabel'10-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_15m")>0 {
						label variable `var' "`vlabel'15-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_20m")>0 {
						label variable `var' "`vlabel'20-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_30m")>0 {
						label variable `var' "`vlabel'30-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
				}
			}
			else if strpos("`var'","10")>0 {
				label variable `var' "2010 "
				local vlabel : variable label `var'
				* display "`vlabel'"
				if strpos("`var'","sr_")>0 {
					label variable `var' "`vlabel'SNAP store type=`typenum': counts within "
					local vlabel : variable label `var'
					* display "`vlabel'"
					if strpos("`var'","_05m")>0 {
						label variable `var' "`vlabel'5-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_10m")>0 {
						label variable `var' "`vlabel'10-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_15m")>0 {
						label variable `var' "`vlabel'15-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_20m")>0 {
						label variable `var' "`vlabel'20-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
					else if strpos("`var'","_30m")>0 {
						label variable `var' "`vlabel'30-min "
						local vlabel : variable label `var'
						* display "`vlabel'"
						if strpos("`var'","drive")>0 {
							label variable `var' "`vlabel'by car"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","walk")>0 {
							label variable `var' "`vlabel'by walk"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
						else if strpos("`var'","pubtr")>0 {
							label variable `var' "`vlabel'by public transit"
							local vlabel : variable label `var'
							* display "`vlabel'"
						}
					}
				}
			}
		}
		label variable min`v1'_distance     "20`v3' SNAP store type=`typenum': minimum Euclidean distance"
		label variable min`v1'_drive 	"20`v3' SNAP store type=`typenum': minimum travel time by car"
		label variable min`v1'_walk 	"20`v3' SNAP store type=`typenum': minimum travel time by walk"
		label variable min`v1'_pubtrans     "20`v3' SNAP store type=`typenum': minimum travel time by public transit"
		label variable radi`v1'_1m  "20`v3' SNAP store type=`typenum': counts within 1-mile radius"
		label variable radi`v1'_2m  "20`v3' SNAP store type=`typenum': counts within 2-mile radius"
		label variable radi`v1'_3m  "20`v3' SNAP store type=`typenum': counts within 3-mile radius"
		* rename vars
		foreach var of varlist radi`v1'_1m-min`v1'_pubtrans{
		* foreach var of varlist drive`v1'_05m-pubtr`v1'_30m{
			local newname="`var'`type'"
			rename `var' `newname'
		}
		compress
		sort `v2'
		save od_time_all_od20`v1'`i', replace
		*capture restore
	}

	* finally, merge all files
	forvalues i=2/10{
		use od_time_all_od20`v1'_bytype, clear
		sort `v2'
		merge 1:1 `v2' using od_time_all_od20`v1'`i'
		assert _merge==3
		drop _merge
		save od_time_all_od20`v1'_bytype, replace
	}
}
use   od_time_all_od2008sr_bytype, clear
save  request08sr, replace
use   od_time_all_od2010sr_bytype, clear
save  request10sr, replace
