// v1.0 (1404 Aban 22)

*******************************************
*							   			  *
*	 Program 2.1: Cleaning; mapex_con     *
*							   			  *
*******************************************

/* Clean The Imported Excel File --------------------------------------------------------------------- */

program def mapex_con
	version 17.0
	// program body
	qui {
	    cls
	    macro drop _all
		duplicates drop
		
		/* Checking Dependencies---------------------------------------------------------------------- */
		
		cap which missings
		if _rc {
		    noi di _newline(5) "This package is required. Please install it from Link: {stata ssc install missings}"
			noi di _newline(2) "After installation Try again with This Link {stata mapex_con: Continue}"
			exit
		}


		/* Checking if Any Data Imported-------------------------------------------------------------- */

		desc
		local varcount = `r(k)'
		cap ren * Q#, renum(1)
		if _rc {
			noi di as error "There is no data here"
			exit
		}

		/* Check if it Is First Time that User Clicks on Link----------------------------------------- */
		local label_exist: variable label Q1
		if "`label_exist'" == "" {

			/* Dropping All Missing Rows and Columns-------------------------------------------------- */

			missings dropobs, force
			missings dropvars, force


			/* Dropping if Nonmissing Cells of a Row Is Not Greater than 70 Percent of All Column counts-- */

			desc
			local varcount = r(k)
			local miss_treshold = `varcount' / 100 * 80
			tempvar miss_count
			egen `miss_count' = rowmiss(*)
			tempvar drop_tag
			gen `drop_tag' = 0
			local obs = _N
			forv i = 1 / `obs' {
				if `miss_count'[`i'] > `miss_treshold' {
					replace `drop_tag' = 1 in `i'
				}
			}
			drop if `drop_tag'
			drop `drop_tag'


			/* Labeling the Variables using Data---------------------------------------------------------- */

			forv i = 1 / `varcount' {
				cap gen real_Q`i' = real(Q`i')
			}
			tempvar label_rows
			missings tag real_*, gen(`label_rows')
			drop real_*

			// if All Strings or Containing Empty Cells
			count if `label_rows' == `varcount' | `miss_count' != 0
			local label_rows_count = r(N)
			if `label_rows_count' == 0 {
				forv v = 1 / `varcount' {
					local labvarQ`v' = Q`v'[1]
					lab var Q`v' "`labvarQ`v''"
				}
				cap drop in 1	
			}

			else {
				forv v = 1 / `varcount' {
					forv z = 1 / `label_rows_count' {
						local labvarQ`v' = "`labvarQ`v''" + " " + Q`v'[`z']
						lab var Q`v' "`labvarQ`v''"
					}
				}
				cap drop in 1 / `label_rows_count'
			}
			drop `label_rows'


			/* Finding Last String Row to Label the Variales---------------------------------------------- */


			destring _all, replace
			ren * Q#, renum(1)
			drop `miss_count'
			noi di _newline(3) "Press This Link after Importing {stata mapex_con: Continue} {hline}" _newline(3) // Calling the second program	
			db mapex_var
		}
		else {
		    noi di _newline(3) "Press This Link after Importing {stata mapex_con: Continue} {hline}" _newline(3) // Calling the second program	
		    db mapex_var
		}
	}
end
