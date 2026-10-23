// v1.0 (1404 Aban 22)

****************************************
*									   *
*   Program 1.1: Import Excel; mapex   *
*									   *
****************************************
// program signature
program def mapex
	version 17.0
	// program body
	qui {
		discard
		cap window stopbox rusure "برای کشیدن نقشه نیازه که فایل اکسل رو بهم بدی، میخوای ادامه بدیم؟" // yes-no box
		if !_rc {
			db import_excel // Opening the dialog box
			window stopbox note "بعد از وارد شدن کامل دیتا، روی لینک کلیک کن"
		}
		else {
			exit
		}
	}
	cls
	noi di _newline(3) "Press This Link after Importing {stata mapex_con: Continue} {hline}" _newline(3) // Calling the second program	
end
