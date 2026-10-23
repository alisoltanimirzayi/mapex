// v1.0 (1404 Aban 22)

*******************************************
*							   			  *
*	Program 2.2.2: mapex_var_continue     *
*							   			  *
*******************************************

/* Calling Dialog Box for Map Feature----------------------------------------------------------------- */

program mapxdtail_call
	version 17.0
	qui {
		cls
		
		// Checking Dependencies---------------------------------------------------------------------- */
		
		local programs_required ""
		
		// Geoplot
		
		cap which geoplot
		if _rc {
		    noi di _newline(2) "This package is required. Please install it from Link: {stata ssc install geoplot}"
			local programs_required `programs_required' 1
		}
		
		// Colorpalette
		cap which colorpalette
		if _rc {
		    noi di _newline(2) "This package is required. Please install it from Link: {stata ssc install palettes}"
			local programs_required `programs_required' 1
		}
		
		// Colrspace
		cap which colrspace.sthlp
		if _rc {
		    noi di _newline(2) "This package is required. Please install it from Link: {stata ssc install colrspace}"
			local programs_required `programs_required' 1
		}
		
		// Moremata
		cap which moremata.hlp
		if _rc {
		    noi di _newline(2) "This package is required. Please install it from Link: {stata ssc install moremata}"
			local programs_required `programs_required' 1
		}
		
		cap which reclink
		if _rc {
		    noi di _newline(2) "This package is required. Please install it from Link: {stata ssc install reclink}"
			local programs_required `programs_required' 1
		}
		
		if strpos("`programs_required'", "1") == 1 {
			noi di _newline(2) "After installation Try again with This Link {stata mapxdtail_call: Continue}"
			exit
		}
		
		db mapex_details
	}
end
