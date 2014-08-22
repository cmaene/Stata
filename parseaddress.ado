program parseaddress
	version 13.0
	* syntax, [address(string)]
	syntax, [address(string) city(string) state(string) zip(string)]
	* example:
	* parseaddress, address(address)

* quietly {
	if "`address'" == "" {
		gen origaddress=""
	}
	else gen origaddress=`address'
	if "`city'" == "" {
		gen origcity=""
	}
	else gen origcity=`city'
	if "`state'" == "" {
		gen origstate=""
	}
	else gen origstate=`state'
	if "`zip'" == "" {
		gen origzipcode=""
	}
	else gen origzipcode=`zip'
	gen zipcode=`zip'
	
	*gen origaddress=`origaddr'
	replace address=origaddress
	replace city=origcity
	label variable origaddress "Original address"
	label variable origcity    "Original city"
	label variable origstate   "Original state"
	label variable origzipcode "Original zip code"
	label variable address     "Parsed and cleaned address"
	label variable city        "Parsed and cleaned city"
	label variable state       "Parsed and cleaned address"
	label variable zipcode     "Parsed and cleaned city"
	order origaddress address origcity city origstate state origzipcode zipcode
	
	replace address = " " + address
	replace address = upper(address)
	* remove/replace all unnecessary symbols and characters
	replace address = subinstr(address,"1/2"," ",.)
	replace address = subinstr(address,"C/O"," ",.)
	replace address = subinstr(address,"C/0"," ",.)
	replace address = subinstr(address,"/"," ",.)
	* replace address = subinstr(address,"-"," ",.)
	replace address = subinstr(address,"&","%26",.)
	replace address = subinstr(address,"@"," AT ",.)
	replace address = subinstr(address,"*"," ",.)
	replace address = subinstr(address,":"," ",.)
	replace address = subinstr(address,"%"," ",.)
	replace address = subinstr(address,"'"," ",.)
	replace address = subinstr(address,","," ",.)
	replace address = subinstr(address,"."," ",.)
	replace address = subinstr(address,`"""'," ",.)
	replace address = itrim(trim(address))
	
	************************************************************************
	* PO BOX -
	
	* set aside PO BOX, RR (rural route), HC (highway contract)
	* brow if regexm(origaddress,"(^|[ ])(POBOX|PO BOX|P O BOX|HC|RR|R R)[ ]([0-9]+)([ ]|$)")
	gen     pobox=regexs(0) if regexm(address,"(^|[ ])(POBOX|PO BOX|P O BOX)[ ]([0-9]+)([ ]|$)")
	replace pobox=regexs(0) if regexm(address,"(^|[ ])(HC|H C|RR|R R)[ ]([0-9]+)([ ]|$)")
	replace pobox=regexs(0) if regexm(address,"(^|[ ])(HC|H C|RR|R R)[ ]([0-9]+)[ ](BOX)[ ]([0-9A-Z]+)([ ]|$)")
	* format "P O" to "PO" & "R R" to "RR" & "H C" to "HC"
	replace pobox=regexr(pobox,"(^|[ ])(P O BOX)([ ]|$)"," PO BOX ")
	replace pobox=regexr(pobox,"(^|[ ])(P O)[ ]([0-9]+)([ ]|$)"," PO ")
	replace pobox=regexr(pobox,"(^|[ ])(R R)[ ]([0-9]+)([ ]|$)"," RR ")
	replace pobox=regexr(pobox,"(^|[ ])(H C)[ ]([0-9]+)([ ]|$)"," HC ")
	
	* remove the info from address field - keep this, following order!
	replace address=regexr(address,"(^|[ ])(POBOX|PO BOX|P O BOX)[ ]([0-9]+)([ ]|$)","")
	replace address=regexr(address,"(^|[ ])(HC|RR|R R)[ ]([0-9]+)[ ](BOX)[ ]([0-9A-Z]+)([ ]|$)","")
	replace address=regexr(address,"(^|[ ])(HC|RR|R R)[ ]([0-9]+)([ ]|$)","")
	replace address=regexr(address,"[ ](BOX)[ ]([0-9]+)($)","")
	
	* trim pobox
	replace pobox = itrim(trim(pobox))
	************************************************************************
	
	* hyphen is tricky
	* delete only if it's between number and alphabet at the end(vice versa)
	replace address=regexr(address,"[ ]([#0-9]+)[-][A-Z]($)","")
	replace address=regexr(address,"[ ][A-Z][-]([#0-9]+)($)","")
	replace address=regexr(address,"[ ]([#0-9]+)[-]([#0-9]+)($)","")
	* but, replace with [space] if it's between alphabet(s) and alphabet(s)
	* replace address = subinstr(address,"-"," ",.)
	
	* symbol # can be useful to remove typical apt# information
	* gen fl3=1 if regexm(address ,"([#])")
	replace address=regexr(address,"([#]([0-9]+[A-Z]+))"," ") //#508E
	* do it again to remove repeated floor information
	replace address=regexr(address,"([#]([0-9]+[A-Z]))"," ")
	replace address=regexr(address,"([#]([0-9]+))"," ") //#105
	replace address=regexr(address,"([#]([A-Z]+))"," ") //#A
	replace address = subinstr(address,"#"," ",.)
	* clean again
	replace address = itrim(trim(address))
	
	* brow if regexm(address , "[(]")
	* remove any character, numbers & space within parenthesis
	* eg: 55 W Chesnut (apt 2501)
	replace address=regexr(address,"([(]([ A-Z0-9]+)[)])"," ")
	* remove any character, numbers & space within parenthesis
	* eg: 6700 S KEATING (SENIOR HOM 1ST FLOOR
	replace address=regexr(address,"([(]([ A-Z0-9]+))($)"," ")

	* standardize "01ST", "02ND", "03RD", "04TH"--- 
	replace address = subinstr(address," 01ST"," 1ST",.)
	replace address = subinstr(address," 02ND"," 2ND",.)
	replace address = subinstr(address," 03RD"," 3RD",.)
	replace address = subinstr(address," 04TH"," 4TH",.)
	replace address = subinstr(address," 05TH"," 5TH",.)
	replace address = subinstr(address," 06TH"," 6TH",.)
	replace address = subinstr(address," 07TH"," 7TH",.)
	replace address = subinstr(address," 08TH"," 8TH",.)
	replace address = subinstr(address," 09TH"," 9TH",.)
	replace address = subinstr(address," SO "," SOUTH ",.)
	replace address = subinstr(address," NO "," NORTH ",.)
	replace address = subinstr(address," VLVD"," BLVD",.)
	
	* remove FLOOR information -
	* gen flag=1 if regexm(address , "(^|[ ])(F|FL|FLR|FLOOR)([ ]|$)")
	replace address=regexr(address,"(^|[ ])([0-9]+)(ST|ND|RD|TH)[ ](F|FL|FLR|FLOO|FLOOR)([ ]|$)"," ")
	* do it again to remove repeated floor information, eg: 6214 S. LANGLEY,1ST FL 1ST FL
	replace address=regexr(address,"(^|[ ])([0-9]+)(ST|ND|RD|TH)[ ](F|FL|FLR|FLOO|FLOOR)([ ]|$)"," ")
	* similar -some forgot [space] in front
	replace address=regexr(address,"([0-9]+)(ST|ND|RD|TH)[ ](F|FL|FLR|FLOO|FLOOR)([ ]|$)"," ")
	replace address=regexr(address,"(^|[ ])(FIRST|SECOND|THIRD|FOURTH|FIFTH|SIXTH|SEVENTH|EIGHTH|NINTH)[ ](F|FL|FLR|FLOO|FLOOR)([ ]|$)"," ")
	* similar -some forgot [space] in front
	replace address=regexr(address,"(FIRST|SECOND|THIRD|FOURTH|FIFTH|SIXTH|SEVENTH|EIGHTH|NINTH)[ ](F|FL|FLR|FLOO|FLOOR)([ ]|$)"," ")
	replace address=regexr(address,"(^|[ ])(FL|FLR|FLOOR)[ ]([0-9]+)([ ]|$)"," ")
	* do it again to remove repeated floor information
	replace address=regexr(address,"(^|[ ])(FL|FLR|FLOOR)[ ]([0-9]+)([ ]|$)"," ")
	replace address=regexr(address,"([ ])([0-9]+)(F|FL|FLR|FLOOR)([ ]|$)"," ")
	replace address=regexr(address,"([ ])([0-9]+)[ ](F|FL|FLR|FLOOR)([ ]|$)"," ")
	
	replace address = subinstr(address,"-"," ",.)
	
	* trim again
	replace address = itrim(trim(address))
	
	*replace address = subinstr(address," AP ","",.)

	* gen flagroom=1 if regexm(address,"(^|[ ])(APT|HSE|NBR|ROOM|TOWNHOUSE|UNIT|BASEMENT|STE|SUITE|ROOM|RM)([ ]|$)") & addrtype!="StreetAddress" & addrtype!="PointAddress"
	replace address=regexr(address,"(^|[ ])(APT|HSE|NBR|ROOM|RM|STE|SUITE|SUITES|UNIT)[ ]([A-Z0-9]+)([ ]|$)"," ")
	* do it again to remove repeated floor information
	replace address=regexr(address,"(^|[ ])(NBR|ROOM|RM|STE|SUITE|UNIT)[ ]([A-Z0-9]+)([ ]|$)"," ")
	* APT plus number, only at the end
	replace address=regexr(address,"(^|[ ])(APT)[ ]([A-Z0-9]+)($)"," ")
	* do it again to remove repeated floor information
	replace address=regexr(address,"(^|[ ])(APT)[ ]([A-Z0-9]+)($)"," ")
	replace address=regexr(address,"(^|[ ])(AP)[ ]([A-Z0-9]+)([ ]|$)"," ")
	
	replace address = subinstr(address,"APARTMENT"," ",.)
	replace address = subinstr(address,"BASEMENT"," ",.)
	replace address = subinstr(address,"BSMNT"," ",.)
	replace address = subinstr(address,"NURSING HOME","",.)
	replace address = subinstr(address,"NURSING HME ","",.)
	replace address = subinstr(address,"NURSING HM","",.)
	replace address = subinstr(address,"NURSING H","",.)
	replace address = subinstr(address,"NURSING ","",.)
	replace address = subinstr(address,"TOWNHOUSE"," ",.)
	replace address = subinstr(address,"TWNHOUSE"," ",.)
	replace address = subinstr(address," UNIT "," ",.)
	* clean it again - there are many with extra building info at the end..
	* make sure they canNOT be a street name (i.e. could there be "405 S HOUSE" address?? -if so, exclude)
	replace address=regexr(address,"(^|[ ])(APT|HSE|NURSING|RM|STE|SUITE|UNIT|CTR)($)"," ")

	* trim again
	replace address = itrim(trim(address))

	* get rid of extra text before address number starts
	gen ad3=address
	replace address=regexr(address,"^([A-Z]+)[ ]([A-Z]+)[ ]([A-Z]+)[ ]([A-Z]+)[ ]"," ")
	replace address=regexr(address,"^([A-Z]+)[ ]([A-Z]+)[ ]([A-Z]+)[ ]"," ")
	replace address=regexr(address,"^([A-Z]+)[ ]([A-Z]+)[ ]"," ")
	replace address=ad3 if regexm(ad3,"^([A-Z]+)[ ]([A-Z]+)[ ](AT|AND)[ ]")
	replace address=ad3 if regexm(ad3,"^([A-Z]+)[ ](AT|AND)[ ]")
	drop ad3

	* wish list - format IllinoisWisconsinNumbering streets
	* below catches "(numbers) (direction) (numbers)" kind of street address
	* for ArcGIS onine geocoder, these have to be concatenated into one string
	* but how can I differenciate IWnumbering addresses and similar regular street addresses?
	* flagiw=1 if regexm(address,"^([0-9]+)[ ](S|W|N|E)[ ]([0-9]+)[ ]")
	
	* ArcGIS online is not good at ignoring information, sad..

	replace address = trim(address)
	replace address = subinstr(address,`"""'," ",.)
  	replace address = itrim(trim(address))
	
	************************************************************************
	* CITY 
	
	replace city = " " + city
	replace city = upper(city)
	* remove/replace all unnecessary symbols and characters
	replace city = subinstr(city,"/"," ",.)
	replace city = subinstr(city,"-"," ",.)
	replace city = subinstr(city,"_"," ",.)
	replace city = subinstr(city,"&"," ",.)
	replace city = subinstr(city,"@"," ",.)
	replace city = subinstr(city,"*"," ",.)
	replace city = subinstr(city,":"," ",.)
	replace city = subinstr(city,"%"," ",.)
	replace city = subinstr(city,"'"," ",.)
	replace city = subinstr(city,","," ",.)
	replace city = subinstr(city,"."," ",.)
	replace city = subinstr(city,`"""'," ",.)
	replace city = itrim(trim(city))
	
	* sometimes numbers appear in city.. shouldn't be
	replace city=regexr(city,"(^|[ ])([0-9]+)([ ]|$)"," ")
	* repeat in case there is another number cluster
	replace city=regexr(city,"(^|[ ])([0-9]+)([ ]|$)"," ")
	
	* standardize variations.. often found in our geocoding
	replace city=regexr(city,"(^|[ ])(CHCAGO|CHICGO|CICAGO|CHICAG|CHCGO|CHIACGO|CHIAGO|HICAGO|CHCIAGO|CCHICAGO|CHGO|CHICA)([ ]|$)"," CHICAGO ")
	replace city=regexr(city,"(^|[ ])(HEIGHT|HEGHT|HEGHTS|HEIGT|HEIGTS|HIGHT|HIGHTS|HTG|HTGS|HGTS|HTS|HEIG|HEIGS)([ ]|$)"," HEIGHTS ")
	replace city=regexr(city,"(^|[ ])(HILL|HLS|HILLSS)($)"," HILLS")
	replace city=regexr(city,"([ ])(HI|HL)($)"," HILLS")
	replace city=regexr(city,"(^|[ ])(C C|C CLUB|CNTRY CLUB|C CLB|COUNTRY CLB|COUNT CLB|CNTRY CLB|CNTRY CL)([ ])"," COUNTRY CLUB ")
	replace city = subinstr(city,"COUNTRYCLUB"," COUNTRY CLUB ",.)
	replace city = subinstr(city,"CNTRYCLUB"," COUNTRY CLUB ",.)
	replace city=regexr(city,"(^|[ ])(DE KALAB|DE KALB|DEKALAB)([ ]|$)"," DEKALB ")
	replace city=regexr(city,"(^|[ ])(GR|GRV|GROV)([ ]|$)"," GROVE ")
	* replace city=regexr(city,"(^|[ ])(VL|VILL)([ ]|$)","VILLA") //don't know if VILLAGE or VILLA..
	replace city=regexr(city,"(^|[ ])(VILG|VILLG|VLG)([ ]|$)"," VILLAGE ")
	replace city=regexr(city,"(^|[ ])(PK|PAK|PAR|PA)($)"," PARK")
	replace city=regexr(city,"(^)(UNIVERSITY P)($)","UNIVERSITY PARK")
	replace city=regexr(city,"(^|[ ])(TR|TER|TERR|TERRA|TERRAC)($)"," TERRACE")
	replace city=regexr(city,"(^|[ ])(FIEL|FIELD|FIE|FLDS)($)"," FIELDS")
	replace city=regexr(city,"(^|[ ])(FORES|FORE|FORST)($)"," FOREST")
	replace city=regexr(city,"(^|[ ])(ESTATE|ESTAT|ESTA|EST)($)"," ESTATES")
	replace city=regexr(city,"(^|[ ])(PROSPEC|PROSPE|PROSP)($)"," PROSPECT")
	replace city=regexr(city,"(^|[ ])(MDWS|MEAD|MEAD|MEADOW)($)"," MEADOWS")
	replace city=regexr(city,"(^|[ ])(RIDG)($)"," RIDGE")
	replace city=regexr(city,"(^|[ ])(SPGS|SPRGS|SPRING|SPRIN|SPRI)($)"," SPRINGS")
	replace city=regexr(city,"([ ])(HBR|HARBR|HARBO)($)"," HARBOR")
	replace city=regexr(city,"([ ])(SHOR|SHR|SHO)($)"," SHORE")
	replace city=regexr(city,"^(NO|N)([ ])","NORTH ")
	replace city=regexr(city,"^(SO|S)([ ])","SOUTH ")
	replace city=regexr(city,"^(W)([ ])","WEST ")
	replace city=regexr(city,"^(E)([ ])","EAST ")
	replace city=regexr(city,"(^|[ ])(MT|MONT)([ ]|$)"," MOUNT ")
	replace city=regexr(city,"(^|[ ])(SAINT)([ ])"," ST ")
	
	* popular problem - cities with no space
	replace city = subinstr(city,"CHICAGOHEIGHTS"," CHICAGO HEIGHTS ",.)
	replace city = subinstr(city,"SANDIEGO"," SAN DIEGO ",.)
	replace city = subinstr(city,"NEWORLEANS"," NEW ORLEANS ",.)
	* district of columbia - just in case
	replace city=regexr(city,"(^)(D C|DISTRICT OF COLUMBIA|DIST COLUMBIA)($)"," DC ")
	replace city=regexr(city,"(^)(NY|NEWYORK|NYC)($)"," NEW YORK ")
	replace city=regexr(city,"(^)(LA|LOSANGELES)($)"," LOS ANGELES ")
	
	replace city=regexr(city,"(^|[ ])(CNTRY|COUNT)([ ]|$)"," COUNTRY ")
	replace city=regexr(city,"(^|[ ])(CTY|CIT)([ ]|$)"," CITY ")
	replace city=regexr(city,"(^|[ ])(TOWNSHP|TOWNSH|TOWNSP|TWNSH|TWNSH|TWNSHP)([ ]|$)"," TOWNSHIP ")
	
	replace city = itrim(trim(city))
	
	************************************************************************
	* lastly.. if address has no value, replace it with zip code info
	* because ArcGIS online handle empty address field, differently..
	* see under "searching for postal codes"
	* http://resources.arcgis.com/en/help/arcgis-rest-api/index.html#/Single_input_field_geocoding/02r300000015000000/
	
	* BUT, this is ok but not a perfect solution
	* may want to improve this later
	* ideal output: "zipcode + city + USA" option -
	
	replace address=zipcode if address==""
	replace state="USA" if address==""
	************************************************************************
/*
replace type=itrim("MINI MART") if regexm( SR10_STORENAME , "(^|[ ])(MINI)([ ]|$)")
replace type=itrim("PARTY STORE") if regexm( SR10_STORENAME , "(^|[ ])(PARTY)([ ]|$)")
replace type=trim("BAKERY") if regexm( SR10_STORENAME , "(^|[ ])(BAKERY|WONDER HOSTESS)([ ]|$)")
* replace type=trim(regexs(0)) if regexm( SR10_STORENAME , "(^|[ ])LIQUOR([ ]|$)")
replace type=itrim("LIQUOR STORE") if regexm( SR10_STORENAME , "(^|[ ])(LIQUOR|WINE|BEER|VINYARDS|VINERY)([ ]|$)")
replace type=itrim("GAS STATION") if regexm( SR10_STORENAME , "(^|[ ])(GAS|GASOLINE|PETROLEUM|PETRO|PETROL|FUEL|FUELS|OIL|AUTO|CITGO|SHELL|SPEEDY Q|SPEEDWAY)([ ]|$)")
replace type=itrim("DOLLAR SHOP") if regexm( SR10_STORENAME , "(^|[ ])(DOLLAR|DOLLARTREE)([ ]|$)")
replace type=itrim("DRUG STORE") if regexm( SR10_STORENAME , "(^|[ ])(CVS|WALGREENS|DRUGS|RITE AID|PHARMACY)([ ]|$)")
replace type=itrim("MJR CONVNC") if regexm( SR10_STORENAME , "(^|[ ])(7[ \-]ELEVEN|SEVEN[ \-]ELEVEN|CIRCLE K)([ ]|$)")
replace type=itrim("MJR GROCERY") if regexm( SR10_STORENAME , "(^|[ ])(GORDON FOOD|GFS|KROGER|TRADER JOE('*)S|WAL[ \-]MART|SAVE[ \-]A[ \-]LOT|WHOLE FOODS)([ ]|$)")
replace type=itrim("MJR GROCERY") if regexm( SR10_STORENAME , "(^|[ ])(ALDI|TARGET|MEIJER|FOOD[ \-]4[ \-]LESS|KMART|JOE RANDAZZOS)([ ]|$)")
replace type=itrim("MJR GROCERY") if regexm( SR10_STORENAME , "(^|[ ])(IN[ \-]N[ \-]OUT|IN & OUT|FARMER JACK|BUSCH('*)S VALU LAND|HILLER('*)S MARKET)([ ]|$)")
replace type=itrim("MJR GROCERY") if regexm( SR10_STORENAME , "(^|[ ])(HOLLYWOOD SUPER MARKET|HOLLYWOOD MARKET|V( )*G('*)S FOOD|GLORY FOODS|V( )*G('*) FOODS|GLORY SUPERMARKET)([ ]|$)")
*/
*}*/
keep  origaddress address origcity city origstate state origzipcode zipcode pobox
order origaddress address origcity city origstate state origzipcode zipcode pobox
save testaddresses_arcgisproblemaddress_cleaned, replace
end
