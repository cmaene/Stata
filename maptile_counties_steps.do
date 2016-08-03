******************
* preparation
* install files
* ref: https://michaelstepner.com/maptile/
* ref: http://files.michaelstepner.com/maptile%20slides%202015-03%20_handout.pdf
******************

*install additional program files

ssc install spmap
ssc install maptile

* install state geography - will be used as state outline in county mapping
* new geography files will be install in (user root)/ado/personal/maptile_geographies
* may try: adodir

maptile_install using "http://files.michaelstepner.com/geo_state.zip", replace

* install 1990, 2000, 2010, 2014 county geography - newly created but the structure is the same as 1990 county
* source: https://www.census.gov/geo/maps-data/data/cbf/cbf_counties.html
* new geography files will be install in (user root)/ado/personal/maptile_geographies

maptile_install using "http://home.uchicago.edu/~cmaene/geo_county2014.zip", replace
maptile_install using "http://home.uchicago.edu/~cmaene/geo_county2010.zip", replace
maptile_install using "http://home.uchicago.edu/~cmaene/geo_county2000.zip", replace
maptile_install using "http://files.michaelstepner.com/geo_county1990.zip", replace


******************
* mapping data
* ready to generate 1990-2014 county mapping with sample 2014 ACS data!
* ref: "help maptile" in stata - many examples!
******************

* set a working directory, which has the county data file with variables we want to map
cd /media/cmaene/Projects/ProfTintelnot

* open county data file with variables to map

use counties_acs2014, clear
* use XXXXXXXXXXXXXX, clear

/*****************
* make sure your county data file includes "county" variable
* this "county" variable will be used to merge data with map/geography file
* county (lowercase name): 4-5 digit integer, unique, county ID
* if your county data file doesn't include "county" ID, generate using what you have in the file

* e.g. 
* my ACS county data from SocialExplorer includes character/string 5-digit county ID, called GEOID
* I need to generate a new variable, county (numeric/int), by converting GEOID (char/string)

destring(GEOID), gen(county)

* here is the example of county ID
list GEOID county in 1/1

     +----------------+
     | GEOID   county |
     |----------------|
  1. | 01003     1003 |
     +----------------+
*****************/

* let's test them - if run through without errors, the geographpy files seem to be ok
* check "exampleXXXX.png" for savegraph outputs
local years 1990 2000 2010 2014
foreach yr of local years {

	* total population (T001_001) with state outline
	maptile T001_001, geography(county`yr') stateoutline(state)
	
	* total population (T001_001) with state outline, but without Alaska & Hawaii
	maptile T001_001, geography(county`yr') stateoutline(state) conus

	* median age (T012_001) using different color scheme, no state outline
	* reference: "help spmap" in State, look under "Color Lists"
	maptile T012_001, geography(county`yr') fcolor(GnBu)

	* median age (T012_001) using "proportionally-spaced colors", no state outline
	maptile T012_001, geography(county`yr') propcolor

	* median age (T012_001) using different class values with state outline, AND save as "example.png"
	maptile T012_001, geography(county`yr') cutvalues(30(10)60) stateoutline(state) savegraph(example`yr'.png) replace

	* map Illinois only (i.e. my county data has "STATE" variable I can use)
	maptile T012_001, geography(county`yr') cutvalues(30(10)60) mapif(STATE=="17")
}
