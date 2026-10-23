// v1.0 (1404 Aban 22)

****************************************
*									   *
*   Program 3.1: geoplot; mapex_done   *
*									   *
****************************************
program define mapex_done
	version 17.0
	qui {
		cls


		/* Probabilistic Linking with Province Names-------------------------------------------------- */

	    cap confirm var _CX
		if _rc {
		    cap ren $ostanvar Ostan_Name
			cap replace Ostan_Name = strtrim(Ostan_Name)
			cap replace Ostan_Name = stritrim(Ostan_Name)
			cap gen idmaster = _n
			reclink Ostan_Name using "`c(sysdir_plus)'\m\map.dta" ///
				, idmaster(idmaster) ///
				idusing(idusing) ///
				gen(recmerg) ///
				wmatch(20) ///
				wnomatch(4)

			/* Check if Data Is Valid and Contains Provinces ----------------------------------------- */

			count if _merge == 1
			if r(N) > 2 {
				window stopbox note "به نظر میاد داده‌ی استانت مشکل داره. مطمئن شو که اسم 31 استان توی داده‌ای که دادی وجود داره. اگه درست بود از انتخاب متغیر استان مطمئن شو"
				exit
			}
			cap drop if _merge == 1
			
			/* Checking if Data is Aggregated--------------------------------------------------------- */
			local obs = _N
			if `obs' > 31 {
				window stopbox note "به نظر میاد داده‌ی استانت مشکل داره. مطمئن شو که داده‌ی هر استان فقط یک بار تکرار شده یا اسم اضافه وجود نداشته باشه"
				exit
			}
			
			
			/* Create the label variable-------------------------------------------------------------- */
			
			tempvar label_var
			gen `label_var' = round($vartoplot, .01)
	
			
			/* Save The Data So We Can Create the Frame----------------------------------------------- */
			
			cap save "`c(sysdir_plus)'\m\map_test.dta", replace


			/* Setting the Geoframe of the Map-------------------------------------------------------- */

			geoframe create ///
				"`c(sysdir_plus)'/m/map_test" ///
				, shp("`c(sysdir_plus)'/m/map_shp") replace
			geoframe create Sea ///	
				using "`c(sysdir_plus)'/m/mapSee_Iran" ///
				, shp("`c(sysdir_plus)'/m/mapSee_Iran_shp") replace
		}
		
		else {

			/* creating the tempvar again for second plot*/ 
			tempvar label_var
			gen `label_var' = round($vartoplot, .01)		
			

			/* creating geoframe again */
			geoframe create ///
				"`c(sysdir_plus)'/m/map_test" ///
				, shp("`c(sysdir_plus)'/m/map_shp") replace
			geoframe create Sea ///	
				using "`c(sysdir_plus)'/m/mapSee_Iran" ///
				, shp("`c(sysdir_plus)'/m/mapSee_Iran_shp") replace

		}
		

		/* Specify Format of The Legend Labels-------------------------------------------------------- */

		if "$ed_cut" != "" {
			local word_2of_edcut: word 2 of $ed_cut
			local formt_legs = length(substr("`word_2of_edcut'",(strpos("`word_2of_edcut'", ".")), .))
			if `formt_legs' { // if it's not equal to zero, or the educt doesn't have any decimal
				local formt_legs = `formt_legs' - 1
			}
		}
		else {
		    local sample_number = $vartoplot[1]
			local decimal_exist = substr("`sample_number'", strpos("`sample_number'", "."), .)
			if "`decimal_exist'" == "" {
				local formt_legs = 0
			}
			else {
				local formt_legs = 2
			}
		}


		/* Getting Labels of Legend from User Cuts---------------------------------------------------- */

		local i = 0
		local legs_label ""
		foreach v of global ed_cut {
			local ++i
			local i_next = `i' + 1
			local x: word count $ed_cut
			local y: word `i' of $ed_cut
			local z: word `i_next' of $ed_cut
			if `i_next' > `x' {
			    continue, break
			}
			local legs_label `legs_label' label("`y'-`z'")
		}


		/* Prepare Cuts or Levels Specified by the User----------------------------------------------- */

		local cuts cuts($ed_cut)
		local levels levels($spin_cut)


		/* Make the Plot Repeatable------------------------------------------------------------------- */

		noi di _newline(5) "Press This Link To Create Another Plot {stata qui db mapex_details: Plot} {hline}"

		
		/* save the provinces value to place on the map */
		
		sort _ID
		local label_val1 = round(`label_var'[1], .01)
		local label_val2 = round(`label_var'[2], .01)
		local label_val3 = round(`label_var'[3], .01)
		local label_val4 = round(`label_var'[4], .01)
		local label_val7 = round(`label_var'[7], .01)
		local label_val10 = round(`label_var'[10], .01)
		local label_val11 = round(`label_var'[11], .01)
		local label_val23 = round(`label_var'[23], .01)
		local label_val28 = round(`label_var'[28], .01)
		local label_val29 = round(`label_var'[29], .01)
		
		
		
		
		/* Final Geoplot------------------------------------------------------------------------------ */

		colorpalette "$color_select1" "$color_select2", n($spin_cut) nograph
		geoplot ///
			(area map_test $vartoplot, `levels' `cuts' col(`r(p)') label(, format(%9.`formt_legs'f))) ///
			(area Sea, col("220 253 254")) ///
			(line Sea, col(black%70) lwidth(vvthin)) ///
			(line map_test, col(black) lwidth(0.14)) ///
			(label map_test UOstan_Name ///
			if !inlist(_ID, 4, 10, 16, 28, 29, 19), ///
			col("$color_label") size(2)) ///
			(label map_test `label_var' if inrange(_ID, 15, 17) | inrange(_ID, 24, 27) | inlist(_ID, 5, 6, 9, 12, 13, 19, 30, 31), ///
			col($color_number) size(2) gap(2) pos(6)) ///
			(label map_test `label_var' if inlist(_ID, 18, 14, 21, 8, 20, 22), ///
			col($color_number) size(2) gap(1) pos(6)) ///
			, legend(pos(swest)) ///
			text(-107.60 168.16 "هرمزگان", col($color_label) size(2)) ///
			text(-99.95 160.8 "آذربایجان غربی", col($color_label) size(2)) ///
			text(-104.82 164.10 "کهگیلویه و", col($color_label) size(2)) ///
			text(-105.04 164.10 "بویراحمد", col($color_label) size(2)) ///
			text(-103.70 163.86 "چهارمحال و", col($color_label) size(2)) ///
			text(-104 164.05 "بختیاری", col($color_label) size(2)) ///
			text(-100.95 164.62 "تهران", col($color_label) size(2)) ///
			text(-101.86 163.30 "مرکزی", col($color_label) size(2)) ///
			text(-100.4 164.15 "`label_val1'", col($color_number) size(2)) ///
			text(-98.7 162.3 "`label_val2'", col($color_number) size(2)) ///
			text(-106.97 164.7 "`label_val3'", col($color_number) size(2)) ///
			text(-104.3 164.2 "`label_val4'", col($color_number) size(2)) ///
			text(-99.7 163.4 "`label_val7'", col($color_number) size(2)) ///
			text(-107.8 167.5 "`label_val10'", col($color_number) size(2)) ///
			text(-103.3 161.6 "`label_val11'", col($color_number) size(2)) ///
			text(-101.48 164.3 "`label_val23'", col($color_number) size(2)) ///
			text(-100.75 164.7 "`label_val28'", col($color_number) size(2)) ///
			text(-99.75 160.35 "`label_val29'", col($color_number) size(2)) ///
			project(webmercator)
	}
end

