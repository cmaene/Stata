********************************************************************************
* TO DO LIST:
* you need to generate two API key info - 
* how to: http://resources.arcgis.com/en/help/arcgis-rest-api/index.html#//02r300000268000000
* For example....
* chieko's client_id = **************************
* chieko's client_secret = **************************
********************************************************************************
program geocodeago
	version 13.0
	syntax, [address(string) city(string) state(string) zip(string) cid(string) secret(string)]
	* example:
	* geocodeago, address(address) city(city) state(state) zip(zip) cid("Bg9nOmlPqocZeMrZ") secret("872813c757284debb4a6d93e2b97223c")
	* another example using cmaene_UChicago account:
	* geocodeago, address(address) city(city) state(state) zip(zip) cid("vMsWnzQY9z7EnmOM") secret("2937af2d56a240dc80e00066dcef210d")

	* create a token for the entire operation
	* default token expiration time is 7200 minutes (or 120 hours), as of 2-19-2014
	* first create a URL - we need to save it in txt file because of HTTPS protocol..
	preserve
	
	file open tokenfile using "calltoken.txt", write replace
	* note: I am setting the expiration to 7200 minutes (or 120 hours/5 days)
	* the token "expires_in" are in seconds
	file write tokenfile "https://www.arcgis.com/sharing/oauth2/token?client_id=`cid'&grant_type=client_credentials&client_secret=`secret'&expiration=7200&f=pjson"
	file close tokenfile	
	* download a token file using wget
	shell wget -i calltoken.txt --no-check-certificate -O token.txt
	* perse the token text file
	insheet using token.txt, clear delimiter(",") nonames
	keep in 2/2
	keep v1
	local token=substr(v1,1,length(v1)-0)
	* noisily di as text "token found: `token'"
	
	restore
quietly {
	* tempfile temp_all_files txtfile ytemp_all_files
	tempvar blank work
	g `blank' = ""
	
	if "`address'" == "" local address `blank'
	if "`city'" == ""    local city    `blank'
	if "`state'" == ""   local state   `blank'
	if "`zip'" == ""     local zip     `blank'
		
	g `work' = `address' + ", " + `city' + ", " + `state' + " " + `zip'
	drop `blank' 			
	
	g long geoid = _n		

	replace `work' = " " + `work'
	replace `work' = upper(`work')
	replace `work' = subinstr(`work',"&","%26",.)
	replace `work' = subinstr(`work',"#","",.)
	replace `work' = subinstr(`work'," 01ST"," 1ST",.)
	replace `work' = subinstr(`work'," 02ND"," 2ND",.)
	replace `work' = subinstr(`work'," 03RD"," 3RD",.)
	replace `work' = subinstr(`work'," 04TH"," 4TH",.)
	replace `work' = subinstr(`work'," 05TH"," 5TH",.)
	replace `work' = subinstr(`work'," 06TH"," 6TH",.)
	replace `work' = subinstr(`work'," 07TH"," 7TH",.)
	replace `work' = subinstr(`work'," 08TH"," 8TH",.)
	replace `work' = subinstr(`work'," 09TH"," 9TH",.)
	replace `work' = trim(`work')
	replace `work' = subinstr(`work'," ","+",.)
	replace `work' = subinstr(`work',`"""'," ",.)
  	replace `work' = itrim(trim(`work'))
	replace `work' = subinstr(`work'," ","+",.)
	
	gen x =.
	gen y =.
	gen score =.
	gen addrtype= ""
	gen addrname= ""
	
	local cnt = _N 
	forval i = 1/`cnt' { 
		*tempfile dtafile`i'
		local addr = `work'[`i'] 
		if "`addr'" != "" {
			noisily di as text "ArcGIS Online Geocoding `i' of `cnt'" 
			preserve
			* concatenate all info to create a URL - we need to save it in txt file because of HTTPS protocol..
			file open urlfile using "url.txt", write replace
			file write urlfile "https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/find?text=`addr'&f=pjson&token=`token'"
			file close urlfile
			* finally - get the geocoding result using the ArcGIS online world geocoder
			shell wget -i url.txt --no-check-certificate -O returnfile.txt
			* let's parse the result
			insheet using returnfile.txt, clear delimiter(":") nonames
			gen temp=v2 if v1=="x"
			replace temp=substr(temp,1,strpos(temp,",")-1)
			destring temp, replace
			egen lon=mode(temp)
			drop temp
			gen temp=v2 if v1=="y"
			* replace temp=substr(temp,1,strpos(temp,",")-1)
			destring temp, replace
			egen lat=mode(temp)
			drop temp
			gen temp=v2 if v1=="Score"
			replace temp=substr(temp,1,strpos(temp,",")-1)
			destring temp, replace
			egen scr=mode(temp)
			drop temp
			gen temp=v2 if v1=="Addr_Type"
			egen adtype=mode(temp)
			drop temp
			gen temp=v2 if v1=="name"
			egen adname=mode(temp)
			drop temp
			local lon=lon[1]
			local lat=lat[1]
			local scr=scr[1]
			local adtype=adtype[1]
			local adname=adname[1]
			restore
			replace x = `lon' in `i'
			replace y = `lat' in `i'
			replace score = `scr' in `i'
			replace addrtype = "`adtype'" in `i'
			replace addrname = "`adname'" in `i'
		}
	}
}
	
end
		

