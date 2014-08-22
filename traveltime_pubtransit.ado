program traveltime_pubtransit
	version 8.2 
	syntax, start_x(string) start_y(string) end_x(string) end_y(string) date(string) time(string)


	set more off
	quietly {
		tempvar dir tempdist  
		g `dir' = "r" 
		g date = "`date'"
		g time = "`time'"
		local cnt = _N   
		g days = .
		g hours =.
		g mins = .
		g traveltime_dist = .
		tempfile txtfile 
  
		forval i = 1/`cnt' {
			local sx = `start_x'[`i']
			local sy = `start_y'[`i']
			local ex = `end_x'[`i'] 
			local ey = `end_y'[`i']
			local dr = `dir'[`i'] 

			preserve
		
		  file open urlfile using "url.txt", write replace
		  file write urlfile "https://maps.google.com/maps?f=d&output=dragdir&saddr=`sy',`sx'&daddr=`ey',`ex'&date=`date'&time=`time'&dirflg=`dr'"
		  file close urlfile
		  *display `urlFile'
		  shell wget -i url.txt --no-check-certificate -O txtfile.txt
 		  * the following is old (above line changed 7-18-13 by chieko) 
		  * copy "http://maps.google.com/maps?f=d&output=dragdir&saddr=`sy',`sx'&daddr=`ey',`ex'&date=`date'&time=`time'&dirflg=`dr'" "`txtfile'", replace
		  		  		  
			insheet using txtfile.txt, clear delimiter(":") nonames
			*previously: insheet using "`txtfile'", clear delimiter(":") nonames

			keep v2

			local hashours = strmatch(v2,"*hour*")
			local hassecs = strmatch(v2,"*secs*")
			local hasmins = strmatch(v2,"*min*")
			local hasdays = strmatch(v2,"* day*")

			if `hasdays' == 0 {
				if `hashours' == 1 {
					g hours = substr(v2,strpos(v2,"hour")-2,2)
					g mins = substr(v2,strpos(v2,"min")-3,3)
					if substr(v2,strpos(v2,"min")-3,1) == "(" {
						replace mins = substr(v2,strpos(v2,"min")-2,2)
					}
					local hours = hours 
					local mins = mins 
				}
			
				if `hashours' == 0 & `hasmins' == 1 {
					g mins = substr(v2,strpos(v2,"min")-3,3)
					if substr(v2,strpos(v2,"min")-3,1) == "(" {
						replace mins = substr(v2,strpos(v2,"min")-2,2)
					}
					local mins = mins 
					local hours = 0
				}
				
				if `hassecs' == 1 {
					local mins = 0
					local hours = 0
				}
				
				if `hassecs' == 0 & `hasmins' == 0 & `hashours' == 0 {
					noisily: di "ERROR. NO OBSERVATIONS"
				}
				local days = 0
			}
			
			if `hasdays' == 1 { 
				g days = substr(v2,strpos(v2," day")-2,2) 
				local days = days 
				local hours = 0
				local mins = 0
									
				if `hashours' == 1 {
					g hours = substr(v2,strpos(v2,"hour")-3,3) 
					local hours = hours 
					local mins = 0
				}
			}
				
			split v2, parse("\")
			g `tempdist' = real(substr(v21,2,.))
			if strmatch(v2,"*;ft*") == 1 replace `tempdist' = `tempdist'/5280

			if strmatch(v2,"*;m*") == 1 replace `tempdist' = (`tempdist'/1000)/1.609344
			if strmatch(v2,"*;mi*") == 1 replace `tempdist' = (`tempdist'*1000)*1.609344
			if strmatch(v2,"*;km*") == 1 replace `tempdist' = `tempdist'/1.609344

			
			local dist = `tempdist' 
			restore

			replace traveltime_dist = `dist' in `i'

			replace hours = `hours' in `i'
			replace mins = `mins' in `i'
			replace days = `days' in `i'

			local hours = 0
			local mins = 0
			local days = 0
			local dist = 0
		 

			noisily: di "Processed " `i' " of " `cnt'
		}

		replace hours = 0 if hours == . 
		replace mins = 0 if mins == . 
		replace days = 0 if days == .
	}
		if "`km'"== "km" replace traveltime_dist = 1.609344*traveltime_dist


end

